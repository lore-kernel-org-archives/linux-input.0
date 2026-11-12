Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506097;
	b=iuBKWa8Mj201/1RaW9fXk7+N1qPW0Q8IsMRhsmMhIXJNswqo4wRtTdzHqSy9WjRdahNQ
	 tvyRQVuweg8feyWVy6U4nHdBm4Wc/WXVYgimc9XoX51ZxmME/19aSE6sU+VSVCPWXOhx2
	 u1VU/4VaLhSRzpdLiRRjOhLvFkp/Z8+QwC+URoKWeGOnrT/lZGDBdY/Tjprsa5nQ2GeSx
	 /x0Xj/nHlK/L8PikR7mmgHD/s29mGs308XAYoyaObK3nVjNL6khXoeskLPFRDJ0l1/8EN
	 YxsZI1UMvh3kGmvxznWGIMRrrQcp2B12lVmtJZ0qQJBiAAdPBWPyQVSSkeskIfJbAcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506097;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=x7mY0QkAA7+F0qadZebt54AEahfN8uYW+BAmTwfPG3M=;
	b=GlW2wbpqL9UjRaSXCgDf1AZwvevnM82AoXH978TjUZhdiYPgTOI+2x1Ilk5zrjKj+O0V
	 kuC3abCVT5fF4AFJ2hpAT6SnBIcGvQzJCplZF3y3XgOW5EkBnva1PbSNyNKKKkBZYwUu3
	 PYmgTLaIdnTdrJ8vf1MQivCSgutCM37K+JWu+rAyKqzEEQTBf5r0zRhAoevvq/kL/EOl1
	 BG2ziLHx7/8PnMoOfwj2V+YPcyCl+hjcjCj4Ou5Pr4qgvA31SD+CVv7lavND36oh250XM
	 Di3ZCWvBmnsp3c2oN51F8po0uY+ne1gAowXNkqeIDnGz6BfOCxgHqVKrtP7tiC/MurA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b="P/U3LNyZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A5606A327;
	Thu, 12 Nov 2026 17:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7A5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=P/U3LNyZ
ARC-Seal: i=1; a=rsa-sha256; t=1794506063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YP0VuVHtqkoP3vvWrWVO+IFSspkJFfLBxMs+YqF2GuH2TiacdWheNcCdRFBCmrihWdjzNJr2xXswl3uGpnqyVJ8A/HoPHq1auSV9Ay7FU90967GYz7qUbGtEW1GngAFaZx9AlnkzO024uGWgl0PjpOeGZSn7JBpXdcvgBBKax6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506063; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x7mY0QkAA7+F0qadZebt54AEahfN8uYW+BAmTwfPG3M=; 
	b=aB2xo/SS5m3J9DdaaHq2K/7uXVKg3Qo3O+XutwTiKsvRCCzwjUB+m4Xuy2Kx+UprHgENp4m8PTYmILL+bN/e73u9/2sBqyQjetScRdY2xxNBM1UlsrEfpFVIy0Ob6wa1sogDk5WMEWEIPh86prR4/i8Vu+Nz2kLo2g9sow8f3uA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=P/U3LNyZkalp59qqfe8xjF50DNrkH4QmUDeokvp3eI9VL32p4EMlE0FYgK2cVvwJywNjf4j+oZ8ZdQT/f1bZBfVdQ+AcPpy7mM78yzCeyww/1GcLNizihQuERAa4gXjvO0SS93rv2ZtEdaozIOyeHEP+l1ucG/aYrPV7jLEzYTRcBeqyIOMAqse1+cwOW36YtiHlI/1AyaGobN8gmujK+4lspyV7LfYORVorKQRwkt7s04DQk2Y6lx5CxY5L9Lcb/0vcxmXLHitehc05nL+fFFAzODqz51enZSfo4JZEK9JfHcKA1cl2k0E5lLyxDiwAYqkYmzOmoJR1eliXPgCE7Q==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=x7mY0QkAA7+F0qadZebt54AEahfN8uYW+BAmTwfPG3M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506062086245.89522074931494;
	Thu, 12 Nov 2026 09:54:22 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:53:57 +0800
Subject: [PATCH v3 4/9] HID: haptic, multitouch: Fix haptic device
 double-free and unnecessary allocation
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
Message-Id: <20261113-hid-haptic-kmod-v3-4-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

The haptic device is allocated by devm_kzalloc(), which will be freed by
devres on HID device release. At that time, the ff core has already
freed it on input device release previously, causing double-free.

Allocate the haptic device using kzalloc_obj() to ensure its release can
be safely delegates to the ff core.

The allocation code is also moved to hid-haptic.h, so that it can be
replaced by a stub in !CONFIG_HID_HAPTIC builds, eliminating the
meaningless alloc-and-free sequence.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Correct the Fixes: tag (thanks Sashiko)
---
 drivers/hid/hid-haptic.h     | 17 +++++++++++++++++
 drivers/hid/hid-multitouch.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index cd4d9c74d2dc..7878cd73ccdb 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/err.h>
 #include <linux/hid.h>
 
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
@@ -54,6 +55,17 @@ struct hid_haptic_device {
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	struct hid_haptic_device *haptic;
+
+	haptic = kzalloc_obj(struct hid_haptic_device);
+	if (haptic)
+		haptic->hdev = hdev;
+
+	return haptic;
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
@@ -80,6 +92,11 @@ void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
 #else
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5eea774dee44..a9c8396c804e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -34,6 +34,7 @@
 #include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -2129,11 +2130,18 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc_obj(&hdev->dev, *(td->haptic));
-	if (!td->haptic)
+
+	td->haptic = hid_haptic_alloc(hdev);
+	if (IS_ERR(td->haptic)) {
+		ret = PTR_ERR(td->haptic);
+		if (ret == -EOPNOTSUPP)
+			td->haptic = NULL;
+		else
+			return ret;
+	} else if (!td->haptic) {
 		return -ENOMEM;
+	}
 
-	td->haptic->hdev = hdev;
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
@@ -2178,12 +2186,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2193,7 +2203,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2202,10 +2212,19 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
-	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+	ret = 0;
 
-	return 0;
+out:
+	/*
+	 * Don't double free when the haptic device has been delegated to the ff
+	 * core.
+	 */
+	if (td->haptic && !td->is_haptic_touchpad) {
+		kfree(td->haptic);
+		td->haptic = NULL;
+	}
+
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)

-- 
2.55.0

