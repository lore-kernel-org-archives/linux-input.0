Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59352383C86;
	Thu,  1 Oct 2026 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895175; cv=none; b=kfW6yEEMOgfaDsbX/DK80FhmMkJ4mSG6VlRfxAP5USedQ4DpsrQ6TZbjYcB0Ceutj+EFEeodgS9Q255p/WsZIc5bMTFrfH+eK7P5tvxQPfeiaR3iL0bcJJRsp13YoJDuaqsBvrlqTyrXfq8BAaeRC82ZGbV+BYB/GBDO5iLvJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895175; c=relaxed/simple;
	bh=SyWhF5oHPn8T3jJ+uWrQ3n1OxKpeXd4BNK40vJ+L/b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAt3w65PsbAd5/64XYo6RMsbn0iLUBvRSttM8KuFTwPQ+C+douMWW9FtjBwK9rgsaGP8BvbtdVHztmL7OTXuQZ0l11vK0GJRk3/DsKzPsHfEvmJaXueFKJVZqPH7gUzAfFkm5alMTOvFM4N7pTJ7W6038wKg7qrO5Sf7jf+/WIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iFrXeRYt; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iFrXeRYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895174; x=1822431174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kX2vJaPpRx3RytoZd5jJzkmPpZYoFK5cc9fuO0797rA=;
  b=iFrXeRYtFoJgYN41XD2X17Hxu2n+G4V7YxoUkTeU9AfcbKYjbUS9007f
   E7bj1jA9wq2o8UHHoh6DZQ04WEHI1CnaMzp066SdJv5Q3rsc7BGZ15ymb
   61g3eR06RbWxST1hNUZkiJx3WoTQfCzBNyk71ECEhyY/evi5zEobwciMt
   N9Q5u2GLE5hHf4p9TdXmJ+Us/EnmYWYLqm8PkCKImKdbBNDOZZXNe78O6
   xCT5iVXo9gTUJRn7R7NrC+7DkpWgtHPlZzRoiuK3gKh5UapjKtUlt2d1i
   9TYvjKptEQ+vFX37judzi4WjzPpbwg/B6UBh4T8BTRa/WvyuZnrJZ8g8b
   Q==;
X-CSE-ConnectionGUID: M44Yd5vRSGy2Kp5ti+K9dg==
X-CSE-MsgGUID: b7hjR7nTSSONpPm6EbO5Bw==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30216937"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:52:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:31121]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.83:2525] with esmtp (Farcaster)
 id f65652dd-3e6f-4b3d-ab03-2a944f8ec5b4; Thu, 1 Oct 2026 22:52:53 +0000 (UTC)
X-Farcaster-Flow-ID: f65652dd-3e6f-4b3d-ab03-2a944f8ec5b4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:53 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:52 +0000
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
Subject: [PATCH bpf-next v4 02/12] bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
Date: Thu, 1 Oct 2026 22:52:04 +0000
Message-ID: <20261001225214.12351-3-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Split __register_btf_kfunc_id_set(), register_btf_id_dtor_kfuncs() and
__register_bpf_struct_ops() into the part that looks up the BTF for the
owner and the part that adds the registration to a given BTF:
btf_kfunc_id_set_add(), btf_dtor_kfuncs_add() and
btf_struct_ops_register().

In is_valid_value_type(), look up bpf_struct_ops_common_value in the btf
the function was given rather than in the btf_vmlinux global.  The id is
a vmlinux id and a module BTF resolves it through its base, so the result
is the same; the function already uses the passed btf for every other
lookup.

No functional change.  With CONFIG_DEBUG_INFO_BTF=m, registrations made
from initcalls before the vmlinux BTF is available are queued and applied
later by the BTF parsing code, which needs the add-to-this-btf half on
its own; the struct_ops ones are applied before the parsed vmlinux BTF is
published, i.e. while btf_vmlinux is still NULL.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/bpf_struct_ops.c |  3 +-
 kernel/bpf/btf.c            | 91 ++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296..bf3004908d15 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -103,7 +103,8 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	}
 	member = btf_type_member(vt);
 	mt = btf_type_by_id(btf, member->type);
-	common_value_type = btf_type_by_id(btf_vmlinux,
+	/* a vmlinux id resolves through the base BTF of a module BTF too */
+	common_value_type = btf_type_by_id(btf,
 					   st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
 	if (mt != common_value_type) {
 		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c27b929f84f5..dfd1af8c2ac5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9708,11 +9708,26 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
+static int btf_kfunc_id_set_add(struct btf *btf, enum btf_kfunc_hook hook,
+				const struct btf_kfunc_id_set *kset)
+{
+	int ret, i;
+
+	for (i = 0; i < kset->set->cnt; i++) {
+		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
+					     kset->set->pairs[i].flags);
+		if (ret)
+			return ret;
+	}
+
+	return btf_populate_kfunc_set(btf, hook, kset);
+}
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
 	struct btf *btf;
-	int ret, i;
+	int ret;
 
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf)
@@ -9720,16 +9735,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
-	for (i = 0; i < kset->set->cnt; i++) {
-		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
-					     kset->set->pairs[i].flags);
-		if (ret)
-			goto err_out;
-	}
-
-	ret = btf_populate_kfunc_set(btf, hook, kset);
-
-err_out:
+	ret = btf_kfunc_id_set_add(btf, hook, kset);
 	btf_put(btf);
 	return ret;
 }
@@ -9821,21 +9827,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 	return 0;
 }
 
-/* This function must be invoked only from initcalls/module init functions */
-int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
-				struct module *owner)
+static int btf_dtor_kfuncs_add(struct btf *btf, const struct btf_id_dtor_kfunc *dtors,
+			       u32 add_cnt)
 {
 	struct btf_id_dtor_kfunc_tab *tab;
-	struct btf *btf;
 	u32 tab_cnt, i;
 	int ret;
 
-	btf = btf_get_module_btf(owner);
-	if (!btf)
-		return check_btf_kconfigs(owner, "dtor kfuncs");
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
-
 	if (add_cnt >= BTF_DTOR_KFUNC_MAX_CNT) {
 		pr_err("cannot register more than %d kfunc destructors\n", BTF_DTOR_KFUNC_MAX_CNT);
 		ret = -E2BIG;
@@ -9892,6 +9890,23 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 end:
 	if (ret)
 		btf_free_dtor_kfunc_tab(btf);
+	return ret;
+}
+
+/* This function must be invoked only from initcalls/module init functions */
+int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
+				struct module *owner)
+{
+	struct btf *btf;
+	int ret;
+
+	btf = btf_get_module_btf(owner);
+	if (!btf)
+		return check_btf_kconfigs(owner, "dtor kfuncs");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	ret = btf_dtor_kfuncs_add(btf, dtors, add_cnt);
 	btf_put(btf);
 	return ret;
 }
@@ -10530,32 +10545,36 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
 	return NULL;
 }
 
-int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+static int btf_struct_ops_register(struct btf *btf, struct bpf_struct_ops *st_ops)
 {
 	struct bpf_verifier_log *log;
-	struct btf *btf;
-	int err = 0;
-
-	btf = btf_get_module_btf(st_ops->owner);
-	if (!btf)
-		return check_btf_kconfigs(st_ops->owner, "struct_ops");
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
+	int err;
 
 	log = kzalloc_obj(*log, GFP_KERNEL | __GFP_NOWARN);
-	if (!log) {
-		err = -ENOMEM;
-		goto errout;
-	}
+	if (!log)
+		return -ENOMEM;
 
 	log->level = BPF_LOG_KERNEL;
 
 	err = btf_add_struct_ops(btf, st_ops, log);
 
-errout:
 	kfree(log);
-	btf_put(btf);
+	return err;
+}
 
+int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct btf *btf;
+	int err;
+
+	btf = btf_get_module_btf(st_ops->owner);
+	if (!btf)
+		return check_btf_kconfigs(st_ops->owner, "struct_ops");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	err = btf_struct_ops_register(btf, st_ops);
+	btf_put(btf);
 	return err;
 }
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
-- 
2.47.3

