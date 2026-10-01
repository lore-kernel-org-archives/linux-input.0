Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F044BA1E6;
	Thu,  1 Oct 2026 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895160; cv=none; b=Qlhzlg6+xQVBtzMS42NrtyVuAZd35rO9jhlib2Wq1BBNw0jmMU7lg50Q8351nTOo/Dy+NflUs9Ekyddu2A36lTkLeBHwfvmm53+5fdXpkGqYrPcmw7hS3KjqfQEKfqxj1hCl5qWekqbpSy1+amV1MpYUkGTv8Sbn5QNAgJTcRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895160; c=relaxed/simple;
	bh=laazS+0ZmSnRyJpgtk+2lHW3yVI64TKOgAOksjv8YWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5ElA3bnyHAY3kF3Dn/pu45WXY7k5tAk1jSvwW3c0myD7I8019fxSB46QbNZC21sh6VlT7rqGBfJi+QLopdNUHfEa1UiuuHUtvvF2hq/hJWTcpHmqPNagCy2asOSjtklw4a2O6U+nk16BLxUAH6uJLoJDNN6hVaRAkuJ0VpJMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YtucT8pl; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YtucT8pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895158; x=1822431158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+JyH5zIJE3PGSOjUeeYnRuwWQu8TPBpZh3k8A6DDdM=;
  b=YtucT8plQ/uzE4tYqEmGU1XHFMjPvCI9dnqWZl4MUkNg7Uc+8GGOkKf6
   0Pyj8kz8cQfges/OTfhnLJhL/wPKX9Is/eAgRWNa8aDQHliDKfT6ITx4L
   LlIC+ub/WKFiK81REjwko8ZBQnavdPMH+imCadSpHDNYKFXNfcIITtKtB
   +zpC4sutSX0yko/+yFAe2rqPrLnIqe2a4H1cGdao6lg3kRJgLymrv6q69
   7437H0fnk6hXN6xvFkZC3ggusImsFGtffAfzjkZKAul7hngRFJCA319la
   zRL3nbSJ18Qj6loq7/ENxFKNStl75ZDhuaBWPAlq9wWN3ROVZnadMunYs
   A==;
X-CSE-ConnectionGUID: R7b7WIeYTPakmuq46PULeg==
X-CSE-MsgGUID: ClvxUyeBT9yOB1x+sJHB1Q==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30225222"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:52:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:4205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.21:2525] with esmtp (Farcaster)
 id bfb080bf-bf6c-489f-85ba-77338b00a77d; Thu, 1 Oct 2026 22:52:38 +0000 (UTC)
X-Farcaster-Flow-ID: bfb080bf-bf6c-489f-85ba-77338b00a77d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:37 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:52:37 +0000
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
Subject: [PATCH bpf-next v4 01/12] bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the data
Date: Thu, 1 Oct 2026 22:52:03 +0000
Message-ID: <20261001225214.12351-2-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Make btf_parse_module() take the vmlinux BTF as an argument instead of
fetching it with bpf_get_btf_vmlinux(), and add a data_owned flag: when
set, the passed .BTF data is an already kvmalloc()ed copy that the new
btf takes ownership of on success (on failure the caller keeps it).

Factor the sysfs file creation out of the module notifier into
btf_module_sysfs_add() and the teardown into btf_module_free(), and set
btf_mod->module right after the allocation rather than under the mutex.

No functional change.  This prepares for CONFIG_DEBUG_INFO_BTF=m, where a
module can be loaded before the vmlinux BTF is available: its .BTF is
then copied and exposed in sysfs first and parsed later, at which point
the parser must take the copy as is so that the sysfs file keeps
pointing at valid data.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c | 105 +++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8cc17a1cd25c..c27b929f84f5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6911,16 +6911,20 @@ __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
-static struct btf *btf_parse_module(const char *module_name, const void *data,
-				    unsigned int data_size, void *base_data,
-				    unsigned int base_data_size)
+/*
+ * Parse split module BTF against @vmlinux_btf.  @data is the module's .BTF
+ * section; if @data_owned, it is an already kvmalloc()ed copy that the new
+ * btf takes ownership of on success (on failure the caller keeps it).
+ */
+static struct btf *btf_parse_module(const char *module_name, struct btf *vmlinux_btf,
+				    void *data, unsigned int data_size, bool data_owned,
+				    void *base_data, unsigned int base_data_size)
 {
-	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
+	struct btf *btf = NULL, *base_btf = NULL;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	int err = 0;
 
-	vmlinux_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(vmlinux_btf))
 		return vmlinux_btf;
 	if (!vmlinux_btf)
@@ -6957,7 +6961,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->named_start_id = 0;
 	strscpy(btf->name, module_name);
 
-	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
+	if (data_owned)
+		btf->data = data;
+	else
+		btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!btf->data) {
 		err = -ENOMEM;
 		goto errout;
@@ -7000,7 +7007,8 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
 		btf_free(base_btf);
 	if (btf) {
-		kvfree(btf->data);
+		if (!data_owned)
+			kvfree(btf->data);
 		kvfree(btf->types);
 		kfree(btf);
 	}
@@ -9005,6 +9013,48 @@ static DEFINE_MUTEX(btf_module_mutex);
 
 static void purge_cand_cache(struct btf *btf);
 
+static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
+				void *data, size_t data_size)
+{
+	struct bin_attribute *attr;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_SYSFS))
+		return 0;
+
+	attr = kzalloc_obj(*attr);
+	if (!attr)
+		return -ENOMEM;
+
+	sysfs_bin_attr_init(attr);
+	attr->attr.name = name;
+	attr->attr.mode = 0444;
+	attr->size = data_size;
+	attr->private = data;
+	attr->read = sysfs_bin_attr_simple_read;
+
+	err = sysfs_create_bin_file(btf_kobj, attr);
+	if (err) {
+		pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
+			name, err);
+		kfree(attr);
+		return err;
+	}
+
+	btf_mod->sysfs_attr = attr;
+	return 0;
+}
+
+static void btf_module_free(struct btf_module *btf_mod)
+{
+	if (btf_mod->sysfs_attr)
+		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+	purge_cand_cache(btf_mod->btf);
+	btf_put(btf_mod->btf);
+	kfree(btf_mod->sysfs_attr);
+	kfree(btf_mod);
+}
+
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
@@ -9025,7 +9075,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+		btf_mod->module = module;
+
+		btf = btf_parse_module(mod->name, bpf_get_btf_vmlinux(),
+				       mod->btf_data, mod->btf_data_size, false,
 				       mod->btf_base_data, mod->btf_base_data_size);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
@@ -9047,37 +9100,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 
 		purge_cand_cache(NULL);
 		mutex_lock(&btf_module_mutex);
-		btf_mod->module = module;
 		btf_mod->btf = btf;
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
-		if (IS_ENABLED(CONFIG_SYSFS)) {
-			struct bin_attribute *attr;
-
-			attr = kzalloc_obj(*attr);
-			if (!attr)
-				goto out;
-
-			sysfs_bin_attr_init(attr);
-			attr->attr.name = btf->name;
-			attr->attr.mode = 0444;
-			attr->size = btf->data_size;
-			attr->private = btf->data;
-			attr->read = sysfs_bin_attr_simple_read;
-
-			err = sysfs_create_bin_file(btf_kobj, attr);
-			if (err) {
-				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
-					mod->name, err);
-				kfree(attr);
-				err = 0;
-				goto out;
-			}
-
-			btf_mod->sysfs_attr = attr;
-		}
-
+		/* not fatal, the module BTF is usable without the sysfs file */
+		btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
@@ -9104,12 +9132,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			 */
 			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
-			if (btf_mod->sysfs_attr)
-				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-			purge_cand_cache(btf_mod->btf);
-			btf_put(btf_mod->btf);
-			kfree(btf_mod->sysfs_attr);
-			kfree(btf_mod);
+			btf_module_free(btf_mod);
 			break;
 		}
 		mutex_unlock(&btf_module_mutex);
-- 
2.47.3

