Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E734C9E1E;
	Thu,  1 Oct 2026 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895301; cv=none; b=HSg2qwbm8bvaS8zvFvUM+PRfgGEYZCvIJhs3OcyjIMyu7MQ8/CdYKqgwWdAUlSMDLMhdPw/CGJg3TUvHv/UHyV3OP5/bEclkapYi9E8uHJhngKhppSvcd2Nrs5eLtRSazf4iqdM+tythPoeoH202fM9RebCuAZc8xgvnqVu7JlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895301; c=relaxed/simple;
	bh=XvW2zojooysG7QGF4IoMhMzWxYl38xGDcuoamZ9e8vE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ad32LUH7frohcUEN0MY4BhUKhjJJfmmwSqd+0ms7QF4Ilx6rCXvIQAGwdl/O2IIL2lkczZ8y3ZW1bQa+sgT736UMWkGUxDVxK7oKLUpLOx6Jg5/uTW8+SV3J0tMuqbRYbPbcrUjUgW9NbnGfnj4hLzktzHQZ5pcIYMLm+AQS++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lLV4F/dj; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lLV4F/dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895299; x=1822431299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLryQRiBW09HO8kLnr3HCZSfVMh5KTS6CI7YyCx+TnQ=;
  b=lLV4F/djgi6mkAgJZIMMsZQ+ySlGtMpHnQwlfmVoX9m+DjTvYqVHoJuu
   Iv/SMVbIs3+S97rMcFezZB5DdF6QRYAk4HZ9AHkWOmP10NJNlcuws/2Sq
   8jU/cAaitZnkYho91wQktl6fbaDvXVNLCcnVZ9gUdayk3JyT+E+i9aXhF
   Q/rZEFKF+mMVh3n4ORDIN4x+YlSNexSgzRcq65DMLNisoTeGgNlX6hDho
   6/zUofHqoanfIH94h7sywT1VbuRRsindwICD5uUOWKEog59q4TF+kXe4M
   4n0MuZbY7SE3DfcV+t5ZbD74KKROCIBKCkF7Bky9dErjTJVTGZpg4efBB
   w==;
X-CSE-ConnectionGUID: EA7f+XVrQIikH4qN35xIaQ==
X-CSE-MsgGUID: hysrr3E2THeIx0wwFETpMg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29977584"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:54:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:16763]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.113:2525] with esmtp (Farcaster)
 id fe97d17e-c3ac-4a99-9d5a-bf993e0e52f7; Thu, 1 Oct 2026 22:54:58 +0000 (UTC)
X-Farcaster-Flow-ID: fe97d17e-c3ac-4a99-9d5a-bf993e0e52f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:57 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:54:57 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet
	<qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>, Christian Heusel
	<christian@heusel.eu>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
	<petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, <linux-input@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	<sched-ext@lists.linux.dev>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v4 10/12] resolve_btfids: add --btf_link to fill in .BTF.link records
Date: Thu, 1 Oct 2026 22:52:12 +0000
Message-ID: <20261001225214.12351-11-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261001225214.12351-1-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Alan Maguire <alan.maguire@oracle.com>

With CONFIG_DEBUG_INFO_BTF=m the vmlinux BTF is not part of the kernel
image but carried by a module, and the kernel has to know, before that
module is loaded, which module that is, how large the BTF is and which
BTF it was built with.  It keeps that in a .BTF.link record (struct
btf_link): the name of the module, NUL-padded to the target's
__MODULE_NAME_LEN, the SHA-256 of the BTF, and its size in the byte
order of the target.  Inline BTF delivered as a module, a planned
follow-up, needs the same for its own section, in .BTF.inline.link.

Fill these records in where .BTF_ids is patched, after the final link,
when the BTF is final: the --patch_btfids pass takes one or more

    --btf_link <section>:<module>:<raw BTF file>

options, and writes into the existing <section>.link section of the ELF
file the module name and the size and SHA-256 of the raw BTF file,
computed with the SHA-256 implementation of the libbpf the tool links.
The section must have the size of the record for the target's ELF
class, 92 bytes for 64-bit and 96 for 32-bit, which also catches the
kernel and the tool disagreeing on its layout.  Without --btf_link
nothing changes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT 5.6)
[adapted subject and commit message; rebased onto bpf-next without the
 inline BTF changes; take the ELF class and byte order from the ELF
 header in patch_btf_link() rather than from elf_collect(), set up libelf
 there too, report each failure, refuse an overlong section name and
 --btf_link without --patch_btfids, document the option]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 tools/bpf/resolve_btfids/main.c | 217 +++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 37d7e7224207..787ed5818c24 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -69,6 +69,11 @@
  *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
  *
  * These kfunc annotations were historically produced by pahole.
+ *
+ * With --patch_btfids, --btf_link <section>:<module>:<raw BTF file> also fills
+ * in the <section>.link section of the ELF file, for BTF that a module carries
+ * (struct btf_link in kernel/bpf/btf.c): the module name, and the size and
+ * SHA-256 of the raw BTF.
  */
 
 #define  _GNU_SOURCE
@@ -92,8 +97,14 @@
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
+#define BTF_LINK_MODULE_NAME_MAX	64
+#define LIBBPF_SHA256_DIGEST_LENGTH	32
 #define BTF_ID_PREFIX	"__BTF_ID__"
 
+/* from libbpf, which this tool is statically linked with */
+void libbpf_sha256(const void *data, size_t len,
+		   __u8 out[LIBBPF_SHA256_DIGEST_LENGTH]);
+
 #define BTF_STRUCT	"struct"
 #define BTF_UNION	"union"
 #define BTF_TYPEDEF	"typedef"
@@ -172,6 +183,19 @@ struct object {
 	u32 addr_syms_cap;
 };
 
+struct btf_link {
+	char *value;
+	char *section;
+	char *module;
+	char *btf_path;
+};
+
+struct btf_links {
+	struct btf_link *links;
+	u32 cnt;
+	u32 cap;
+};
+
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
 
@@ -259,6 +283,48 @@ static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
 #define ensure_mem(arr_ptr, cap_ptr, cnt) \
 	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))
 
+static int parse_btf_link(const struct option *opt, const char *arg, int unset)
+{
+	struct btf_links *links = opt->value;
+	struct btf_link *link;
+	char *separator;
+
+	if (unset)
+		return -EINVAL;
+	if (ensure_mem(&links->links, &links->cap, links->cnt + 1))
+		return -ENOMEM;
+	link = &links->links[links->cnt];
+	memset(link, 0, sizeof(*link));
+	link->value = strdup(arg);
+	if (!link->value)
+		return -ENOMEM;
+	link->section = link->value;
+	separator = strchr(link->section, ':');
+	if (!separator || separator == link->section)
+		goto err_value;
+	*separator++ = '\0';
+	link->module = separator;
+	separator = strchr(link->module, ':');
+	if (!separator || separator == link->module || !separator[1])
+		goto err_value;
+	*separator++ = '\0';
+	link->btf_path = separator;
+	links->cnt++;
+	return 0;
+err_value:
+	free(link->value);
+	return -EINVAL;
+}
+
+static void free_btf_links(struct btf_links *links)
+{
+	u32 i;
+
+	for (i = 0; i < links->cnt; i++)
+		free(links->links[i].value);
+	free(links->links);
+}
+
 static bool is_btf_id(const char *name)
 {
 	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
@@ -1738,9 +1804,143 @@ static int patch_btfids(const char *btfids_path, const char *elf_path)
 	return err;
 }
 
+/*
+ * Fill in the <section>.link record of an ELF file: the name of the module
+ * that carries <section>, NUL-padded to __MODULE_NAME_LEN of the target, the
+ * SHA-256 of the raw BTF in link->btf_path, and its size in the byte order of
+ * the target.  The record must already be there, with exactly that size.
+ */
+static int patch_btf_link(const char *elf_path, const struct btf_link *link)
+{
+	size_t shdrstrndx, module_name_len, link_size;
+	void *raw_btf_data;
+	Elf_Scn *scn = NULL;
+	char section[128];
+	int fd, err = -1;
+	FILE *btf_file;
+	u32 raw_btf_size, btf_size;
+	Elf_Data *data;
+	GElf_Ehdr ehdr;
+	struct stat st;
+	GElf_Shdr sh;
+	char *name;
+	Elf *elf;
+
+	if (stat(link->btf_path, &st) < 0) {
+		pr_err("FAILED to stat %s: %s\n", link->btf_path, strerror(errno));
+		return -1;
+	}
+	if (!st.st_size || st.st_size > UINT_MAX) {
+		pr_err("FAILED: %s has an unexpected size\n", link->btf_path);
+		return -1;
+	}
+	raw_btf_size = st.st_size;
+	raw_btf_data = malloc(raw_btf_size);
+	if (!raw_btf_data) {
+		pr_err("FAILED to allocate %u bytes for %s\n", raw_btf_size, link->btf_path);
+		return -ENOMEM;
+	}
+	btf_file = fopen(link->btf_path, "rb");
+	if (!btf_file) {
+		pr_err("FAILED to open %s: %s\n", link->btf_path, strerror(errno));
+		goto out_data;
+	}
+	if (fread(raw_btf_data, raw_btf_size, 1, btf_file) != 1) {
+		pr_err("FAILED to read %s\n", link->btf_path);
+		fclose(btf_file);
+		goto out_data;
+	}
+	fclose(btf_file);
+
+	if (snprintf(section, sizeof(section), "%s.link", link->section) >= (int)sizeof(section)) {
+		pr_err("FAILED: section name %s.link is too long\n", link->section);
+		goto out_data;
+	}
+
+	elf_version(EV_CURRENT);
+	fd = open(elf_path, O_RDWR);
+	if (fd < 0) {
+		pr_err("FAILED to open %s: %s\n", elf_path, strerror(errno));
+		goto out_data;
+	}
+	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
+	if (!elf) {
+		pr_err("FAILED cannot create ELF descriptor: %s\n", elf_errmsg(-1));
+		goto out_close;
+	}
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
+	if (!gelf_getehdr(elf, &ehdr)) {
+		pr_err("FAILED cannot get ELF header: %s\n", elf_errmsg(-1));
+		goto out_elf;
+	}
+	/* __MODULE_NAME_LEN is 64 - sizeof(unsigned long) */
+	if (ehdr.e_ident[EI_CLASS] == ELFCLASS32) {
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 4;
+	} else if (ehdr.e_ident[EI_CLASS] == ELFCLASS64) {
+		module_name_len = BTF_LINK_MODULE_NAME_MAX - 8;
+	} else {
+		pr_err("FAILED: unknown ELF class of %s\n", elf_path);
+		goto out_elf;
+	}
+	if (strlen(link->module) >= module_name_len) {
+		pr_err("FAILED: module name %s is too long\n", link->module);
+		goto out_elf;
+	}
+
+	if (elf_getshdrstrndx(elf, &shdrstrndx)) {
+		pr_err("FAILED cannot get shdr str ndx\n");
+		goto out_elf;
+	}
+	while ((scn = elf_nextscn(elf, scn))) {
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			pr_err("FAILED to get section header\n");
+			goto out_elf;
+		}
+		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
+		if (name && !strcmp(name, section))
+			break;
+	}
+	if (!scn) {
+		pr_err("FAILED: section %s not found in %s\n", section, elf_path);
+		goto out_elf;
+	}
+	link_size = module_name_len + LIBBPF_SHA256_DIGEST_LENGTH + sizeof(u32);
+	data = elf_getdata(scn, NULL);
+	if (!data || !data->d_buf || data->d_size != link_size) {
+		pr_err("FAILED: section %s in %s is not %zu bytes of data\n",
+		       section, elf_path, link_size);
+		goto out_elf;
+	}
+
+	memset(data->d_buf, 0, data->d_size);
+	memcpy(data->d_buf, link->module, strlen(link->module) + 1);
+	libbpf_sha256(raw_btf_data, raw_btf_size,
+		      (u8 *)data->d_buf + module_name_len);
+	btf_size = ehdr.e_ident[EI_DATA] == ELFDATANATIVE ? raw_btf_size :
+							     bswap_32(raw_btf_size);
+	memcpy((u8 *)data->d_buf + module_name_len + LIBBPF_SHA256_DIGEST_LENGTH,
+	       &btf_size, sizeof(btf_size));
+
+	pr_debug("Filled in %s of %s for module %s\n", section, elf_path, link->module);
+
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		pr_err("FAILED to update ELF file %s: %s\n", elf_path, elf_errmsg(-1));
+		goto out_elf;
+	}
+	err = 0;
+out_elf:
+	elf_end(elf);
+out_close:
+	close(fd);
+out_data:
+	free(raw_btf_data);
+	return err;
+}
+
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
-	"resolve_btfids --patch_btfids <.BTF_ids file> <ELF object>",
+	"resolve_btfids --patch_btfids <.BTF_ids file> [--btf_link <section>:<module>:<BTF file>]... <ELF object>",
 	NULL
 };
 
@@ -1758,6 +1958,7 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	const char *btfids_path = NULL;
+	struct btf_links btf_links = {};
 	bool fatal_warnings = false;
 	bool resolve_btfids = true;
 	char out_path[PATH_MAX];
@@ -1773,21 +1974,28 @@ int main(int argc, const char **argv)
 			    "turn warnings into errors"),
 		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
 			    "distill --btf_base and emit .BTF.base section data"),
+		OPT_CALLBACK(0, "btf_link", &btf_links, "section:module:btf-file",
+			     "patch a BTF link (with --patch_btfids)", parse_btf_link),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
 	};
 	int err = -1;
+	u32 i;
 
 	argc = parse_options(argc, argv, btfid_options, resolve_btfids_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (argc != 1)
+	if (argc != 1 || (btf_links.cnt && !btfids_path))
 		usage_with_options(resolve_btfids_usage, btfid_options);
 
 	obj.path = argv[0];
 
-	if (btfids_path)
-		return patch_btfids(btfids_path, obj.path);
+	if (btfids_path) {
+		err = patch_btfids(btfids_path, obj.path);
+		for (i = 0; !err && i < btf_links.cnt; i++)
+			err = patch_btf_link(obj.path, &btf_links.links[i]);
+		goto out;
+	}
 
 	if (elf_collect(&obj))
 		goto out;
@@ -1845,6 +2053,7 @@ int main(int argc, const char **argv)
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
+	free_btf_links(&btf_links);
 	btf__free(obj.base_btf);
 	btf__free(obj.btf);
 	btf_id__free_all(&obj.structs);
-- 
2.47.3

