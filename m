Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9931717E
	for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029694; cv=none; b=EfAp0+KmUQpI6BEWUMs0crEspHg3Wi0MYwevbstkKNXdZ/z1Rsv6ZjUUlahKxo+A5+egc5hqxUi+5UPDdLqlgptq4PvgSoijPw9yYhhN+cXgJgxjCyN2gcusYna9VjYStvXUbeQwPwpt7RqLr8LLlPMDZfWFp3fACAFSRYU7D/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029694; c=relaxed/simple;
	bh=0L8+Cu0B3v2IJPpznJcUSAEo09HE1ytfsd+rqQiq+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPZOSIHV+ekqtsh0F73gDQk3WuTnubYnCKnCP9LVXqQPG63dnf9BGQWIM66zaoB+iiPbbLMfueQ6O17jPgx+Xf/3/r0izQVd2fiVaSE/bqaKqXp32zcdS9/pQm8Fqsymb+eaBlOPvHvwAq0Vs/jqEOJK+ZKVEAsG0zagPp2/A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJiVTLYb; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJiVTLYb"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c19d23b19so3728646c88.0
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776029690; x=1776634490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8funBZTKhVWLxfnDwjPxG9phASxver8OXdgR+E6H4w=;
        b=OJiVTLYbQTvsZePurv8iNcrSMYCx4iO55kQd+qGWeFaKOGX+8kGnJAyLTACK/kVHFw
         m8FtpHX0Oi0GQVxXMXaJ6Oyd18ehPGiBg0u9HU+k1DU4zBBpUEbTHsjhCxk1X8LFJ5BS
         dcz+b9yAsttlBCra8PZBrykzQBWQNNX52uRfDmV80YYZkTTK1m66ba++omwhDiLulX8C
         u93dxi7dhLih4BT+G8PVjtN7f6+LX16XIr7XZUxbI6olCKuqSgtgtcoMUlAk8qiWAmmC
         YmwdhjC72CQpGrmlSoMFirDVmailUWYEE8Jnihema8h2mUwky37hHiTCo6EOv6HhFte5
         OiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776029690; x=1776634490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8funBZTKhVWLxfnDwjPxG9phASxver8OXdgR+E6H4w=;
        b=eMadnTeasbI72Y7WHyZFl3xeQMMtPjcXy++OQT8z36Klp+hdolQG2Is1xlzx4Goz9f
         NaSKVoaKhPRlvUgYtM9T3njhtAEOr8bZWA4gXJ1RZk0XIq5wVAiql7jQ8hXB5CP4sbZI
         QND9U10MFJoknBDsVVWknQY2eYMsBEm/xjE5armbBb/O7/u4TK0c6BAAhTW3mPgf14gZ
         cZG5+QPvQffuHStTIDvwrUF0fHJdONnzk3tFgqE9fdr+bpg97RK32S2n/cUGGL8gqrdl
         dXOtkgusaFfzoJ3uBmfe8EEPbpN3rpfmK+gxGxmQKOA2/u2cN2j/gdUz+BJKosbAxC38
         f2nw==
X-Forwarded-Encrypted: i=1; AJvYcCUdl1h9bjDkaFxiU8nmkhWTVmiEN5RQg2nwCA4MbhCt5JFptXyq3Q3wF5xF6BNe2OxlR88Baufh+Kc+6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFl5ii2044E9zUFC/0BuK5v8kPP4Ho4fmpIBEVCtpP89TUeK6
	bwocSJOaBQ5LboRyMt4Fo3k6NbthstUrQBOzCRRj+6GI+nve2ZwJ9Vd0
X-Gm-Gg: AeBDiev7JlgY90b3jTMuXd2Ca/0gPPyKVbjgiF4RwhyTX5iqOs0lpmITKv56so+EOvG
	A8WBEuY7ltOlShD9ZnJVw9p0kFAS2AxUCZUJA6Le26jgLl6JpOyu7SsCO9D83tRrLZeTGizf6YF
	X8r3Gqb+tEbrZD3jMUbUZM8S/MdoEk2G4dmNCRpLOMW2I5GArrJpQ72XQoLOvNklbVEQYf/92RC
	EiO3LHQFv1V7R52d9WuxOJaF7iLX639v3cv3WNZ8MiKaLoRknL+LT+8+HePmsYVZLCTDF5LM81y
	ZM6bZs69P7OL+1Exk6YF7Gtke+xJCjzdMywxC6JEtKA5znVP+hhvmc8dmwUTHLKGj2lWFOI+TGU
	wE9kNh0Kn39UggNX7s/0+QSHosXkMlax4e61jWXaDi0WRzW+NvB9dSTbp/wOaTPtaDwwE0HEWis
	uG5l40S0PC9Ex4IyNjhPVyJ/xnc16nrSxYt7kAY1GjRcoQlsLBd6gNMM2KrYfayb0Lr8HuER3OG
	JWo
X-Received: by 2002:a05:7022:6b8d:b0:122:2f4:b285 with SMTP id a92af1059eb24-12c34edd852mr5965432c88.25.1776029690417;
        Sun, 12 Apr 2026 14:34:50 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm10631736c88.7.2026.04.12.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:34:50 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] HID: hid-oxp: Add Button Mapping Interface
Date: Sun, 12 Apr 2026 21:34:43 +0000
Message-ID: <20260412213444.2231505-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412213444.2231505-1-derekjohn.clark@gmail.com>
References: <20260412213444.2231505-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds button mapping interface for second generation OneXPlayer
configuration HID interfaces. This interface allows the MCU to swap
button mappings at the hardware level. The current state cannot be
retrieved, and the mappings may have been modified in Windows prior, so
we reset the button mapping at init and expose an attribute to allow
userspace to do this again at any time.

The interface requires two pages of button mapping data to be sent
before the settings will take place. Since the MCU requires a 200ms
delay after each message (total 400ms for these attributes) use the same
debounce work queue method we used for RGB. This will allow for
userspace or udev rules to rapidly map all buttons. The values will
be cached before the final write is finally sent to the device.

Reviewed-by: Zhouwang Huang <honjow311@gmail.com>
Tested-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v3:
  - Ensure default button map is properly init during probe.
v2:
  - Add detection of post-suspend MCU init to trigger setting the button
    map again.
---
 drivers/hid/hid-oxp.c | 569 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 567 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index c62952537d98..959ec1a90d22 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -34,10 +34,145 @@ enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
 	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
+	OXP_FID_GEN2_KEY_STATE =	0xb4,
 	OXP_FID_GEN2_STATUS_EVENT =	0xb8,
 };
 
+#define OXP_MAPPING_GAMEPAD	0x01
+#define OXP_MAPPING_KEYBOARD	0x02
+
+struct oxp_button_data {
+	u8 mode;
+	u8 index;
+	u8 key_id;
+	u8 padding[2];
+} __packed;
+
+struct oxp_button_entry {
+	struct oxp_button_data data;
+	const char *name;
+};
+
+static const struct oxp_button_entry oxp_button_table[] = {
+	/* Gamepad Buttons */
+	{ { OXP_MAPPING_GAMEPAD, 0x01 }, "BTN_A" },
+	{ { OXP_MAPPING_GAMEPAD, 0x02 }, "BTN_B" },
+	{ { OXP_MAPPING_GAMEPAD, 0x03 }, "BTN_X" },
+	{ { OXP_MAPPING_GAMEPAD, 0x04 }, "BTN_Y" },
+	{ { OXP_MAPPING_GAMEPAD, 0x05 }, "BTN_LB" },
+	{ { OXP_MAPPING_GAMEPAD, 0x06 }, "BTN_RB" },
+	{ { OXP_MAPPING_GAMEPAD, 0x07 }, "BTN_LT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x08 }, "BTN_RT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x09 }, "BTN_START" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0a }, "BTN_SELECT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0b }, "BTN_L3" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0c }, "BTN_R3" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0d }, "DPAD_UP" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0e }, "DPAD_DOWN" },
+	{ { OXP_MAPPING_GAMEPAD, 0x0f }, "DPAD_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x10 }, "DPAD_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x11 }, "JOY_L_UP" },
+	{ { OXP_MAPPING_GAMEPAD, 0x12 }, "JOY_L_UP_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x13 }, "JOY_L_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x14 }, "JOY_L_DOWN_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x15 }, "JOY_L_DOWN" },
+	{ { OXP_MAPPING_GAMEPAD, 0x16 }, "JOY_L_DOWN_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x17 }, "JOY_L_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x18 }, "JOY_L_UP_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x19 }, "JOY_R_UP" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1a }, "JOY_R_UP_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1b }, "JOY_R_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1c }, "JOY_R_DOWN_RIGHT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1d }, "JOY_R_DOWN" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1e }, "JOY_R_DOWN_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x1f }, "JOY_R_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x20 }, "JOY_R_UP_LEFT" },
+	{ { OXP_MAPPING_GAMEPAD, 0x22 }, "BTN_GUIDE" },
+	/* Keyboard Keys */
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5a }, "KEY_F1" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5b }, "KEY_F2" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5c }, "KEY_F3" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5d }, "KEY_F4" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5e }, "KEY_F5" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x5f }, "KEY_F6" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x60 }, "KEY_F7" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x61 }, "KEY_F8" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x62 }, "KEY_F9" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x63 }, "KEY_F10" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x64 }, "KEY_F11" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x65 }, "KEY_F12" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x66 }, "KEY_F13" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x67 }, "KEY_F14" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x68 }, "KEY_F15" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x69 }, "KEY_F16" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6a }, "KEY_F17" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6b }, "KEY_F18" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6c }, "KEY_F19" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6d }, "KEY_F20" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6e }, "KEY_F21" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x6f }, "KEY_F22" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x70 }, "KEY_F23" },
+	{ { OXP_MAPPING_KEYBOARD, 0x01, 0x71 }, "KEY_F24" },
+};
+
+enum oxp_joybutton_index {
+	BUTTON_A =	0x01,
+	BUTTON_B,
+	BUTTON_X,
+	BUTTON_Y,
+	BUTTON_LB,
+	BUTTON_RB,
+	BUTTON_LT,
+	BUTTON_RT,
+	BUTTON_START,
+	BUTTON_SELECT,
+	BUTTON_L3,
+	BUTTON_R3,
+	BUTTON_DUP,
+	BUTTON_DDOWN,
+	BUTTON_DLEFT,
+	BUTTON_DRIGHT,
+	BUTTON_M1 =	0x22,
+	BUTTON_M2,
+	/* These are unused currently, reserved for future devices */
+	BUTTON_M3,
+	BUTTON_M4,
+	BUTTON_M5,
+	BUTTON_M6,
+};
+
+struct oxp_button_idx {
+	enum oxp_joybutton_index button_idx;
+	u8 mapping_idx;
+} __packed;
+
+struct oxp_bmap_page_1 {
+	struct oxp_button_idx btn_a;
+	struct oxp_button_idx btn_b;
+	struct oxp_button_idx btn_x;
+	struct oxp_button_idx btn_y;
+	struct oxp_button_idx btn_lb;
+	struct oxp_button_idx btn_rb;
+	struct oxp_button_idx btn_lt;
+	struct oxp_button_idx btn_rt;
+	struct oxp_button_idx btn_start;
+} __packed;
+
+struct oxp_bmap_page_2 {
+	struct oxp_button_idx btn_select;
+	struct oxp_button_idx btn_l3;
+	struct oxp_button_idx btn_r3;
+	struct oxp_button_idx btn_dup;
+	struct oxp_button_idx btn_ddown;
+	struct oxp_button_idx btn_dleft;
+	struct oxp_button_idx btn_dright;
+	struct oxp_button_idx btn_m1;
+	struct oxp_button_idx btn_m2;
+} __packed;
+
 static struct oxp_hid_cfg {
+	struct oxp_bmap_page_1 *bmap_1;
+	struct oxp_bmap_page_2 *bmap_2;
 	struct led_classdev_mc *led_mc;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
@@ -48,6 +183,10 @@ static struct oxp_hid_cfg {
 	u8 rgb_en;
 } drvdata;
 
+#define OXP_FILL_PAGE_SLOT(page, btn)            \
+	{ .button_idx = (page)->btn.button_idx,  \
+	  .mapping_idx = (page)->btn.mapping_idx }
+
 enum oxp_gamepad_mode_index {
 	OXP_GP_MODE_XINPUT = 0x00,
 	OXP_GP_MODE_DEBUG = 0x03,
@@ -153,6 +292,10 @@ struct oxp_gen_2_rgb_report {
 	u8 effect;
 } __packed;
 
+struct oxp_attr {
+	u8 index;
+};
+
 static u16 get_usage_page(struct hid_device *hdev)
 {
 	return hdev->collection[0].usage >> 16;
@@ -194,12 +337,19 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 }
 
 static int oxp_gen_2_property_out(enum oxp_function_index fid, u8 *data, u8 data_size);
+static int oxp_set_buttons(void);
 
 static void oxp_mcu_init_fn(struct work_struct *work)
 {
 	u8 gp_mode_data[3] = { OXP_GP_MODE_DEBUG, 0x01, 0x02 };
 	int ret;
 
+	/* Re-apply the button mapping */
+	ret = oxp_set_buttons();
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to set button mapping: %i\n", ret);
+
 	/* Cycle the gamepad mode */
 	ret = oxp_gen_2_property_out(OXP_FID_GEN2_TOGGLE_MODE, gp_mode_data, 3);
 	if (ret)
@@ -395,9 +545,410 @@ static ssize_t gamepad_mode_index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(gamepad_mode_index);
 
+static void oxp_set_defaults_bmap_1(struct oxp_bmap_page_1 *bmap)
+{
+	bmap->btn_a.button_idx = BUTTON_A;
+	bmap->btn_a.mapping_idx = 0;
+	bmap->btn_b.button_idx = BUTTON_B;
+	bmap->btn_b.mapping_idx = 1;
+	bmap->btn_x.button_idx = BUTTON_X;
+	bmap->btn_x.mapping_idx = 2;
+	bmap->btn_y.button_idx = BUTTON_Y;
+	bmap->btn_y.mapping_idx = 3;
+	bmap->btn_lb.button_idx = BUTTON_LB;
+	bmap->btn_lb.mapping_idx = 4;
+	bmap->btn_rb.button_idx = BUTTON_RB;
+	bmap->btn_rb.mapping_idx = 5;
+	bmap->btn_lt.button_idx = BUTTON_LT;
+	bmap->btn_lt.mapping_idx = 6;
+	bmap->btn_rt.button_idx = BUTTON_RT;
+	bmap->btn_rt.mapping_idx = 7;
+	bmap->btn_start.button_idx = BUTTON_START;
+	bmap->btn_start.mapping_idx = 8;
+}
+
+static void oxp_set_defaults_bmap_2(struct oxp_bmap_page_2 *bmap)
+{
+	bmap->btn_select.button_idx = BUTTON_SELECT;
+	bmap->btn_select.mapping_idx = 9;
+	bmap->btn_l3.button_idx = BUTTON_L3;
+	bmap->btn_l3.mapping_idx = 10;
+	bmap->btn_r3.button_idx = BUTTON_R3;
+	bmap->btn_r3.mapping_idx = 11;
+	bmap->btn_dup.button_idx = BUTTON_DUP;
+	bmap->btn_dup.mapping_idx = 12;
+	bmap->btn_ddown.button_idx = BUTTON_DDOWN;
+	bmap->btn_ddown.mapping_idx = 13;
+	bmap->btn_dleft.button_idx = BUTTON_DLEFT;
+	bmap->btn_dleft.mapping_idx = 14;
+	bmap->btn_dright.button_idx = BUTTON_DRIGHT;
+	bmap->btn_dright.mapping_idx = 15;
+	bmap->btn_m1.button_idx = BUTTON_M1;
+	bmap->btn_m1.mapping_idx = 48; /* KEY_F15 */
+	bmap->btn_m2.button_idx = BUTTON_M2;
+	bmap->btn_m2.mapping_idx = 49; /* KEY_F16 */
+}
+
+static void oxp_page_fill_data(char *buf, const struct oxp_button_idx *buttons,
+			       size_t len)
+{
+	size_t offset_increment = sizeof(u8) + sizeof(struct oxp_button_idx);
+	size_t offset = 5;
+	unsigned int i;
+
+	for (i = 0; i < len; i++, offset += offset_increment) {
+		buf[offset] = (u8)buttons[i].button_idx;
+		memcpy(buf + offset + 1,
+		       &oxp_button_table[buttons[i].mapping_idx].data,
+		       sizeof(struct oxp_button_data));
+	}
+}
+
+static int oxp_set_buttons(void)
+{
+	u8 page_1[59] = { 0x02, 0x38, 0x20, 0x01, 0x01 };
+	u8 page_2[59] = { 0x02, 0x38, 0x20, 0x02, 0x01 };
+	u16 up = get_usage_page(drvdata.hdev);
+	int ret;
+
+	if (up != GEN2_USAGE_PAGE)
+		return -EINVAL;
+
+	const struct oxp_button_idx p1[] = {
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_a),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_b),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_x),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_y),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_lb),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_rb),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_lt),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_rt),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_1, btn_start),
+	};
+
+	const struct oxp_button_idx p2[] = {
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_select),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_l3),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_r3),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_dup),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_ddown),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_dleft),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_dright),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_m1),
+		OXP_FILL_PAGE_SLOT(drvdata.bmap_2, btn_m2),
+	};
+
+	oxp_page_fill_data(page_1, p1, ARRAY_SIZE(p1));
+	oxp_page_fill_data(page_2, p2, ARRAY_SIZE(p2));
+
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_KEY_STATE, page_1, ARRAY_SIZE(page_1));
+	if (ret)
+		return ret;
+
+	return oxp_gen_2_property_out(OXP_FID_GEN2_KEY_STATE, page_2, ARRAY_SIZE(page_2));
+}
+
+static void oxp_reset_buttons(void)
+{
+	oxp_set_defaults_bmap_1(drvdata.bmap_1);
+	oxp_set_defaults_bmap_2(drvdata.bmap_2);
+}
+
+static ssize_t reset_buttons_store(struct device *dev,
+				   struct device_attribute *attr, const char *buf,
+				   size_t count)
+{
+	int val, ret;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	oxp_reset_buttons();
+	ret = oxp_set_buttons();
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset_buttons);
+
+static void oxp_btn_queue_fn(struct work_struct *work)
+{
+	int ret;
+
+	ret = oxp_set_buttons();
+	if (ret)
+		dev_err(&drvdata.hdev->dev,
+			"Error: Failed to write button mapping: %i\n", ret);
+}
+
+static DECLARE_DELAYED_WORK(oxp_btn_queue, oxp_btn_queue_fn);
+
+static int oxp_button_idx_from_str(const char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_button_table); i++)
+		if (sysfs_streq(buf, oxp_button_table[i].name))
+			return i;
+
+	return -EINVAL;
+}
+
+static ssize_t map_button_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count, u8 index)
+{
+	int idx;
+
+	idx = oxp_button_idx_from_str(buf);
+	if (idx < 0)
+		return idx;
+
+	switch (index) {
+	case BUTTON_A:
+		drvdata.bmap_1->btn_a.mapping_idx = idx;
+		break;
+	case BUTTON_B:
+		drvdata.bmap_1->btn_b.mapping_idx = idx;
+		break;
+	case BUTTON_X:
+		drvdata.bmap_1->btn_x.mapping_idx = idx;
+		break;
+	case BUTTON_Y:
+		drvdata.bmap_1->btn_y.mapping_idx = idx;
+		break;
+	case BUTTON_LB:
+		drvdata.bmap_1->btn_lb.mapping_idx = idx;
+		break;
+	case BUTTON_RB:
+		drvdata.bmap_1->btn_rb.mapping_idx = idx;
+		break;
+	case BUTTON_LT:
+		drvdata.bmap_1->btn_lt.mapping_idx = idx;
+		break;
+	case BUTTON_RT:
+		drvdata.bmap_1->btn_rt.mapping_idx = idx;
+		break;
+	case BUTTON_START:
+		drvdata.bmap_1->btn_start.mapping_idx = idx;
+		break;
+	case BUTTON_SELECT:
+		drvdata.bmap_2->btn_select.mapping_idx = idx;
+		break;
+	case BUTTON_L3:
+		drvdata.bmap_2->btn_l3.mapping_idx = idx;
+		break;
+	case BUTTON_R3:
+		drvdata.bmap_2->btn_r3.mapping_idx = idx;
+		break;
+	case BUTTON_DUP:
+		drvdata.bmap_2->btn_dup.mapping_idx = idx;
+		break;
+	case BUTTON_DDOWN:
+		drvdata.bmap_2->btn_ddown.mapping_idx = idx;
+		break;
+	case BUTTON_DLEFT:
+		drvdata.bmap_2->btn_dleft.mapping_idx = idx;
+		break;
+	case BUTTON_DRIGHT:
+		drvdata.bmap_2->btn_dright.mapping_idx = idx;
+		break;
+	case BUTTON_M1:
+		drvdata.bmap_2->btn_m1.mapping_idx = idx;
+		break;
+	case BUTTON_M2:
+		drvdata.bmap_2->btn_m2.mapping_idx = idx;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mod_delayed_work(system_wq, &oxp_btn_queue, msecs_to_jiffies(50));
+	return count;
+}
+
+static ssize_t map_button_show(struct device *dev,
+			       struct device_attribute *attr, char *buf,
+			       u8 index)
+{
+	u8 i;
+
+	switch (index) {
+	case BUTTON_A:
+		i = drvdata.bmap_1->btn_a.mapping_idx;
+		break;
+	case BUTTON_B:
+		i = drvdata.bmap_1->btn_b.mapping_idx;
+		break;
+	case BUTTON_X:
+		i = drvdata.bmap_1->btn_x.mapping_idx;
+		break;
+	case BUTTON_Y:
+		i = drvdata.bmap_1->btn_y.mapping_idx;
+		break;
+	case BUTTON_LB:
+		i = drvdata.bmap_1->btn_lb.mapping_idx;
+		break;
+	case BUTTON_RB:
+		i = drvdata.bmap_1->btn_rb.mapping_idx;
+		break;
+	case BUTTON_LT:
+		i = drvdata.bmap_1->btn_lt.mapping_idx;
+		break;
+	case BUTTON_RT:
+		i = drvdata.bmap_1->btn_rt.mapping_idx;
+		break;
+	case BUTTON_START:
+		i = drvdata.bmap_1->btn_start.mapping_idx;
+		break;
+	case BUTTON_SELECT:
+		i = drvdata.bmap_2->btn_select.mapping_idx;
+		break;
+	case BUTTON_L3:
+		i = drvdata.bmap_2->btn_l3.mapping_idx;
+		break;
+	case BUTTON_R3:
+		i = drvdata.bmap_2->btn_r3.mapping_idx;
+		break;
+	case BUTTON_DUP:
+		i = drvdata.bmap_2->btn_dup.mapping_idx;
+		break;
+	case BUTTON_DDOWN:
+		i = drvdata.bmap_2->btn_ddown.mapping_idx;
+		break;
+	case BUTTON_DLEFT:
+		i = drvdata.bmap_2->btn_dleft.mapping_idx;
+		break;
+	case BUTTON_DRIGHT:
+		i = drvdata.bmap_2->btn_dright.mapping_idx;
+		break;
+	case BUTTON_M1:
+		i = drvdata.bmap_2->btn_m1.mapping_idx;
+		break;
+	case BUTTON_M2:
+		i = drvdata.bmap_2->btn_m2.mapping_idx;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (i >= ARRAY_SIZE(oxp_button_table))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", oxp_button_table[i].name);
+}
+
+static ssize_t button_mapping_options_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_button_table); i++)
+		count += sysfs_emit_at(buf, count, "%s ", oxp_button_table[i].name);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(button_mapping_options);
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
+static struct oxp_attr button_a = { BUTTON_A };
+OXP_DEVICE_ATTR_RW(button_a, map_button);
+
+static struct oxp_attr button_b = { BUTTON_B };
+OXP_DEVICE_ATTR_RW(button_b, map_button);
+
+static struct oxp_attr button_x = { BUTTON_X };
+OXP_DEVICE_ATTR_RW(button_x, map_button);
+
+static struct oxp_attr button_y = { BUTTON_Y };
+OXP_DEVICE_ATTR_RW(button_y, map_button);
+
+static struct oxp_attr button_lb = { BUTTON_LB };
+OXP_DEVICE_ATTR_RW(button_lb, map_button);
+
+static struct oxp_attr button_rb = { BUTTON_RB };
+OXP_DEVICE_ATTR_RW(button_rb, map_button);
+
+static struct oxp_attr button_lt = { BUTTON_LT };
+OXP_DEVICE_ATTR_RW(button_lt, map_button);
+
+static struct oxp_attr button_rt = { BUTTON_RT };
+OXP_DEVICE_ATTR_RW(button_rt, map_button);
+
+static struct oxp_attr button_start = { BUTTON_START };
+OXP_DEVICE_ATTR_RW(button_start, map_button);
+
+static struct oxp_attr button_select = { BUTTON_SELECT };
+OXP_DEVICE_ATTR_RW(button_select, map_button);
+
+static struct oxp_attr button_l3 = { BUTTON_L3 };
+OXP_DEVICE_ATTR_RW(button_l3, map_button);
+
+static struct oxp_attr button_r3 = { BUTTON_R3 };
+OXP_DEVICE_ATTR_RW(button_r3, map_button);
+
+static struct oxp_attr button_d_up = { BUTTON_DUP };
+OXP_DEVICE_ATTR_RW(button_d_up, map_button);
+
+static struct oxp_attr button_d_down = { BUTTON_DDOWN };
+OXP_DEVICE_ATTR_RW(button_d_down, map_button);
+
+static struct oxp_attr button_d_left = { BUTTON_DLEFT };
+OXP_DEVICE_ATTR_RW(button_d_left, map_button);
+
+static struct oxp_attr button_d_right = { BUTTON_DRIGHT };
+OXP_DEVICE_ATTR_RW(button_d_right, map_button);
+
+static struct oxp_attr button_m1 = { BUTTON_M1 };
+OXP_DEVICE_ATTR_RW(button_m1, map_button);
+
+static struct oxp_attr button_m2 = { BUTTON_M2 };
+OXP_DEVICE_ATTR_RW(button_m2, map_button);
+
 static struct attribute *oxp_cfg_attrs[] = {
+	&dev_attr_button_a.attr,
+	&dev_attr_button_b.attr,
+	&dev_attr_button_d_down.attr,
+	&dev_attr_button_d_left.attr,
+	&dev_attr_button_d_right.attr,
+	&dev_attr_button_d_up.attr,
+	&dev_attr_button_l3.attr,
+	&dev_attr_button_lb.attr,
+	&dev_attr_button_lt.attr,
+	&dev_attr_button_m1.attr,
+	&dev_attr_button_m2.attr,
+	&dev_attr_button_mapping_options.attr,
+	&dev_attr_button_r3.attr,
+	&dev_attr_button_rb.attr,
+	&dev_attr_button_rt.attr,
+	&dev_attr_button_select.attr,
+	&dev_attr_button_start.attr,
+	&dev_attr_button_x.attr,
+	&dev_attr_button_y.attr,
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
+	&dev_attr_reset_buttons.attr,
 	NULL,
 };
 
@@ -823,6 +1374,8 @@ static bool oxp_hybrid_mcu_device(void)
 
 static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 {
+	struct oxp_bmap_page_1 *bmap_1;
+	struct oxp_bmap_page_2 *bmap_2;
 	int ret;
 
 	hid_set_drvdata(hdev, &drvdata);
@@ -855,9 +1408,21 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 		return 0;
 
 skip_rgb:
-	mod_delayed_work(system_wq, &oxp_mcu_init, msecs_to_jiffies(50));
-
+	bmap_1 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_1), GFP_KERNEL);
+	if (!bmap_1)
+		return dev_err_probe(&hdev->dev, -ENOMEM,
+				     "Unable to allocate button map page 1\n");
+
+	bmap_2 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_2), GFP_KERNEL);
+	if (!bmap_2)
+		return dev_err_probe(&hdev->dev, -ENOMEM,
+				     "Unable to allocate button map page 2\n");
+
+	drvdata.bmap_1 = bmap_1;
+	drvdata.bmap_2 = bmap_2;
+	oxp_reset_buttons();
 	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
+	mod_delayed_work(system_wq, &oxp_mcu_init, msecs_to_jiffies(50));
 
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret)
-- 
2.53.0

