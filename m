Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538895;
	b=03K6tIzwbN7p72PMO9nzlrILLvXWiCEj4jMcnsPZ2rV/Qf2XyQz8NCazpcJfygR7bVZD
	 WUZxth+uFzyvMY1VCaO69YJJpHFtJgQtGCzf/pMUIV2M60d4YOCFVEyPbMAVcBLAgfYNo
	 0/i57YVkMqzUGI7+Nv9EGO6W8z3FVUSLT5ZTtULL0xGCspYfoufMXL5z25H25iuLZ3UKj
	 pGmnu9aqR9tfUqMaOHet/IFGqhF85WfH/o8OFpvNkw8ue2ti02JVo+8f5Vu/ia2p7QS95
	 DG9wDfmk64rh4nnuS3bolYVkLZ0dIOwR1m1NxLOZa+oXOkO0upT/23RREBEgv3VwHtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538895;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=cEyf9zYb1WqFwKxRefPYYC34C5+6mugq73n5p4zoHKI=;
	b=Y1yJg1rNV63r0/nt86wNrx8hFpYatvibCKPLo4MrAP3Bug6pe9MQymbOXZAUlqhDyDuF
	 FjeFw5YLXhKd+z1OIZlHjgHHHgl4l+TIfONxm86xWFgF/kPcfHnRXn0/CtursEqRWLbw8
	 2g5Mt1XzLr8NLy5p9yK/vl86nSj2qS2IlqVrnNHD4u1bck3kngk8D3qOvVrJX8P8mopMp
	 vKdX76yeKadeNPHxFJU/1DrVPazoy49ZeVrZBQUFlhxIA9flNtphG761pH2QMF8m1KHFN
	 4isQyeoiGpRS2pVj+MDy8c+3GPaOtBSPRLGTuqfA7a/c09wSHmiH2p3xs5qRlgHvrIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=DIF+VByX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006F606A6A0;
	Tue, 24 Nov 2026 16:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7006F606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=DIF+VByX
ARC-Seal: i=1; a=rsa-sha256; t=1795538741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U6y5MuxQJm9ohL6z5Lov1DSFh38AZJo+ey8XnXEWJ688BCXaBHto5zcf3SgDLGIAQf4940Rs8mnDGisogeXLYvnOuP2SM0A8sXraIG9FIYHtg54V/XZ7gVD/rMbeM2frH4Jg+j41RO1l6Oql/wb0QoTJBlrkA5fkluAl0c1Kylw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538741; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cEyf9zYb1WqFwKxRefPYYC34C5+6mugq73n5p4zoHKI=; 
	b=EuhsE7uOtx1KB+c3zeuZquZ8G4UiMtJgDUFNkdRR1wqOIfUjvEf3fboH2MBIZGEM2dN6IHXVlJIX/SrL7yQOT8PG0LsEiEM/SrUoyXLtx4wH0oyco4DVVftPTRc2h44ltJCJVPaCMKSU/vixEd7pYT7AfC2YDtqBHbIBulQauqI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=DIF+VByXTq9PN8LjEnf4yeyYOa8W/7NYkUjaHZAYqTDuit/dvpWEGLEbMjBClhKS1w7lYR99ltL/wAq/Oo7/x5blGgGECl9uZK+VTzVEN79cKEghtF3ZPAuyR2qMgDh5VX0YbCviG9duFv9ikz7WGwGVIwESc5l9qQrj7i+MA+F9SzrDCBGWpGkRAh8CgFD8V5gSVVTBPlQ9PlRIrS8JRZurgd1SMKRGr8nd6qeFdBU//wqlRKDNqa8PhHh5g3JEyrpzTqGno5AXAlbDo1ZDHvoRGps8i9smXgTqMhE7bEqGr+UgfcAk3HSGVUxaYLVpmlGGu8P44nQxy7bRRF/WcA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=cEyf9zYb1WqFwKxRefPYYC34C5+6mugq73n5p4zoHKI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538738291181.10165998462412;
	Tue, 24 Nov 2026 08:45:38 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:36 +0800
Subject: [PATCH v4 8/9] HID: haptic: Convert into a loadable plugin module
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
Message-Id: <20261125-hid-haptic-kmod-v4-8-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Commit 083a4f3f3cc7 ("HID: Kconfig: Fix build error from
CONFIG_HID_HAPTIC") built hid-haptic into vmlinux or hid.ko. This is not
optimal for generic kernel images, as a platform with no multitouch
device doesn't need it anyway. It's also a bit harsh for enabling it in
distribution kernels.

With the new hid-plugin framework, hid-haptic can be easily converted
into a loadable plugin module, so that hid-multitouch only requests it
on demand.

The redaundent `default n' statement is also removed for tidiness since
we are anyway touching its context.

Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
Signed-off-by: Rong Zhang <i@rong.moe>
---
 MAINTAINERS              |  1 +
 drivers/hid/Kconfig      |  7 +++++--
 drivers/hid/Makefile     |  2 +-
 drivers/hid/hid-haptic.c | 23 +++++++++++++++++++----
 drivers/hid/hid-haptic.h | 29 +++++++++++++++++++++++++++--
 drivers/hid/hid-plugin.c |  3 +++
 drivers/hid/hid-plugin.h |  6 ++++++
 7 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24bcc700ccfe..68f79c0f2ecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11906,6 +11906,7 @@ HID PLUGINS
 M:	Rong Zhang <i@rong.moe>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	drivers/hid/hid-haptic.*
 F:	drivers/hid/hid-plugin.*
 
 HID PULSAR DRIVER
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 604683b4a4a9..97cb4caf9d7e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -106,9 +106,10 @@ menuconfig HID_PLUGIN
 
 	If unsure, say N.
 
+if HID_PLUGIN
+
 config HID_HAPTIC
-	bool "Haptic touchpad support"
-	default n
+	tristate "Haptic touchpad support"
 	help
 	Support for touchpads with force sensors and haptic actuators instead of a
 	traditional button.
@@ -117,6 +118,8 @@ config HID_HAPTIC
 
 	If unsure, say N.
 
+endif # HID_PLUGIN
+
 menu "Special HID drivers"
 
 config HID_A4TECH
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index b41aa3f52a94..3360347c1cb8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -6,7 +6,7 @@ hid-y			:= hid-core.o hid-input.o hid-quirks.o
 hid-$(CONFIG_DEBUG_FS)		+= hid-debug.o
 hid-$(CONFIG_HID_PLUGIN)	+= hid-plugin.o
 
-hid-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
+obj-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
 
 obj-$(CONFIG_HID_BPF)		+= bpf/
 
diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index cbe834a77fd4..50d6673c7c21 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -310,11 +310,12 @@ static void hid_haptic_destroy(struct ff_device *ff)
 
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
+
+	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
 }
 
-int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device *haptic,
-		    struct input_dev *dev)
+static int __hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+			     struct input_dev *dev)
 {
 	struct ff_device *ff;
 	int ret = 0, r;
@@ -436,6 +437,20 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->hid_usage_map = NULL;
 exit:
 	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name, ret);
+	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hid_haptic_init);
+
+static struct hid_plugin_haptic hid_plugin_haptic = {
+	.hp = {
+		.owner = THIS_MODULE,
+	},
+	.init = __hid_haptic_init,
+};
+module_hid_plugin(haptic, HID_PLUGIN_HAPTIC, &hid_plugin_haptic.hp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
+MODULE_AUTHOR("Jonathan Denose <jdenose@google.com>");
+MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
+MODULE_DESCRIPTION("HID helpers for Haptics Page");
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index fd7093e1764a..a459c5eb9580 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,9 +5,12 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/hid.h>
 
+#include "hid-plugin.h"
+
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
 #define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
 
@@ -52,6 +55,14 @@ struct hid_haptic_device {
 	u16 release_ordinal;
 	struct hid_haptic_effect *effect;
 	struct hid_haptic_effect stop_effect;
+
+	struct hid_plugin_haptic *self_plugin;
+};
+
+struct hid_plugin_haptic {
+	struct hid_plugin hp;
+	int (*init)(struct hid_device *hdev, struct hid_haptic_device *haptic,
+		    struct input_dev *dev);
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
@@ -151,8 +162,22 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
-		    struct input_dev *dev);
+static inline int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+				  struct input_dev *dev)
+{
+	struct hid_plugin_haptic *self_plugin;
+	struct hid_plugin *plugin;
+
+	plugin = hid_plugin_get(HID_PLUGIN_HAPTIC);
+	if (IS_ERR(plugin))
+		return PTR_ERR(plugin);
+
+	self_plugin = container_of(plugin, struct hid_plugin_haptic, hp);
+
+	haptic->self_plugin = self_plugin;
+
+	return self_plugin->init(hdev, haptic, dev);
+}
 
 static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 					       struct hid_haptic_device *haptic,
diff --git a/drivers/hid/hid-plugin.c b/drivers/hid/hid-plugin.c
index 288dedd21253..a84cff20ca11 100644
--- a/drivers/hid/hid-plugin.c
+++ b/drivers/hid/hid-plugin.c
@@ -18,6 +18,9 @@
 #include "hid-plugin.h"
 
 static const char * const hid_plugin_mod_names[NR_HID_PLUGINS] = {
+#if IS_MODULE(CONFIG_HID_HAPTIC)
+	[HID_PLUGIN_HAPTIC] = "hid-haptic",
+#endif
 };
 
 static struct hid_plugin __rcu *hid_plugins[NR_HID_PLUGINS];
diff --git a/drivers/hid/hid-plugin.h b/drivers/hid/hid-plugin.h
index e7bc98639d9f..e2e157b23b69 100644
--- a/drivers/hid/hid-plugin.h
+++ b/drivers/hid/hid-plugin.h
@@ -19,6 +19,12 @@
 enum hid_plugin_id {
 	HID_PLUGIN_DISABLED	= -1,
 
+#if IS_ENABLED(CONFIG_HID_HAPTIC)
+	HID_PLUGIN_HAPTIC,
+#else
+#define HID_PLUGIN_HAPTIC	HID_PLUGIN_DISABLED
+#endif
+
 	NR_HID_PLUGINS,
 };
 

-- 
2.55.0

