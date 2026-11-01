Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554970;
	b=z8cIb2ULpgsyk5vHyyWUV88mtEmHrKsgLIOV5Mx/0naAsEDmWOxYhNFY7izGY1yAzAXZ
	 90zhDBrcOGrfD/IwugQCXXcyO4GNc8sasLHghn6uNfY1rpjxN+ZIR/g+ZQeAJn0BBxdZT
	 Dng+yb/ZdD4Y0R6z3F8He5NRm6ozOtX1qXIQ+g+sXSZCgGpuAtPvy23nxiHO0vEfAD234
	 JNdeUkGORY9f5LZfJuLMSHVouBHQmxTqBwamR1pZbsvNTDMzXuRF9pQ8trZmUCHO4KWLy
	 EiHgPNNiblt2tMg955P7hvRWoawZd93okeT3rHi+JbwEag+dQImZa1+0TrSUSG81J7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554970;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=3Z0oePM/NYjKIN6WmhUxB5eRDhUIibp/qbMUl/KTSkI=;
	b=AjU5Qvh1NQyM/GuQo64QWWpSrkDTRj+qmRrqdzJUJnfZnGAvfy5eDxe/dCTmXovRrHbv
	 nrMtOJjqUz3MxeEhKKtfblhSKfhbV2RG/O47oNd+TgOO52/j+eSHb//rBDQqONPMcHLke
	 Y6w2WR6MmKuPbxXf5obC9U2S/b6zDL7dn8Bm2iDEfy6XsGeeAirdMbOlrc+sA0YbDG8Zf
	 mkRf0XxO1oeUfYwNThXbKfxL81uOScMPw2mpfKzW2/vxnG4/dC1tuWvzeDm1ue5g7xfpb
	 HgGxj5Dvg08dNPRS1b2+m8Ddr5/dm65Pptjm3yRKka2aE/Vf2eU8B0uDhJcmoJOKZsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=WNjbKp5T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.108
Received: from sender6-pp-e108.zoho.com (sender6-pp-e108.zoho.com [165.173.180.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79B606A325;
	Sun,  1 Nov 2026 17:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA79B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=WNjbKp5T
ARC-Seal: i=1; a=rsa-sha256; t=1793554911; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=etcHy1OMQOQQ1YLHCfWTV27HHPyqHVnm7MPbh4VEjMlCRFmFtLdkF0+/w4BlaobSQhi2BkDMEzHp8gRwEn0rM/3tKRKWZhvfz+6KY1J/nUvAvzjx31+O8aqQwYAY/TRcsD6KcuF9AqMwbZLQlABRxyqAZ1S06lojfei5jwn87sU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554911; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3Z0oePM/NYjKIN6WmhUxB5eRDhUIibp/qbMUl/KTSkI=; 
	b=bNZbPNXkMSJVfpUxa7beMdGoiQKt0vezBgiAjXudRupBsfPCdwp3z7XNBBzjpOXoAy3MaAbyAq4KsFaW/cGEoSwTnUB57hORR2m1oRPJnsemfE3UV/uDneJmIYsgCUfy7x4n4SQbMSObmzPuIiwoIKhNEDJpUCa6pdUJ75MqSNI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=WNjbKp5T9JxXLVN2XXZzhp+e8PVuueUDvrDVZglmsXjM2il8wUeZ58Bx6z0cXCD7yNr6p1mgrErVrRZOTAmVKkExsK7h/lcLV2h6Sc01mqmC/JoS9wUJfeGdErR0KGGJNPurrcfOgAH2/PUFHNG5lTDEPhCyjhVFM/ipdWRXtJZ2eekTytDF+uDCC8bgdErJxYPLBruPclyPCF/w3CK+TAcw8iB542VkqmDtK3CExv2RqrKgKKPTy0W1Zj0Y4y+pvqNbZGuoBAgPhowZlELLXQ6THKDNHctesihNrGq/XmwZchhsJAKGwhk081lHwE4Oz8vgwwyZjiJGXvG1EU19aA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=3Z0oePM/NYjKIN6WmhUxB5eRDhUIibp/qbMUl/KTSkI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554909116889.4038146434671;
	Sun, 1 Nov 2026 09:41:49 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:25 +0800
Subject: [PATCH 8/9] HID: haptic: Convert into a loadable plugin
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
Message-Id: <20261102-hid-haptic-kmod-v1-8-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
In-Reply-To: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
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
index fdec2f6b640d..a7d4953c3844 100644
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
index dcecb89e8fd5..d5e33b470e36 100644
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
@@ -456,7 +451,20 @@ int hid_haptic_init(struct hid_device *hdev,
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
index d09068689a5e..d3e8fb9aa3b4 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,10 +5,13 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/slab.h>
 
+#include "hid-plugin.h"
+
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
 #define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
 
@@ -53,6 +56,14 @@ struct hid_haptic_device {
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
@@ -147,8 +158,22 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
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

