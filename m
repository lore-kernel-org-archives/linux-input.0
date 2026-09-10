Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C23A83A9
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010502; cv=none; b=jOYFC6cMvwCbE1k6Rt2LDy+FquQC3y0ygD/rp28ozFFFE+FtHhdUSeLUTnSzRDM94K6dyR70ADM/SHLkj2torhZKIsqE+0206NY1mBvOHocKTy/wy+bftsk48vofNNQ+VSDCseU01QRcl1GZrRjgJWfbuXvOSVvq6W7cEcUX4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010502; c=relaxed/simple;
	bh=AeLnTpy9Imgwdp3HIzHn/henHDdgDKkOfb55UxqoU0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQH0Q4+PKmcYKIGC6HcGEBgIy4dhX4xKPtRL67FVhYTsda0sWf2Uycy5EQFGAGQgfQa1N+1/6iNKQgd3wSHJfKvtW1FqIlwvW4Tf0Pb0Ucc0+OEvJIGZ/f4fImSTh36D8v9hWastYh/rf1IYjKzGR07yISHwSwGT+UYbite/QFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLj+z0me; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLj+z0me"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-801d2f7a00eso164361a34.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010499; x=1789615299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgtfPs4JGN+ren3NYbKyWAaqrzZ1zJ4bq29kq6OscHA=;
        b=GLj+z0mehQBKa3TMx2Zmj5d7Ej9p+vnFaLzGUwAUTpylHm22EYr5FrcLQrjE443Mxo
         5i2qKnatpN4qJTp3Og8GkXW0DoPyfrX9DsfMLGRbHSQUWixgPCapfpgGIhZ9zxEG81t2
         SgY8rEpSqyGYbx4Qu4nQ/rGlAsB5fqNgxsEEX9Us2/QkhkvX17l8HIDF5V25OCrTmQaf
         mncl5o1FYsnYnPUdlX3CrC+YadHSQiVeFGDQxZeEcXk5ry5vAMCVMnVZm/1Nu7xvwuKW
         q4GHGsAXFxTRhHkGzen+/+gw1gVRkJlmV1gko5tTPTs5bdakoOLCdrhB8cX+95vqWILI
         L/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010499; x=1789615299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgtfPs4JGN+ren3NYbKyWAaqrzZ1zJ4bq29kq6OscHA=;
        b=BWgJqlSnRyc5qWrX0ytOgyX+1pA7ldvJukW1M4gjMMgtbrfJF96Qq+l/u1cq9y3pWt
         DrDTS+XsiIuIQr9afg2vbZTpl2UtSL7PpMzKw9O/tpcZXQDGXAiD/xZq49jDIPJjAKIR
         qxK2o4Dyq55gVrLINp+yUQptVDYZeymYzFfIlH/1Qt3nPIbpd9maSUa5+XOjKflzmX2a
         1alhHXpR5Jl3LsindmY/33xF8qpQr1JD+/8S72H4al88tXNJ8CWrPwIeN3I09TAIib5R
         OBUf1hngnkXTfJDu2NH7YrUPbpZJZy9U3vc4Ig70AXNIwoKsAPtG0ljOI9P5DJf5oe6o
         NnKg==
X-Gm-Message-State: AFuF++kpUo7TIlUhfsnHmeI21F+K9/14kpGv4YtLStvh5bql5EGQ+qYy
	/Tu6JJtCMnEcDo/1eVOsADavVFCZZi8kaCW4n+ySSZpNqxWKD7OLa1PJ
X-Gm-Gg: AYBFou16dLYXlVqCa1HMReUodbk9Yq8GXSqEKZqQJXSaYWbNpgztKhYeZMI9uAawURY
	x3i2r6yhTooeOF2R/TpqJtvolvTiHTzvLCkazo1Gm1rB6f89seRr/mNl5wuMB67KYFSy2SabUR+
	+vVokUFZJ6GsKNID02+M3Y3P5RW0DqKAKPiWIWUb3vUxsJtUPWNzMQFyr028wCMCllNDL4B6aq8
	ftXPJC4GUtKFMlWypgSDIQQBzHFcJ67GcIbZUJO6FF3UXzVXnkUQGqyu3AidwheAQtJEsacMpP4
	+/dL71lBZs7SyyK2M3W8ithrpwXl4n2MPA2R3cGRiWeGJiHwzRL/yQqTd8bqS7wu40cNfO2bgZV
	TJqz87gI/il5ME6i/6XelmmAwcrH7Za1W+2qUMOnVCSVtLvjsrE+BqcUOCt8ICQY6mezWpc/+IS
	zz8YAeWZElDYqcEu8d9TIeYG9UF8B5Z3rBe2ALi5NDl46NEV2hR2i1QqmOF8mbGsGvkwcThCu3y
	vH9kRsmhwGqwRmNB9tT6rvt1yIvXFRyzAfD87PiVGtSzc6Pq9BwNIczbQ==
X-Received: by 2002:a05:6830:a1c8:20b0:800:92d0:df8c with SMTP id 46e09a7af769-80092d0e1damr5057405a34.1.1789010499237;
        Wed, 09 Sep 2026 20:21:39 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:38 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] HID: hid-oxp: support three-page button maps on X2 controllers
Date: Wed,  9 Sep 2026 22:21:12 -0500
Message-ID: <20260910032115.28669-13-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ONEXPLAYER 3 and X2 Mini Pro need mapping format 0x02 and a third
page preserving the extra buttons' factory mappings. Use exact DMI
matches and select configuration interface 2; the other HID interfaces
remain available without duplicate configuration or LED registration.

Initialize each page with the selected format. Page three is fixed because
its factory encodings have no entries in the public mapping table.
Legacy devices keep their two-page format 0x20 transaction.

Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 94 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 8c44f57..48fa916 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/usb.h>
 #include <linux/workqueue.h>
 
 #include "hid-ids.h"
@@ -35,6 +36,8 @@
 
 #define OXP_MAPPING_GAMEPAD	0x01
 #define OXP_MAPPING_KEYBOARD	0x02
+#define OXP_BMAP_FORMAT_DEFAULT	0x20
+#define OXP_BMAP_FORMAT_X2	0x02
 #define OXP_FILL_PAGE_SLOT(page, btn)            \
 	{ .button_idx = (page)->btn.button_idx,  \
 	  .mapping_idx = (page)->btn.mapping_idx }
@@ -159,9 +162,9 @@ enum oxp_joybutton_index {
 	BUTTON_DRIGHT,
 	BUTTON_M1 =	0x22,
 	BUTTON_M2,
-	/* These are unused currently, reserved for future devices */
 	BUTTON_M3,
 	BUTTON_M4,
+	/* These are unused currently, reserved for future devices */
 	BUTTON_M5,
 	BUTTON_M6,
 };
@@ -209,8 +212,10 @@ struct oxp_hid_cfg {
 	struct oxp_bmap_page_1 *bmap_1;
 	struct oxp_bmap_page_2 *bmap_2;
 	bool gen2_work_initialized;
+	bool bmap_page_3;
 	u8 rumble_intensity;
 	u8 gamepad_mode;
+	u8 bmap_format;
 
 	/* RGB state */
 	struct delayed_work oxp_rgb_queue;
@@ -337,6 +342,9 @@ struct oxp_attr {
 
 struct quirk_entry {
 	bool hybrid_mcu;
+	bool bmap_page_3;
+	u8 cfg_interface_num;
+	u8 bmap_format;
 };
 
 static u16 get_usage_page(struct hid_device *hdev)
@@ -735,8 +743,17 @@ static void oxp_page_fill_data(char *buf, const struct oxp_button_idx *buttons,
 
 static int oxp_set_buttons(struct oxp_hid_cfg *cfg)
 {
-	u8 page_1[59] = { 0x02, 0x38, 0x20, 0x01, 0x01 };
-	u8 page_2[59] = { 0x02, 0x38, 0x20, 0x02, 0x01 };
+	u8 page_1[59] = { 0x02, 0x38, cfg->bmap_format, 0x01, 0x01 };
+	u8 page_2[59] = { 0x02, 0x38, cfg->bmap_format, 0x02, 0x01 };
+	u8 page_3[59] = {
+		0x02, 0x38, cfg->bmap_format, 0x03, 0x01,
+		/*
+		 * M3/M4 have no mutable sysfs mapping slots. Keep their factory
+		 * encodings, which are not entries in oxp_button_table.
+		 */
+		BUTTON_M3, OXP_MAPPING_KEYBOARD, 0x02, 0x05, 0x00, 0x00,
+		BUTTON_M4, OXP_MAPPING_GAMEPAD, 0x21, 0x00, 0x00, 0x00,
+	};
 	u16 up = get_usage_page(cfg->hdev);
 	int ret;
 
@@ -774,7 +791,11 @@ static int oxp_set_buttons(struct oxp_hid_cfg *cfg)
 	if (ret)
 		return ret;
 
-	return oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_2, ARRAY_SIZE(page_2));
+	ret = oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_2, ARRAY_SIZE(page_2));
+	if (ret || !cfg->bmap_page_3)
+		return ret;
+
+	return oxp_gen_2_property_out(cfg, OXP_FID_GEN2_KEY_STATE, page_3, ARRAY_SIZE(page_3));
 }
 
 static void oxp_reset_buttons(struct oxp_hid_cfg *cfg)
@@ -1550,7 +1571,13 @@ static struct quirk_entry quirk_hybrid_mcu = {
 	.hybrid_mcu = true,
 };
 
-static const struct dmi_system_id oxp_hybrid_mcu_list[] = {
+static struct quirk_entry quirk_x2_bmap = {
+	.bmap_format = OXP_BMAP_FORMAT_X2,
+	.bmap_page_3 = true,
+	.cfg_interface_num = 2,
+};
+
+static const struct dmi_system_id oxp_quirk_list[] = {
 	{
 		.ident = "OneXPlayer Apex",
 		.matches = {
@@ -1575,21 +1602,34 @@ static const struct dmi_system_id oxp_hybrid_mcu_list[] = {
 		},
 		.driver_data = &quirk_hybrid_mcu,
 	},
+	{
+		.ident = "OneXPlayer 3",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER 3"),
+		},
+		.driver_data = &quirk_x2_bmap,
+	},
+	{
+		.ident = "OneXPlayer X2 Mini Pro",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X2Mini PRO"),
+		},
+		.driver_data = &quirk_x2_bmap,
+	},
 	{},
 };
 
-static bool oxp_hybrid_mcu_device(void)
+static const struct quirk_entry *oxp_get_quirks(void)
 {
 	const struct dmi_system_id *dmi_id;
-	struct quirk_entry *quirks;
 
-	dmi_id = dmi_first_match(oxp_hybrid_mcu_list);
+	dmi_id = dmi_first_match(oxp_quirk_list);
 	if (!dmi_id)
-		return false;
+		return NULL;
 
-	quirks = dmi_id->driver_data;
-
-	return quirks->hybrid_mcu;
+	return dmi_id->driver_data;
 }
 
 static void oxp_drain_output(struct oxp_hid_cfg *cfg)
@@ -1613,6 +1653,21 @@ static void oxp_quiesce_work(struct oxp_hid_cfg *cfg)
 	oxp_drain_output(cfg);
 }
 
+static bool oxp_is_cfg_interface(struct hid_device *hdev,
+				 const struct quirk_entry *quirks)
+{
+	struct usb_interface *intf;
+
+	if (!quirks || !quirks->cfg_interface_num)
+		return true;
+	if (hdev->bus != BUS_USB)
+		return false;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	return intf->cur_altsetting->desc.bInterfaceNumber ==
+	       quirks->cfg_interface_num;
+}
+
 static void oxp_cfg_release(void *data)
 {
 	struct oxp_hid_cfg *cfg = data;
@@ -1620,7 +1675,8 @@ static void oxp_cfg_release(void *data)
 	hid_set_drvdata(cfg->hdev, NULL);
 }
 
-static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
+static int oxp_cfg_probe(struct hid_device *hdev, u16 up,
+			 const struct quirk_entry *quirks)
 {
 	struct oxp_bmap_page_1 *bmap_1;
 	struct oxp_bmap_page_2 *bmap_2;
@@ -1642,7 +1698,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	if (ret)
 		return ret;
 
-	if (up == GEN2_USAGE_PAGE && oxp_hybrid_mcu_device())
+	if (up == GEN2_USAGE_PAGE && quirks && quirks->hybrid_mcu)
 		goto skip_rgb;
 
 	cfg->cdev = oxp_cdev_rgb;
@@ -1693,6 +1749,9 @@ skip_rgb:
 
 	cfg->bmap_1 = bmap_1;
 	cfg->bmap_2 = bmap_2;
+	cfg->bmap_format = quirks && quirks->bmap_format ?
+			   quirks->bmap_format : OXP_BMAP_FORMAT_DEFAULT;
+	cfg->bmap_page_3 = quirks && quirks->bmap_page_3;
 	oxp_reset_buttons(cfg);
 	INIT_DELAYED_WORK(&cfg->oxp_btn_queue, oxp_btn_queue_fn);
 
@@ -1720,6 +1779,7 @@ err_quiesce:
 static int oxp_hid_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
+	const struct quirk_entry *quirks;
 	int ret;
 	u16 up;
 
@@ -1738,12 +1798,16 @@ static int oxp_hid_probe(struct hid_device *hdev,
 	}
 
 	up = get_usage_page(hdev);
+	quirks = oxp_get_quirks();
 	dev_dbg(&hdev->dev, "Got usage page %04x\n", up);
 
 	switch (up) {
 	case GEN1_USAGE_PAGE:
 	case GEN2_USAGE_PAGE:
-		ret = oxp_cfg_probe(hdev, up);
+		if (!oxp_is_cfg_interface(hdev, quirks))
+			return 0;
+
+		ret = oxp_cfg_probe(hdev, up, quirks);
 		if (ret) {
 			hid_hw_close(hdev);
 			hid_hw_stop(hdev);
