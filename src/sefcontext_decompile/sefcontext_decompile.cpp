/**
 * File            : src/sefcontext_decompile/sefcontext_decompile.cpp
 * Original Author : wuxianlin
 * Original Source : https://github.com/wuxianlin/sefcontext_decompile
 */

/**
 * src/sefcontext_decompile/sefcontext_decompile.cpp
 * Copyright (c) 2019 <wuxianlin@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <getopt.h>

#define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a

static __attribute__ ((__noreturn__)) void usage(const char *progname)
{
	fprintf(stderr,
	    "usage: %s [-o out_file] file_contexts.bin\n",
	    progname);
		exit(EXIT_FAILURE);
}

static int process_file(const char *filename, const char *out_filename)
{
	int rc;
	size_t len;
	FILE *bin_file = fopen(filename, "rb");
	if(bin_file==NULL)
	{
		printf("could not open: %s\n", filename);
		exit(EXIT_FAILURE);
	}
	FILE* out_file = fopen(out_filename, "w");
	if(out_file==NULL)
	{
		printf("could not open: %s\n", out_filename);
		exit(EXIT_FAILURE);
	}

	uint32_t magic;
	len = fread(&magic, sizeof(uint32_t), 1, bin_file);
	if (len != 1)
		goto err;
	//printf("magic:%d\n", magic);
	if (magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
	{
		printf("Unrecognized file format\n");
		goto err;
	}

	uint32_t version;
	len = fread(&version, sizeof(uint32_t), 1, bin_file);
	if (len != 1)
		goto err;
	//printf("version:%d\n", version);

	if (version <= 4)
	{
		uint32_t pcre_version_len;
		len = fread(&pcre_version_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("pcre_version_len:%d\n", pcre_version_len);
		char pcre_version[pcre_version_len + 1];
		len = fread((char *) pcre_version, sizeof(char), pcre_version_len, bin_file);
		if (len != pcre_version_len)
			goto err;
		pcre_version[pcre_version_len] = 0;
		//printf("pcre_version:%s\n", pcre_version);
	} else {
		uint32_t reg_version_len;
		len = fread(&reg_version_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("reg_version_len:%d\n", reg_version_len);
		char reg_version[reg_version_len + 1];
		len = fread((char *) reg_version, sizeof(char), reg_version_len, bin_file);
		if (len != reg_version_len)
			goto err;
		reg_version[reg_version_len] = 0;
		//printf("reg_version:%s\n", reg_version);

		uint32_t reg_arch_len;
		len = fread(&reg_arch_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("reg_arch_len:%d\n", reg_arch_len);
		char reg_arch[reg_arch_len + 1];
		len = fread((char *) reg_arch, sizeof(char), reg_arch_len, bin_file);
		if (len != reg_arch_len)
			goto err;
		reg_arch[reg_arch_len] = 0;
		//printf("reg_arch:%s\n", reg_arch);
	}

	uint32_t num_stems;
	len = fread(&num_stems, sizeof(uint32_t), 1, bin_file);
	if (len != 1)
		goto err;
	//printf("num_stems:%d\n", num_stems);

	for (unsigned int i = 0; i < num_stems; i++)
	{
		uint32_t stem_len;
		len = fread(&stem_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("stem_len:%d\n", stem_len);
		char stem[stem_len + 1];
		len = fread((char *) stem, sizeof(char), stem_len + 1, bin_file);
		if (len != stem_len+1)
			goto err;
		stem[stem_len] = 0;
		//printf("stem:%s\n", stem);
	}

	uint32_t nspec;
	len = fread(&nspec, sizeof(uint32_t), 1, bin_file);
	if (len != 1)
		goto err;
	//printf("nspec:%d\n", nspec);

	for (unsigned int i = 0; i < nspec; i++)
	{
		uint32_t context_len;
		len = fread(&context_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("context_len:%d\n", context_len);
		char context[context_len];
		len = fread((char *) context, sizeof(char), context_len, bin_file);
		if (len != context_len)
			goto err;
		//printf("context:%s\n", context);

		uint32_t regex_str_len;
		len = fread(&regex_str_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("regex_str_len:%d\n", regex_str_len);
		char regex_str[regex_str_len];
		len = fread((char *) regex_str, sizeof(char), regex_str_len, bin_file);
		if (len != regex_str_len)
			goto err;
		//printf("regex_str:%s\n", regex_str);

		fprintf(out_file, "%s\t%s\n", regex_str, context); 
		//printf("%s\t%s\n",regex_str, context);

		uint32_t mode;
		len = fread(&mode, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("mode:%d\n", mode);

		int32_t stem_id;
		len = fread(&stem_id, sizeof(int32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("stem_id:%d\n", stem_id);

		uint32_t hasMetaChars;
		len = fread(&hasMetaChars, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("hasMetaChars:%d\n", hasMetaChars);

		uint32_t prefix_len;
		len = fread(&prefix_len, sizeof(uint32_t), 1, bin_file);
		if (len != 1)
			goto err;
		//printf("prefix_len:%d\n", prefix_len);

		if (version <= 4)
		{
			uint32_t pcre_info_len;
			len = fread(&pcre_info_len, sizeof(uint32_t), 1, bin_file);
			if (len != 1)
				goto err;
			//printf("pcre_info_len:%d\n", pcre_info_len);
			char pcre_info[pcre_info_len];
			len = fread((char *) pcre_info, sizeof(char), pcre_info_len, bin_file);
			if (len != pcre_info_len)
				goto err;
			//printf("pcre_info:%s\n", pcre_info);

			uint32_t pcre_info_study_daya_len;
			len = fread(&pcre_info_study_daya_len, sizeof(uint32_t), 1, bin_file);
			if (len != 1)
				goto err;
			//printf("pcre_info_study_daya_len:%d\n", pcre_info_study_daya_len);
			char pcre_info_study_daya[pcre_info_study_daya_len];
			len = fread((char *) pcre_info_study_daya, sizeof(char), pcre_info_study_daya_len, bin_file);
			if (len != pcre_info_study_daya_len)
				goto err;
			//printf("pcre_info_study_daya:%s\n", pcre_info_study_daya);
		} else {
			uint32_t pattern_len;
			len = fread(&pattern_len, sizeof(uint32_t), 1, bin_file);
			if (len != 1)
				goto err;
			//printf("pattern_len:%d\n", pattern_len);
			fseek(bin_file, pattern_len, SEEK_CUR);
		}
	}

	rc = 0;
out:
	fclose(bin_file);
	fclose(out_file);
	return rc;
err:
	rc = -1;
	goto out;
}

int main(int argc, char *argv[])
{
	const char *path = NULL;
	const char *out_path = "file_contexts";

	int opt;

	if (argc < 2)
		usage(argv[0]);

	while ((opt = getopt(argc, argv, "o:")) > 0) {
		switch (opt) {
		case 'o':
			out_path = optarg;
			break;
		default:
			usage(argv[0]);
		}
	}

	if (optind >= argc)
		usage(argv[0]);

	path = argv[optind];

	return process_file(path, out_path);
}
