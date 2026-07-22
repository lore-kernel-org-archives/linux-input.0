Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703744AB90
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763359; cv=none; b=cxYjEZ9JzSSFaInQREPD2pQ1x7GE3cWIpmTTcI/+poWA9nf3qOy2u9GdWPfwp8J4YcpdPzPALhMeg9OamTNpblRAHFL7sKzbmH+JUDyyZqq/skeM/anhGdH1Hl/O2vLeXDVDuy3zS8aEy9/DSjSfmi741HR5JWPYm8PU+RuOMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763359; c=relaxed/simple;
	bh=S0pRpgTyeOPk5JZhszv5iZlrVURb94N/Jmqo0kbQBuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcTg1aBq6IyTOavCQLtce9ZJ+Vq1aK6NMB111q08z5cfJqysw6Nb5ugvKv85qgJLyo1TNq4rtAw2xs6N/KpW/Y1mdlrKTltUfdQYJ5vt4MrWwPHjH7sxp1zRFx2cA/hw+pjHMHt28WhgSB9XGboTblWWy9f8nPjYDSEQujY4nnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JObIAOlc; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JObIAOlc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784763351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgKzIztyg2ynJSPTwAKfWXCZTuSXuB3UVG2hchvJlWA=;
	b=JObIAOlccjCighFirjZxhaFBImouOlKwiLP99iAt3j2pEH+5lB/WaABX7O41UfyWMqtv+r
	es5tCOfT1kI9ZvoRbQoPBM9mB32yX6IERm7PMC0Dgqsm1ZfPVRxr5Sh216QeBw+++Fk0T/
	cLW7dkUstETfjcOl8lGVWo2YoVWcTg0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/8] resolve_btfids: Index BTF ID symbols by address
Date: Wed, 22 Jul 2026 16:35:12 -0700
Message-ID: <20260722233518.778854-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260722233518.778854-1-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Keep an address-sorted index of parsed .BTF_ids symbols so that the
original BTF_ID symbol name can be recovered from an entry address.

Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
directly and match each entry back to the requested kfunc.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/resolve_btfids/main.c | 96 ++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 183466ddc5f9..3198198b03a7 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -119,6 +119,11 @@ struct btf_id {
 	Elf64_Addr	 addr[ADDR_CNT];
 };
 
+struct addr_sym {
+	Elf64_Addr	 addr;
+	const char	*name;
+};
+
 struct object {
 	const char *path;
 	const char *btf_path;
@@ -150,6 +155,10 @@ struct object {
 	int nr_structs;
 	int nr_unions;
 	int nr_typedefs;
+
+	struct addr_sym *addr_syms;
+	u32 addr_syms_cnt;
+	u32 addr_syms_cap;
 };
 
 #define KF_IMPLICIT_ARGS (1 << 16)
@@ -509,6 +518,40 @@ static int elf_collect(struct object *obj)
 	return 0;
 }
 
+static int push_addr_sym(struct object *obj, Elf64_Addr addr, const char *name)
+{
+	if (ensure_mem(&obj->addr_syms, &obj->addr_syms_cap, obj->addr_syms_cnt + 1))
+		return -ENOMEM;
+
+	obj->addr_syms[obj->addr_syms_cnt++] = (struct addr_sym){
+		.addr = addr,
+		.name = name,
+	};
+
+	return 0;
+}
+
+static int cmp_addr_sym(const void *a, const void *b)
+{
+	Elf64_Addr aa = ((const struct addr_sym *)a)->addr;
+	Elf64_Addr ab = ((const struct addr_sym *)b)->addr;
+
+	return (aa > ab) - (aa < ab);
+}
+
+static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
+{
+	struct addr_sym key = { .addr = addr };
+	struct addr_sym *res;
+
+	if (!obj->addr_syms_cnt)
+		return NULL;
+
+	res = bsearch(&key, obj->addr_syms, obj->addr_syms_cnt,
+		      sizeof(*obj->addr_syms), cmp_addr_sym);
+	return res ? res->name : NULL;
+}
+
 static int symbols_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
@@ -602,8 +645,15 @@ static int symbols_collect(struct object *obj)
 			return -1;
 		}
 		id->addr[id->addr_cnt++] = sym.st_value;
+
+		if (push_addr_sym(obj, sym.st_value, id->name))
+			return -1;
 	}
 
+	if (obj->addr_syms_cnt)
+		qsort(obj->addr_syms, obj->addr_syms_cnt,
+		      sizeof(*obj->addr_syms), cmp_addr_sym);
+
 	return 0;
 }
 
@@ -957,43 +1007,40 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
 }
 
 /*
- * To find the kfunc flags having its struct btf_id (with ELF addresses)
- * we need to find the address that is in range of a set8.
- * If a set8 is found, then the flags are located at addr + 4 bytes.
+ * To find kfunc flags, scan BTF_SET8_KFUNCS entries and use the entry
+ * address to recover the corresponding BTF_ID symbol name.
  * Return 0 (no flags!) if not found.
  */
 static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
 {
-	const u32 *elf_data_ptr = obj->efile.idlist->d_buf;
-	u64 set_lower_addr, set_upper_addr, addr;
+	Elf_Data *idlist = obj->efile.idlist;
 	struct btf_id *set_id;
 	struct rb_node *next;
-	u32 flags;
-	u64 idx;
 
 	for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
+		struct btf_id_set8 *set8;
+		u64 set_addr;
+
 		set_id = rb_entry(next, struct btf_id, rb_node);
 		if (set_id->kind != BTF_ID_KIND_SET8 || set_id->addr_cnt != 1)
 			continue;
 
-		set_lower_addr = set_id->addr[0];
-		set_upper_addr = set_lower_addr + set_id->cnt * sizeof(u64);
+		set_addr = set_id->addr[0];
+		set8 = idlist->d_buf + (set_addr - obj->efile.idlist_addr);
+		if (!(set8->flags & BTF_SET8_KFUNCS))
+			continue;
 
-		for (u32 i = 0; i < kfunc_id->addr_cnt; i++) {
-			addr = kfunc_id->addr[i];
-			/*
-			 * Lower bound is exclusive to skip the 8-byte header of the set.
-			 * Upper bound is inclusive to capture the last entry at offset 8*cnt.
-			 */
-			if (set_lower_addr < addr && addr <= set_upper_addr) {
-				pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
-					 kfunc_id->name, set_id->name);
-				idx = addr - obj->efile.idlist_addr;
-				idx = idx / sizeof(u32) + 1;
-				flags = elf_data_ptr[idx];
-
-				return flags;
-			}
+		for (u32 i = 0; i < set_id->cnt; i++) {
+			size_t off = (char *)&set8->pairs[i] - (char *)set8;
+			const char *name = find_name_by_addr(obj, set_addr + off);
+
+			if (!name || strcmp(name, kfunc_id->name) != 0)
+				continue;
+
+			pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
+				 kfunc_id->name, set_id->name);
+
+			return set8->pairs[i].flags;
 		}
 	}
 
@@ -1586,6 +1633,7 @@ int main(int argc, const char **argv)
 	btf_id__free_all(&obj.typedefs);
 	btf_id__free_all(&obj.funcs);
 	btf_id__free_all(&obj.sets);
+	free(obj.addr_syms);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
-- 
2.55.0

