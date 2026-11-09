Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253875;
	b=x25/fbho0ENYhtYkyY5esoHTQwkATkkVUDV0v7lou0R2jLnoS+YGodT/TR/6FDjPmgad
	 F/G9K2cXNfbWN8Lqwo+zJIKtn8WbjX5OTSdDVua+wQHfvT9NNKni09lmvc8MGG2bgUbpR
	 NLYMffGXra7kHmIJiVOQvBrmBq8+Df/7R6tMQqDM4bIhEEQpBJRPP8o5ZJtQIfbV2IF8Q
	 ssrXeoV/z0V0/+DvqJlHku0D5TPvcgX70TqUbE92CY2uTNpWk5rrLuY5ivnWNIughn19C
	 olPkcNig7udW3CN+IJsoNpBdfDh3Ux1hHLd1THHA4e+MkPQwn8JxhEyB3aTY+XOveQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253875;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=GtZIiMVAorFgxcP6bj1kfdPx2m2wDqQaeqlnnusmm+8=;
	b=msrJJBqPPlDNppFIO9RS/qphYedCDY9iPMTKTnmm/gfweYDJOzk3LCv3uXQDnzaMgn7R
	 UdPO0XB/lkjDz73I8Ae5AG/BBlAD/Hpytu+e0uk7oT9XAj6pDVeSCHHlJjZa5X8osUYAr
	 +AR0FmuhkNYT7EaWLwVlfHkoBVdcEZnYZWzhH2FB47chd4uJZUAzWhHr+JFTiTNe7Be/2
	 Ivp6KHadsRaQxXXOXxNfujexdCPCucG5vQdKvNp/JSiTdZIDKKgpxj7iJ6VOddlRc6VrJ
	 w6+0cn3iBBl0bth6IIApma+XUf+dRfAhVQLbSXstMWd0twQ77GDgDcTuoJxZVyje1jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=V1IEN6lR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CB60A2614;
	Mon,  9 Nov 2026 19:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A4CB60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=V1IEN6lR
ARC-Seal: i=1; a=rsa-sha256; t=1794253818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UFRM6xRAkCTl+joK7LXLzRB7Ds8w/ZVh6UVAC05SbWUYeL+XE/GBGt76alhPQifvobo3JcZQmdVM4FNOZyfSEFvj2aM8pw+vYBdristFL+2b9l12EOW0OPy6zury0i5gamfNZn2xqW2WY8TtwZ1RPMruiEu5uc5w3wAhJh7xHfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253818; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GtZIiMVAorFgxcP6bj1kfdPx2m2wDqQaeqlnnusmm+8=; 
	b=SBDvF2JsclPO0YlZrZ47xRd7bob9gzxzJiOMtPL9mIhEthbIitsNKFJGru8axR369og2k9gTpK6M2NMaezJxTZqKgRHbSTdTDi7v2tC3b8QmSrk/nNaCJUFSw+g08NrerqAS1YAqOO57AYe0qmZUuXN4zWSbrQkwSKoxeyYinZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=V1IEN6lRAlm/wg67erlMBeyzzjXRMQsjyYgLQDhER0IPvnyLgpPNdZMSub61XcP2ehNeofPfGRzECVHiAGSUjopXWLI/Jdr48El1Y0lrq2pa/BnqiDqD+cxQBOmSRLP+iz067NKLSKI1xGyZyerc2bmpqy9c/Jhabl4wmaJEY2roOoT21fyABut92Yw26QdSxKSkrE7peYdlvxYKNOTGVU0OQNNUMpWljhx01fxqJjQtUWGsopE+6o6x18KteBkg7YW9G7rUwatGM/6z3iJO2qPfrpupkOFjSfIoKgO76axsAFW1uj4NPwI73R9Iu7UfXf906LS1Z821+tY9KIIetA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=GtZIiMVAorFgxcP6bj1kfdPx2m2wDqQaeqlnnusmm+8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253816691876.3037508681837;
	Mon, 9 Nov 2026 11:50:16 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:45 +0800
Subject: [PATCH v2 8/9] HID: haptic: Convert into a loadable plugin module
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
Message-Id: <20261110-hid-haptic-kmod-v2-8-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
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
 drivers/hid/hid-haptic.c | 28 ++++++++++++++++++----------
 drivers/hid/hid-haptic.h | 29 +++++++++++++++++++++++++++--
 drivers/hid/hid-plugin.c |  3 +++
 drivers/hid/hid-plugin.h |  6 ++++++
 7 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06c82b4a7614..b772148c031c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11909,6 +11909,7 @@ HID PLUGINS
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
index a6f3ec514504..0e9708d1f3a9 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -315,12 +315,11 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	if (hdev)
 		put_device(&hdev->dev);
 
-	module_put(THIS_MODULE);
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
@@ -328,10 +327,6 @@ int hid_haptic_init(struct hid_device *hdev,
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
 
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		return -ENXIO;
-	}
 	if (!get_device(&hdev->dev)) {
 		dev_err(&hdev->dev, "Failed to get hdev device.\n");
 		ret = -ENXIO;
@@ -454,7 +449,20 @@ int hid_haptic_init(struct hid_device *hdev,
 	put_device(&hdev->dev);
 exit:
 	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name, ret);
-	module_put(THIS_MODULE);
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
index 6196041eb4f8..a71ccee569f3 100644
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
@@ -152,8 +163,22 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
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
index a83275df038c..7357f81c3aac 100644
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
index 4038325c51a0..20d1b80a98c8 100644
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

