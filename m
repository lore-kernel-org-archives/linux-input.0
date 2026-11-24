Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538877;
	b=Lrb5//N+LggRQTEBNbVWETzJp/xet0TGICH9Ta8hZEV7nEhnsjrhLIf7h8UCM12hDRXy
	 wXkW30sHNshS6Qu2LMxmDlW7r1DUAPmI8T2dI5sCpwe6OnxAjL3hxJ2jpk/VxzURmfbBo
	 6Y8wrGhQ2/voSNtIa9USPcSYbXcwds4dO8S6cdMPlPvM01NF+lCSPtKvEzkQN5KyQw/7e
	 UmBd+RDbhu1SqMIRBi3enMifLk2Hk+uGJbJKMhTlow095NrwGzR2eQtM96YDLse1Ux1iJ
	 nyhvARIY90mDRfyAMzH/EV9E2AtryyDQF2ztN5W+nuMxVv4yHx4I/ThieSL6UkOqP0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538877;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=IwAsnn3xSV00Y9TvcvbtNrVdmHEnJVZptFi/ga0AwGg=;
	b=OX9TOs4jjDuAe4S7RIGKnfaHwdGYwtYc8soRBc6MedXyHjDhuKsVy5Z/cilrd8tyRltg
	 QAilRlDxVgsJQ2vIRe/krT4k1GfKl4IPizAHQmKvMhWyfT2lTX3vhTVJj2Ut1vRUJzDbc
	 byJLecaa0vhGlW1mE24UPPNRcEl5GPnpIZyMIInBtxDq8R5ObqMZb1dEt/c/Hnz9fWS5h
	 WVDHCzPcC/fj6pEblZEMSOTFbNnEMPMw1guf+jj+Ccy6Sae+GqkefsvIxrfbpuMwLRC5T
	 l9QFXSN78U82tGDu8x/W93qxDAZeQv+hbsStppoTKLNqkQwVSsgVt13mvzUg3Jj4AVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=gW8HlZfT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61D606A6B9;
	Tue, 24 Nov 2026 16:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C61D606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=gW8HlZfT
ARC-Seal: i=1; a=rsa-sha256; t=1795538737; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YSHJjQt9RAddLQcd6Hu+FjJSc8y0+LcDPN4CQb+LSLuirlkpl7qLd7yFTCTEdhEEaO7Ss/xKtErkQlpNTB3R4lDqQIXqARCskQuKhbv/mgCsoACY7n7giBryMXMWqr6cc9HUNqOvh99bC6P77d68xv6uGUW3Swuh2YlzddDVZWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538737; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IwAsnn3xSV00Y9TvcvbtNrVdmHEnJVZptFi/ga0AwGg=; 
	b=f1h/i0H2RiEJzzsdVC6a+ttpW7qcTqlNDizv+LwEytqfVgAm29wPdNNUP3Xq2g8QjwxynhEFH4MTu9wO5OIzXl9J1hperqsfdqSbLQRhO3BRTO/Tg4UnrD3yJRnYvTqMm1YlHwj1ngRiGktKljREKjRNX8xRx8cpj8LlS7Bsbao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=gW8HlZfTLTBLqaWNznImnm8S5RjBWNRBrGGWlZMs+02BM+zOHS2dPpOcaxJMKuE4GC8YwBd2n0l/tfot5p0fCFa3Bnp3Nk1Q6v+etT95MYuksMzJE2PZrrnsCYrlkECnKVd+suu7lTZS+YlaXqDWmDvIa0ksq+4JQmeBiUkhMw5dJXhuJJoB4pq0xCY8fpb7JVuWTioUudKPrntclPmVhgORt1NLXAxGnMn+aiZZ810MT2QHmLnMuqP8D0DXgbT2PtvBfHUR1aFimM48iCMGlhTlGDxluGIJtFUxeERpvBkXw1Jq7rnk4Cjs9hjJxAhIqqaX0I/ARby2A2he1UcIEA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=IwAsnn3xSV00Y9TvcvbtNrVdmHEnJVZptFi/ga0AwGg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17955387351831009.0356730383006;
	Tue, 24 Nov 2026 08:45:35 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:35 +0800
Subject: [PATCH v4 7/9] HID: Add hid-plugin framework for loadable plugin
 modules
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hid-haptic-kmod-v4-7-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Some devices support some additional HID usage pages which enhance their
capabilities. The support code for these usage pages is called "HID
plugin".

The corresponding HID driver calls functions provided by the plugin to
take the advantage of such enhancements. Without the framework, the HID
driver must have a linkage dependence on the plugin, which is not
optimal because the plugin is always loaded into memory even if no
device actually supports it.

Logically, the dependence should be reversed, i.e., the plugin should be
an optional component of the HID driver, which is only loaded when the
driver finds that the device needs it.

Introduce hid-plugin framework for loadable plugin modules to achieve
the said logical dependence. Each plugin has a unique hid_plugin_id when
enabled, so that HID drivers can request it accordingly. The framework
aims to be lightweight. It loads the plugin module when needed. Once
loaded (or if the plugin is builtin), requesting the plugin is just an
RCU dereference plusing an module refcount increment.

When a plugin is disabled, its id maps to HID_PLUGIN_DISABLED, and calls
to the plugin helper functions are eliminated by the compiler.

I volunteer to maintain the framework as well as its plugins.

Thanks Benjamin Tissoires for the inspiration for the implementation.

Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v4:
- Drop synchronize_rcu() during registration as other drivers do, as
there is nothing to protect

Changes in v3:
- Add missing Return: to hid_plugin_register()'s kernel-doc (thanks
  Sashiko)
---
 MAINTAINERS              |   6 ++
 drivers/hid/Kconfig      |  14 +++++
 drivers/hid/Makefile     |   2 +
 drivers/hid/hid-plugin.c | 105 +++++++++++++++++++++++++++++++++++
 drivers/hid/hid-plugin.h | 141 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 268 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..24bcc700ccfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11902,6 +11902,12 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/hid/hid-playstation.c
 
+HID PLUGINS
+M:	Rong Zhang <i@rong.moe>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-plugin.*
+
 HID PULSAR DRIVER
 M:	Nikolas Koesling <nikolas@koesling.info>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..604683b4a4a9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -92,6 +92,20 @@ config HID_GENERIC
 
 	If unsure, say Y.
 
+menuconfig HID_PLUGIN
+	bool "HID plugins"
+	help
+	Support for HID plugins.
+
+	Say Y here if you want to enhance HID drivers with additional
+	functionalities provided by corresponding plugins.
+
+	Plugins can be either builtin or modules. A plugin compiled as a module
+	is made available to HID drivers by automatically loading it when
+	requested.
+
+	If unsure, say N.
+
 config HID_HAPTIC
 	bool "Haptic touchpad support"
 	default n
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 43a8eb0f389b..b41aa3f52a94 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -4,6 +4,8 @@
 #
 hid-y			:= hid-core.o hid-input.o hid-quirks.o
 hid-$(CONFIG_DEBUG_FS)		+= hid-debug.o
+hid-$(CONFIG_HID_PLUGIN)	+= hid-plugin.o
+
 hid-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
 
 obj-$(CONFIG_HID_BPF)		+= bpf/
diff --git a/drivers/hid/hid-plugin.c b/drivers/hid/hid-plugin.c
new file mode 100644
index 000000000000..288dedd21253
--- /dev/null
+++ b/drivers/hid/hid-plugin.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  HID plugin helpers
+ *
+ *  Copyright (c) 2026 Rong Zhang <i@rong.moe>
+ */
+
+#define pr_fmt(fmt) "hid-plugin: " fmt
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/rcupdate.h>
+
+#include "hid-plugin.h"
+
+static const char * const hid_plugin_mod_names[NR_HID_PLUGINS] = {
+};
+
+static struct hid_plugin __rcu *hid_plugins[NR_HID_PLUGINS];
+
+static struct hid_plugin *hid_plugin_try_module_get(enum hid_plugin_id id)
+{
+	guard(rcu)();
+
+	struct hid_plugin *plugin = rcu_dereference(hid_plugins[id]);
+
+	if (!plugin)
+		return NULL;
+
+	/* Is the module unloading? */
+	return try_module_get(plugin->owner) ? plugin : ERR_PTR(-ENXIO);
+}
+
+struct hid_plugin *__hid_plugin_get(enum hid_plugin_id id)
+{
+	struct hid_plugin *plugin;
+	const char *mod_name;
+	int ret;
+
+	/*
+	 * Compile the function as a stub if plugin support is enabled but no
+	 * plugin is actually enabled. Utilizing dead code elimination is the
+	 * best thing we can do as it's impossible to evaluate an enumeration in
+	 * macros.
+	 */
+	if (NR_HID_PLUGINS <= 0)
+		return ERR_PTR(-ENOENT);
+
+	plugin = hid_plugin_try_module_get(id);
+	if (plugin)
+		return plugin;
+
+	mod_name = hid_plugin_mod_names[id];
+	if (WARN_ON(!mod_name)) /* Huh? Builtin plugins can't reach here. */
+		return ERR_PTR(-ENXIO);
+
+	ret = request_module(mod_name);
+	if (ret) {
+		pr_warn("failed to load [%d]%s: %d\n", id, mod_name, ret);
+		return ERR_PTR(-ENXIO); /* Don't return positive error code. */
+	}
+
+	plugin = hid_plugin_try_module_get(id);
+	return plugin ?: ERR_PTR(-ENXIO);
+}
+EXPORT_SYMBOL_GPL(__hid_plugin_get);
+
+int __hid_plugin_register(enum hid_plugin_id id, struct hid_plugin *plugin)
+{
+	if (NR_HID_PLUGINS <= 0)
+		return -ENOENT;
+
+	/*
+	 * The corresponding plugin is the only writer of hid_plugins[id], so
+	 * there is no need to protect the our access during registration, as
+	 * any reader in prior must have got NULL, i.e., there is nothing to
+	 * protect or synchronize.
+	 *
+	 * However, try our best to do some sanity checks.
+	 */
+	if (WARN_ON(rcu_access_pointer(hid_plugins[id])))
+		return -EEXIST;
+
+	rcu_assign_pointer(hid_plugins[id], plugin);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__hid_plugin_register);
+
+void __hid_plugin_unregister(enum hid_plugin_id id, struct hid_plugin *plugin)
+{
+	if (NR_HID_PLUGINS <= 0)
+		return;
+
+	if (WARN_ON(rcu_access_pointer(hid_plugins[id]) != plugin))
+		return;
+
+	rcu_assign_pointer(hid_plugins[id], NULL);
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(__hid_plugin_unregister);
diff --git a/drivers/hid/hid-plugin.h b/drivers/hid/hid-plugin.h
new file mode 100644
index 000000000000..e7bc98639d9f
--- /dev/null
+++ b/drivers/hid/hid-plugin.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  HID plugin helpers
+ *
+ *  Copyright (c) 2026 Rong Zhang <i@rong.moe>
+ */
+
+#ifndef __HID_PLUGIN_H
+#define __HID_PLUGIN_H
+
+#include <linux/bug.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/kconfig.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+enum hid_plugin_id {
+	HID_PLUGIN_DISABLED	= -1,
+
+	NR_HID_PLUGINS,
+};
+
+#if !IS_ENABLED(CONFIG_HID_PLUGIN)
+static_assert(NR_HID_PLUGINS == 0);
+#endif
+
+struct hid_plugin {
+	struct module *owner;
+};
+
+struct hid_plugin *__hid_plugin_get(enum hid_plugin_id id);
+int __hid_plugin_register(enum hid_plugin_id id, struct hid_plugin *plugin);
+void __hid_plugin_unregister(enum hid_plugin_id id, struct hid_plugin *plugin);
+
+/**
+ * hid_plugin_enabled() - Check if an HID plugin is enabled.
+ * @id: Unique ID of the desired HID plugin
+ *
+ * Return: boolean.
+ */
+static __always_inline bool hid_plugin_enabled(enum hid_plugin_id id)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(id) || id >= NR_HID_PLUGINS || id < HID_PLUGIN_DISABLED);
+
+	return id != HID_PLUGIN_DISABLED;
+}
+
+/**
+ * hid_plugin_get() - Get an HID plugin and increment its refcount.
+ * @id: Unique ID of the desired HID plugin
+ *
+ * If the plugin is builtin or loaded, a pointer to the plugin is returned with
+ * the plugin's module refcount incremented. If the plugin is unloading during
+ * the process, ERR_PTR(-ENXIO) is returned.
+ *
+ * If the plugin is disabled, ERR_PTR(-ENOENT) is returned.
+ *
+ * Otherwise, try loading the module with request_module() and then increment
+ * its refcount. If the plugin fails to load, ERR_PTR(-ENXIO) is returned.
+ *
+ * Return: The HID plugin corresponding to @id on success, or an ERR_PTR().
+ * Never NULL.
+ */
+static __always_inline struct hid_plugin *hid_plugin_get(enum hid_plugin_id id)
+{
+	if (hid_plugin_enabled(id))
+		return __hid_plugin_get(id);
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
+ * hid_plugin_put() - Decrement an HID plugin's refcount.
+ * @id: Unique ID of @plugin
+ * @plugin: Pointer to the HID plugin
+ *
+ * Decrement @plugin's refcount, unless it's disabled.
+ */
+static __always_inline void hid_plugin_put(enum hid_plugin_id id, struct hid_plugin *plugin)
+{
+	if (hid_plugin_enabled(id) && !IS_ERR_OR_NULL(plugin))
+		module_put(plugin->owner);
+}
+
+/**
+ * hid_plugin_register() - Register an HID plugin.
+ * @id: Unique ID of @plugin
+ * @plugin: Pointer to the HID plugin
+ *
+ * Return: 0 on success, or an error.
+ */
+static __always_inline int hid_plugin_register(enum hid_plugin_id id, struct hid_plugin *plugin)
+{
+	BUILD_BUG_ON(!hid_plugin_enabled(id));
+
+	return __hid_plugin_register(id, plugin);
+}
+
+/**
+ * hid_plugin_unregister() - Unregister an HID plugin.
+ * @id: Unique ID of @plugin
+ * @plugin: Pointer to the HID plugin
+ */
+static __always_inline void hid_plugin_unregister(enum hid_plugin_id id, struct hid_plugin *plugin)
+{
+	BUILD_BUG_ON(!hid_plugin_enabled(id));
+
+	__hid_plugin_unregister(id, plugin);
+}
+
+/*
+ * Usage:
+ *
+ *	struct foo_plugin {
+ *		struct hid_plugin hp;
+ *		void (*bar)(struct hid_device *hdev);
+ *	};
+ *
+ *	static struct foo_plugin foo_plugin = {
+ *		.hp = {
+ *			.owner = THIS_MODULE,
+ *		},
+ *		.bar = hid_foo_bar,
+ *	};
+ *	module_hid_plugin(foo, HID_PLUGIN_FOO, &foo_plugin.hp);
+ */
+#define module_hid_plugin(_name, _id, _plugin)		\
+static int __init hid_plugin_##_name##_init(void)	\
+{							\
+	return hid_plugin_register(_id, _plugin);	\
+}							\
+subsys_initcall(hid_plugin_##_name##_init);		\
+static void __exit hid_plugin_##_name##_exit(void)	\
+{							\
+	hid_plugin_unregister(_id, _plugin);		\
+}							\
+module_exit(hid_plugin_##_name##_exit)
+
+#endif /* __HID_PLUGIN_H */

-- 
2.55.0

