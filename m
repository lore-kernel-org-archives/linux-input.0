Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EE3A759C
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010501; cv=none; b=R6yOlq+xo/D8MSQrFZUUBM87qEycqGhknL/lacNB9AHy6JkMs+4ft9rkR7HPUSb4Ca6+dU9+Np8p2KB21jmmCKTAehsnmdPkejf6yVqcEBWRzNDi3M4ANPj3tiBXe7i/d6Oov3k40V99fweIyY6y7/rTlW4w1SN+ZRHg3rsaHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010501; c=relaxed/simple;
	bh=GwMo0o8oCLVlyC7Dxi4sXtvc2pZog3douuyhlz9sz2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbdzMuV3GE9+HAwipCPDQkK1a5Cm+/9ivsl1oP5kzLHum5Wxl2hV5ULpr1cDqcGDN6FboD7lmfvBPk6iK0FST9Sd+sUnWoOuXfMAdkQhFIiRL+GCGzIvbmk158TZyy0REAjx3WcXjqp0G5/rraktJHcRzjEc7N1AFibGi5X8J8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRTQ8pvh; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRTQ8pvh"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-801d2f7a00eso164359a34.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010498; x=1789615298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6MrMveQfRSLeZLxuVHTxBa8WIaiqwHHuULzMI/J9Yg=;
        b=aRTQ8pvhTJvg8VSzuwvlsFJPxfXLZYVgbKbY/t7vhnbbxUjpBKFF0XdtU6/WZh3gzv
         yNk4qW+LW1aZig6149NK/Wi1ythm87QSwPdUVKl7rbL8E/IfEMfVpCi694OZxBPA3H5/
         nxvIled42jgPjS9BpcQdo4dIO3USb0usmWPCyixH8fXuE+oNxezTNGiE6GSjVdWNL25j
         IWpUYtg6q3NqhkVu9XmBqNFS9zCG78xs7hFgExHhR08JvJyFdZBgHk7fCSt9WwVM4Rln
         JaU39Z1dhDcr/ebjzUFkedCjJTouZ/EJfTuiWRdWPmX7Ecq4zJfcHbEyptekGH732+KH
         DzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010498; x=1789615298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J6MrMveQfRSLeZLxuVHTxBa8WIaiqwHHuULzMI/J9Yg=;
        b=XZ7pygoslQfVqrilOMJm2ljEv8HW7tMsEPLillWgaj1XtbSJY+C1wW7oT16zGWfRzr
         FHK4IOi+qcdL3ShNCiakk4L7M1gIfdVspazYIalunTt8CupHhU0Z7rkxM3t04d0XAJZW
         mbkzZSY8mtVNdiIfiKbW56S1ubKE3lh/yVcQXDNC/G5cs+ConJdbzowpU3/xDjvr+vuC
         3ZiqI1OFIEqjgR5tDOrE9qv9XdLpyyNbCx47f2C0e4E4e7S/ork+2uJlx5zAs8FAa4kB
         5SUhghD+LFsO7pRNhAGrFwZ03FoqWZea3xKwHnTi9dGUakR2yhM+3Sl0y2x+YyTyn4uG
         jkDg==
X-Gm-Message-State: AFuF++lEmjzJvXYJhmyjATYqZ0b374kFdOYRZqb6uPz1KD+HyUgxyzcQ
	owmbSinBJkZF/sriihkAVdnmFI6+G4sNC4S202al91LglAUyiFHeaazO
X-Gm-Gg: AYBFou3Dca8fKhryKsSeukS+Ql14+86FtRq+L8Ttqsv2ASFlRHjSOTR2L4Wn6daTT/p
	KZvhqpC+YEBDcIzDn0V6fw0zneXfMb/NcN8GKVduAUBP8hzEbD8NaPakjI/xnmJEze+GsDpqfaL
	FTCaZqFVAgFcpfBVl0peep6JZypQGnzJcuiIGYL23gUCLYaJIxWC3sii/syYdY3690rKxZPYJUG
	v37ji41+U8ZmwI92i5A3rKqxF5NNa+rSi/ToYTZAIgBGnyX3Peuv+oMU6bA3O+yLkT0sOlZETe1
	UobI0kpAuPk0yTxUH8hiQICAEXTvUHC27K8ckoZCNmWYqhl9iqF3zJHHTZ5pB22GfUa6W2fY3Ja
	DyVHOoJ1ba9a2NRWHMw9RYWIJ6Wm68oLzVf0iIJy1iK7inrgb++9yHM2VqXEr7iWGi4rpHcaatg
	qUXmAQhWe2WPceV2Z8Ae9I8LkBUFxuFsLP0uF1bQ01b8WYs8y1oRsddQyw1sMbCQVAKJZ5c8HDp
	V2BkK6veTcdhdEYlZmsjItVZ5fVKoEFO3DE0R6jnacGKNWT5EX9axQ=
X-Received: by 2002:a05:6830:82aa:b0:7e9:e1ca:5316 with SMTP id 46e09a7af769-7fb76b4310dmr15524161a34.0.1789010498167;
        Wed, 09 Sep 2026 20:21:38 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:37 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 11/15] HID: hid-oxp: group declarations and protocol definitions
Date: Wed,  9 Sep 2026 22:21:11 -0500
Message-ID: <20260910032115.28669-12-andrei1998@gmail.com>
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

Collect protocol definitions and helper macros at the top of the file,
place the quirk structure with the other type declarations, and tidy
configuration field ordering and callback declaration formatting.

Keep this cleanup separate from the preceding behavioral fixes and the
new-controller feature patches.

Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 116 ++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index e26e6a9..8c44f57 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -33,6 +33,30 @@
 #define GEN1_USAGE_PAGE	0xff01
 #define GEN2_USAGE_PAGE	0xff00
 
+#define OXP_MAPPING_GAMEPAD	0x01
+#define OXP_MAPPING_KEYBOARD	0x02
+#define OXP_FILL_PAGE_SLOT(page, btn)            \
+	{ .button_idx = (page)->btn.button_idx,  \
+	  .mapping_idx = (page)->btn.mapping_idx }
+
+#define OXP_GET_PROPERTY 0xfc
+#define OXP_SET_PROPERTY 0xfd
+#define OXP_EFFECT_MONO_TRUE 0xfe /* actual index for monocolor */
+
+#define OXP_DEVICE_ATTR_RW(_name, _group)                                     \
+	static ssize_t _name##_store(struct device *dev,                      \
+				     struct device_attribute *attr,           \
+				     const char *buf, size_t count)           \
+	{                                                                     \
+		return _group##_store(dev, attr, buf, count, _name.index);    \
+	}                                                                     \
+	static ssize_t _name##_show(struct device *dev,                       \
+				    struct device_attribute *attr, char *buf) \
+	{                                                                     \
+		return _group##_show(dev, attr, buf, _name.index);            \
+	}                                                                     \
+	static DEVICE_ATTR_RW(_name)
+
 enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
@@ -42,9 +66,6 @@ enum oxp_function_index {
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
 
-#define OXP_MAPPING_GAMEPAD	0x01
-#define OXP_MAPPING_KEYBOARD	0x02
-
 struct oxp_button_data {
 	u8 mode;
 	u8 index;
@@ -176,37 +197,38 @@ struct oxp_bmap_page_2 {
 
 /* Hybrid devices expose RGB and controller configuration on separate HIDs. */
 struct oxp_hid_cfg {
-	struct led_classdev_mc cdev;
-	struct mc_subled subled_info[3];
-	struct delayed_work oxp_rgb_queue;
+	/* General HID state */
+	struct hid_device *hdev;
+	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	bool suspended;
+	bool removing;
+
+	/* Gamepad state */
 	struct delayed_work oxp_btn_queue;
+	struct delayed_work oxp_mcu_init;
 	struct oxp_bmap_page_1 *bmap_1;
 	struct oxp_bmap_page_2 *bmap_2;
-	struct delayed_work oxp_mcu_init;
+	bool gen2_work_initialized;
+	u8 rumble_intensity;
+	u8 gamepad_mode;
+
+	/* RGB state */
+	struct delayed_work oxp_rgb_queue;
+	struct mc_subled subled_info[3];
 	struct led_classdev_mc *led_mc;
-	struct hid_device *hdev;
-	struct mutex cfg_mutex; /*ensure single synchronous output report*/
-	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
+	struct led_classdev_mc cdev;
 	spinlock_t rgb_reply_lock;
+	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
+	bool rgb_work_initialized;
+	bool rgb_reply_pending;
 	u8 rgb_reply_command;
 	u8 rgb_reply_zone;
-	bool rgb_reply_pending;
 	u8 rgb_brightness;
-	u8 gamepad_mode;
-	u8 rumble_intensity;
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
-	bool rgb_work_initialized;
-	bool gen2_work_initialized;
-	bool suspended;
-	bool removing;
 };
 
-#define OXP_FILL_PAGE_SLOT(page, btn)            \
-	{ .button_idx = (page)->btn.button_idx,  \
-	  .mapping_idx = (page)->btn.mapping_idx }
-
 enum oxp_gamepad_mode_index {
 	OXP_GP_MODE_XINPUT = 0x00,
 	OXP_GP_MODE_DEBUG = 0x03,
@@ -251,14 +273,6 @@ enum oxp_rgb_effect_index {
 	OXP_EFFECT_MONO_LIST, /* placeholder for effect_index_show */
 };
 
-/* These belong to rgb_effect_index, but we want to hide them from
- * rgb_effect_text
- */
-
-#define OXP_GET_PROPERTY 0xfc
-#define OXP_SET_PROPERTY 0xfd
-#define OXP_EFFECT_MONO_TRUE 0xfe /* actual index for monocolor */
-
 static const char *const oxp_rgb_effect_text[] = {
 	[OXP_UNKNOWN] = "unknown",
 	[OXP_EFFECT_AURORA] = "aurora",
@@ -321,6 +335,10 @@ struct oxp_attr {
 	u8 index;
 };
 
+struct quirk_entry {
+	bool hybrid_mcu;
+};
+
 static u16 get_usage_page(struct hid_device *hdev)
 {
 	return hdev->collection[0].usage >> 16;
@@ -508,8 +526,9 @@ static int oxp_hid_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
-static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_size, u8 *data,
-			    size_t data_size, u8 *footer, size_t footer_size)
+static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header,
+			    size_t header_size, u8 *data, size_t data_size,
+			    u8 *footer, size_t footer_size)
 {
 	unsigned char *dmabuf __free(kfree) = kzalloc(OXP_PACKET_SIZE, GFP_KERNEL);
 	bool rgb_write;
@@ -560,7 +579,8 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
 	return ret;
 }
 
-static int oxp_gen_1_property_out(struct oxp_hid_cfg *cfg, enum oxp_function_index fid, u8 *data,
+static int oxp_gen_1_property_out(struct oxp_hid_cfg *cfg,
+				  enum oxp_function_index fid, u8 *data,
 				  u8 data_size)
 {
 	u8 header[] = { fid, GEN1_MESSAGE_ID };
@@ -569,7 +589,8 @@ static int oxp_gen_1_property_out(struct oxp_hid_cfg *cfg, enum oxp_function_ind
 	return mcu_property_out(cfg, header, header_size, data, data_size, NULL, 0);
 }
 
-static int oxp_gen_2_property_out(struct oxp_hid_cfg *cfg, enum oxp_function_index fid, u8 *data,
+static int oxp_gen_2_property_out(struct oxp_hid_cfg *cfg,
+				  enum oxp_function_index fid, u8 *data,
 				  u8 data_size)
 {
 	u8 header[] = { fid, GEN2_MESSAGE_ID, 0x01 };
@@ -1030,20 +1051,6 @@ static ssize_t rumble_intensity_range_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(rumble_intensity_range);
 
-#define OXP_DEVICE_ATTR_RW(_name, _group)                                     \
-	static ssize_t _name##_store(struct device *dev,                      \
-				     struct device_attribute *attr,           \
-				     const char *buf, size_t count)           \
-	{                                                                     \
-		return _group##_store(dev, attr, buf, count, _name.index);    \
-	}                                                                     \
-	static ssize_t _name##_show(struct device *dev,                       \
-				    struct device_attribute *attr, char *buf) \
-	{                                                                     \
-		return _group##_show(dev, attr, buf, _name.index);            \
-	}                                                                     \
-	static DEVICE_ATTR_RW(_name)
-
 static struct oxp_attr button_a = { BUTTON_A };
 OXP_DEVICE_ATTR_RW(button_a, map_button);
 
@@ -1130,7 +1137,8 @@ static const struct attribute_group oxp_cfg_attrs_group = {
 	.attrs = oxp_cfg_attrs,
 };
 
-static int oxp_rgb_status_store(struct oxp_hid_cfg *cfg, u8 enabled, u8 speed, u8 brightness)
+static int oxp_rgb_status_store(struct oxp_hid_cfg *cfg, u8 enabled,
+				u8 speed, u8 brightness)
 {
 	u16 up = get_usage_page(cfg->hdev);
 	u8 *data;
@@ -1538,10 +1546,6 @@ static const struct led_classdev_mc oxp_cdev_rgb = {
 	.num_colors = ARRAY_SIZE(oxp_rgb_subled_info),
 };
 
-struct quirk_entry {
-	bool hybrid_mcu;
-};
-
 static struct quirk_entry quirk_hybrid_mcu = {
 	.hybrid_mcu = true,
 };
@@ -1651,7 +1655,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	ret = devm_led_classdev_multicolor_register(&hdev->dev, cfg->led_mc);
 	if (ret) {
 		dev_err_probe(&hdev->dev, ret,
-				     "Failed to create RGB device\n");
+			      "Failed to create RGB device\n");
 		goto err_quiesce;
 	}
 
@@ -1676,14 +1680,14 @@ skip_rgb:
 	bmap_1 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_1), GFP_KERNEL);
 	if (!bmap_1) {
 		ret = dev_err_probe(&hdev->dev, -ENOMEM,
-				     "Unable to allocate button map page 1\n");
+				    "Unable to allocate button map page 1\n");
 		goto err_quiesce;
 	}
 
 	bmap_2 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_2), GFP_KERNEL);
 	if (!bmap_2) {
 		ret = dev_err_probe(&hdev->dev, -ENOMEM,
-				     "Unable to allocate button map page 2\n");
+				    "Unable to allocate button map page 2\n");
 		goto err_quiesce;
 	}
 
@@ -1702,7 +1706,7 @@ skip_rgb:
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret) {
 		dev_err_probe(&hdev->dev, ret,
-				     "Failed to attach configuration attributes\n");
+			      "Failed to attach configuration attributes\n");
 		goto err_quiesce;
 	}
 
