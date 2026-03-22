Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89F37C92D
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149384; cv=none; b=NlLdN/XvcaPlZskBj4SMLxTX7wfgQTFIMNhuvVUAD13oYvV/+DIrCDIyd7E0XQc+ZunSWPucecxN65d4wx6iMLeZsbfmeNprv/WHaQmQf7okTJIpZlY9vqGl5ghkZWilsM0ih81uNuf9hf4psj42Gzq8Kse877cEBA4Cvilcbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149384; c=relaxed/simple;
	bh=W1rLdAGagHNMf2g+c+r233cuQ/o3gDmRftmWdFY8IDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrpjelZvkC7vX1qgugW1bMp4EYnDrbHUb1Oc5jsZrxyJFMOtyDdrqp23icSO5ZLhgujZyowVL3ZsJwUssq4ddjh63nf0/oSqUVvJMXvSnAj9ntXjNUlu9ymdLAGET5bKlhzHy2BBv3AKnV7pk+Vd4tbAPVRLSTgvmkrnXV77UTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBI/y+tG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBI/y+tG"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c107ef474fso2937626eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774149381; x=1774754181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os0SrvdIH4z45ssqOZ2Hn0vhnIJqpjEjlIqduxgwWG0=;
        b=aBI/y+tGBTXbdut4ZpltePlZUlIvaJQQoT+HACy+1aatd/rLZtuV5xIY3C9TvheWxv
         pknF09qp79YFg4XZ2VKijbz3a82qEauXP10DBplZnXTXt6Q9Qr7/KMy2KL2pKGh9Fx3d
         3H2hK8MXhWziCldVflUFaa59k4pZNSdm85x+HUow1I6lOPeg3uOFrAgn4ElhNnN2mYLu
         Tb7zjZNHzZ17qRxA80i72x1HrWaMEdKqK1cB6k05hjyX4eE5KSXsD3WSwSNl4ZTuy3XS
         05uZCrlgl5YefGzeiGjuHSfd9fABtqS/u2MOLFxg+Dk2d+QykUrCJz9jkvUuGMRxrDoP
         TozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774149381; x=1774754181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os0SrvdIH4z45ssqOZ2Hn0vhnIJqpjEjlIqduxgwWG0=;
        b=PWnyoqCWFywTqb4e8rCFzz1eoeFv+k+NQNB4zLrjQSF3bpsWsUqSFp34DqV7JFkvv5
         yzUg8VQP0/39Eg9shMX1KCtCld6t9oGtjQ84mSEWllsOKYyVXHKwP2dWZHAAHT7Xtm4U
         /O4IftQ58HXMSguSF84pae+iEfB0gMSgIYAc3R0Uj4yrfq+EBeIHwL7u97FhbHm6+EAv
         2pELBoO4LkOJTgKtCwXxkVPG0kA0TSR5c/8Oq0vgmP2JmWxOPGUX8zLKrnZ+zLk1J1QF
         g170Btc9XyjANSdLBpSIGeA/SBza2bGtJIvLn3CuOfpszjj8ENK+HdMKLJXK9veYnDjX
         NENg==
X-Forwarded-Encrypted: i=1; AJvYcCXCfSDPpFYFwVvsbK8r73yRI25R/x5hx625aRcybt5YLwGVADS85HqQyJsjFQ8mRNSbgWTUcFOWgET+WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4wIbJ2dObUW2eZHdeTSGLltjfdBJIVu5uvKZ4k1Ipx9rZ9FZ
	bhAGUSSJoSuTakUT0QSNkxtgPFcLJomQcDNfYBPW4rcRtnhZOaFh/45I
X-Gm-Gg: ATEYQzz7UdYJQV5ajCMx9Iw9ckcstYR7bWks3JJXwyRioq1kCMPJqa45gUygnM/lMNZ
	UGoc8073TZY77aLJ31RFt57Ap254ORVpOTUUvCVzEjyXLDI8mbfZj/Fcw7wTJrYmB4V1Qt3/Rlw
	RE6T4PanaMc9n3mrf3Hi2vp9RIwv/NASmhRMNiqQvHLhwkHazb0LNgIUhzNIxJXZfOiXVOrMIk4
	Dg1EUs12Kc4578gnZnTac7ivghSjhMdPpzCpIPVPb7tWuIHgCpL9SjM7j0X5dtUozx8TjBnHLHb
	fWNMqwqHh9HPNHrhA0c8w4giEiD0GcqlnGTEaFCpL0D8I7KJ0PFzxST9YX7tSGSFweOdaBl3Yjz
	3DSZxhLr73R/KC96r+iSQS1ULtVeafd0ODeDTCUBQ2qwRUPd9elv1g31+ri2kqFcjhERYIe5+Wc
	m/dBEdyxXHIZoQKPEOL56a0ajD6JBDZoDaZjRXcOlrJsVg5IMiQQ6/sb2Ltmy2GZAb47VPU/o8X
	DS+rOCdHijALVk=
X-Received: by 2002:a05:7301:4198:b0:2c0:e31b:1814 with SMTP id 5a478bee46e88-2c10961ef26mr3439331eec.10.1774149380856;
        Sat, 21 Mar 2026 20:16:20 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm11220460eec.26.2026.03.21.20.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 20:16:20 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] HID: hid-oxp: Add Button Mapping Interface
Date: Sun, 22 Mar 2026 03:16:15 +0000
Message-ID: <20260322031615.1524307-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
References: <20260322031615.1524307-1-derekjohn.clark@gmail.com>
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

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-oxp.c | 510 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 510 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 5fed2799a2ad..915c17b97db0 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -33,10 +33,126 @@ enum oxp_function_index {
 	OXP_FID_GEN1_RGB_SET =		0x07,
 	OXP_FID_GEN1_RGB_REPLY =	0x0f,
 	OXP_FID_GEN2_TOGGLE_MODE =	0xb2,
+	OXP_FID_GEN2_KEY_STATE =	0xb4,
 	OXP_FID_GEN2_RGB_EVENT =	0xb8,
 };
 
+enum oxp_joybutton_index {
+	BUTTON_A = 0x01,
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
+	JOY_L_UP,
+	JOY_L_UP_RIGHT,
+	JOY_L_RIGHT,
+	JOY_L_DOWN_RIGHT,
+	JOY_L_DOWN,
+	JOY_L_DOWN_LEFT,
+	JOY_L_LEFT,
+	JOY_L_UP_LEFT,
+	JOY_R_UP,
+	JOY_R_UP_RIGHT,
+	JOY_R_RIGHT,
+	JOY_R_DOWN_RIGHT,
+	JOY_R_DOWN,
+	JOY_R_DOWN_LEFT,
+	JOY_R_LEFT,
+	JOY_R_UP_LEFT,
+	BUTTON_GUIDE = 0x22,
+};
+
+static const char *const oxp_joybutton_text[] = {
+	[BUTTON_A] = "a",
+	[BUTTON_B] = "b",
+	[BUTTON_X] = "x",
+	[BUTTON_Y] = "y",
+	[BUTTON_LB] = "lb",
+	[BUTTON_RB] = "rb",
+	[BUTTON_LT] = "lt",
+	[BUTTON_RT] = "rt",
+	[BUTTON_START] = "start",
+	[BUTTON_SELECT] = "select",
+	[BUTTON_L3] = "l3",
+	[BUTTON_R3] = "r3",
+	[BUTTON_DUP] = "d_up",
+	[BUTTON_DDOWN] = "d_down",
+	[BUTTON_DLEFT] = "d_left",
+	[BUTTON_DRIGHT] = "d_right",
+	[JOY_L_UP] = "joy_l_up",
+	[JOY_L_UP_RIGHT] = "joy_l_up_right",
+	[JOY_L_RIGHT] = "joy_l_right",
+	[JOY_L_DOWN_RIGHT] = "joy_l_down_right",
+	[JOY_L_DOWN] = "joy_l_down",
+	[JOY_L_DOWN_LEFT] = "joy_l_down_left",
+	[JOY_L_LEFT] = "joy_l_left",
+	[JOY_L_UP_LEFT] = "joy_l_up_left",
+	[JOY_R_UP] = "joy_r_up",
+	[JOY_R_UP_RIGHT] = "joy_r_up_right",
+	[JOY_R_RIGHT] = "joy_r_right",
+	[JOY_R_DOWN_RIGHT] = "joy_r_down_right",
+	[JOY_R_DOWN] = "joy_r_down",
+	[JOY_R_DOWN_LEFT] = "joy_r_down_left",
+	[JOY_R_LEFT] = "joy_r_left",
+	[JOY_R_UP_LEFT] = "joy_r_up_left",
+	[BUTTON_GUIDE] = "guide",
+};
+
+enum oxp_custom_button_index {
+	BUTTON_M1 = 0x22,
+	BUTTON_M2,
+	/* These are unused currently, reserved for future devices */
+	BUTTON_M3,
+	BUTTON_M4,
+	BUTTON_M5,
+	BUTTON_M6,
+};
+
+struct oxp_button {
+	u8 index;
+	u8 mode;
+	u8 mapping;
+	u8 padding[3];
+} __packed;
+
+struct oxp_bmap_page_1 {
+	struct oxp_button btn_a;
+	struct oxp_button btn_b;
+	struct oxp_button btn_x;
+	struct oxp_button btn_y;
+	struct oxp_button btn_lb;
+	struct oxp_button btn_rb;
+	struct oxp_button btn_lt;
+	struct oxp_button btn_rt;
+	struct oxp_button btn_start;
+} __packed;
+
+struct oxp_bmap_page_2 {
+	struct oxp_button btn_select;
+	struct oxp_button btn_l3;
+	struct oxp_button btn_r3;
+	struct oxp_button btn_dup;
+	struct oxp_button btn_ddown;
+	struct oxp_button btn_dleft;
+	struct oxp_button btn_dright;
+	struct oxp_button btn_m1;
+	struct oxp_button btn_m2;
+} __packed;
+
 static struct oxp_hid_cfg {
+	struct oxp_bmap_page_1 *bmap_1;
+	struct oxp_bmap_page_2 *bmap_2;
 	struct led_classdev_mc *led_mc;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
@@ -144,6 +260,10 @@ struct oxp_gen_2_rgb_report {
 	u8 effect;
 } __packed;
 
+struct oxp_button_attr {
+	u8 index;
+};
+
 static u16 get_usage_page(struct hid_device *hdev)
 {
 	return hdev->collection[0].usage >> 16;
@@ -351,9 +471,380 @@ static ssize_t button_takeover_index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_takeover_index);
 
+static void oxp_set_defaults_bmap_1(struct oxp_bmap_page_1 *bmap)
+{
+	bmap->btn_a.index = BUTTON_A;
+	bmap->btn_a.mode = 0x01;
+	bmap->btn_a.mapping = BUTTON_A;
+	bmap->btn_b.index = BUTTON_B;
+	bmap->btn_b.mode = 0x01;
+	bmap->btn_b.mapping = BUTTON_B;
+	bmap->btn_x.index = BUTTON_X;
+	bmap->btn_x.mode = 0x01;
+	bmap->btn_x.mapping = BUTTON_X;
+	bmap->btn_y.index = BUTTON_Y;
+	bmap->btn_y.mode = 0x01;
+	bmap->btn_y.mapping = BUTTON_Y;
+	bmap->btn_lb.index = BUTTON_LB;
+	bmap->btn_lb.mode = 0x01;
+	bmap->btn_lb.mapping = BUTTON_LB;
+	bmap->btn_rb.index = BUTTON_RB;
+	bmap->btn_rb.mode = 0x01;
+	bmap->btn_rb.mapping = BUTTON_RB;
+	bmap->btn_lt.index = BUTTON_LT;
+	bmap->btn_lt.mode = 0x01;
+	bmap->btn_lt.mapping = BUTTON_LT;
+	bmap->btn_rt.index = BUTTON_RT;
+	bmap->btn_rt.mode = 0x01;
+	bmap->btn_rt.mapping = BUTTON_RT;
+	bmap->btn_start.index = BUTTON_START;
+	bmap->btn_start.mode = 0x01;
+	bmap->btn_start.mapping = BUTTON_START;
+}
+
+static void oxp_set_defaults_bmap_2(struct oxp_bmap_page_2 *bmap)
+{
+	bmap->btn_select.index = BUTTON_SELECT;
+	bmap->btn_select.mode = 0x01;
+	bmap->btn_select.mapping = BUTTON_SELECT;
+	bmap->btn_l3.index = BUTTON_L3;
+	bmap->btn_l3.mode = 0x01;
+	bmap->btn_l3.mapping = BUTTON_L3;
+	bmap->btn_r3.index = BUTTON_R3;
+	bmap->btn_r3.mode = 0x01;
+	bmap->btn_r3.mapping = BUTTON_R3;
+	bmap->btn_dup.index = BUTTON_DUP;
+	bmap->btn_dup.mode = 0x01;
+	bmap->btn_dup.mapping = BUTTON_DUP;
+	bmap->btn_ddown.index = BUTTON_DDOWN;
+	bmap->btn_ddown.mode = 0x01;
+	bmap->btn_ddown.mapping = BUTTON_DDOWN;
+	bmap->btn_dleft.index = BUTTON_DLEFT;
+	bmap->btn_dleft.mode = 0x01;
+	bmap->btn_dleft.mapping = BUTTON_DLEFT;
+	bmap->btn_dright.index = BUTTON_DRIGHT;
+	bmap->btn_dright.mode = 0x01;
+	bmap->btn_dright.mapping = BUTTON_DRIGHT;
+	bmap->btn_m1.index = BUTTON_M1;
+	bmap->btn_m1.mode = 0x01;
+	bmap->btn_m1.mapping = BUTTON_LT;
+	bmap->btn_m2.index = BUTTON_M2;
+	bmap->btn_m2.mode = 0x01;
+	bmap->btn_m2.mapping = BUTTON_RT;
+}
+
+static int oxp_set_buttons(void)
+{
+	u8 data[59] = { 0x02, 0x00, 0x00, 0x00, 0x01 };
+	u16 up = get_usage_page(drvdata.hdev);
+	int ret;
+
+	if (up != GEN2_USAGE_PAGE)
+		return -EINVAL;
+
+	memcpy(data + 5, drvdata.bmap_1, sizeof(struct oxp_bmap_page_1));
+	ret = oxp_gen_2_property_out(OXP_FID_GEN2_KEY_STATE, data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	memcpy(data + 5, drvdata.bmap_2, sizeof(struct oxp_bmap_page_2));
+	return oxp_gen_2_property_out(OXP_FID_GEN2_KEY_STATE, data, ARRAY_SIZE(data));
+}
+
+static int oxp_reset_buttons(void)
+{
+	oxp_set_defaults_bmap_1(drvdata.bmap_1);
+	oxp_set_defaults_bmap_2(drvdata.bmap_2);
+	return oxp_set_buttons();
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
+	ret = oxp_reset_buttons();
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
+static ssize_t map_button_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count, u8 index)
+{
+	int ret;
+	u8 val;
+
+	ret = sysfs_match_string(oxp_joybutton_text, buf);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	switch (index) {
+	case BUTTON_A:
+		drvdata.bmap_1->btn_a.mapping = val;
+		break;
+	case BUTTON_B:
+		drvdata.bmap_1->btn_b.mapping = val;
+		break;
+	case BUTTON_X:
+		drvdata.bmap_1->btn_x.mapping = val;
+		break;
+	case BUTTON_Y:
+		drvdata.bmap_1->btn_y.mapping = val;
+		break;
+	case BUTTON_LB:
+		drvdata.bmap_1->btn_lb.mapping = val;
+		break;
+	case BUTTON_RB:
+		drvdata.bmap_1->btn_rb.mapping = val;
+		break;
+	case BUTTON_LT:
+		drvdata.bmap_1->btn_lt.mapping = val;
+		break;
+	case BUTTON_RT:
+		drvdata.bmap_1->btn_rt.mapping = val;
+		break;
+	case BUTTON_START:
+		drvdata.bmap_1->btn_start.mapping = val;
+		break;
+	case BUTTON_SELECT:
+		drvdata.bmap_2->btn_select.mapping = val;
+		break;
+	case BUTTON_L3:
+		drvdata.bmap_2->btn_l3.mapping = val;
+		break;
+	case BUTTON_R3:
+		drvdata.bmap_2->btn_r3.mapping = val;
+		break;
+	case BUTTON_DUP:
+		drvdata.bmap_2->btn_dup.mapping = val;
+		break;
+	case BUTTON_DDOWN:
+		drvdata.bmap_2->btn_ddown.mapping = val;
+		break;
+	case BUTTON_DLEFT:
+		drvdata.bmap_2->btn_dleft.mapping = val;
+		break;
+	case BUTTON_DRIGHT:
+		drvdata.bmap_2->btn_dright.mapping = val;
+		break;
+	case BUTTON_M1:
+		drvdata.bmap_2->btn_m1.mapping = val;
+		break;
+	case BUTTON_M2:
+		drvdata.bmap_2->btn_m2.mapping = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
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
+		i = drvdata.bmap_1->btn_a.mapping;
+		break;
+	case BUTTON_B:
+		i = drvdata.bmap_1->btn_b.mapping;
+		break;
+	case BUTTON_X:
+		i = drvdata.bmap_1->btn_x.mapping;
+		break;
+	case BUTTON_Y:
+		i = drvdata.bmap_1->btn_y.mapping;
+		break;
+	case BUTTON_LB:
+		i = drvdata.bmap_1->btn_lb.mapping;
+		break;
+	case BUTTON_RB:
+		i = drvdata.bmap_1->btn_rb.mapping;
+		break;
+	case BUTTON_LT:
+		i = drvdata.bmap_1->btn_lt.mapping;
+		break;
+	case BUTTON_RT:
+		i = drvdata.bmap_1->btn_rt.mapping;
+		break;
+	case BUTTON_START:
+		i = drvdata.bmap_1->btn_start.mapping;
+		break;
+	case BUTTON_SELECT:
+		i = drvdata.bmap_2->btn_select.mapping;
+		break;
+	case BUTTON_L3:
+		i = drvdata.bmap_2->btn_l3.mapping;
+		break;
+	case BUTTON_R3:
+		i = drvdata.bmap_2->btn_r3.mapping;
+		break;
+	case BUTTON_DUP:
+		i = drvdata.bmap_2->btn_dup.mapping;
+		break;
+	case BUTTON_DDOWN:
+		i = drvdata.bmap_2->btn_ddown.mapping;
+		break;
+	case BUTTON_DLEFT:
+		i = drvdata.bmap_2->btn_dleft.mapping;
+		break;
+	case BUTTON_DRIGHT:
+		i = drvdata.bmap_2->btn_dright.mapping;
+		break;
+	case BUTTON_M1:
+		i = drvdata.bmap_2->btn_m1.mapping;
+		break;
+	case BUTTON_M2:
+		i = drvdata.bmap_2->btn_m2.mapping;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (i >= ARRAY_SIZE(oxp_joybutton_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", oxp_joybutton_text[i]);
+}
+
+static ssize_t button_mapping_options_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(oxp_joybutton_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", oxp_joybutton_text[i]);
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
+static struct oxp_button_attr button_a = { BUTTON_A };
+OXP_DEVICE_ATTR_RW(button_a, map_button);
+
+static struct oxp_button_attr button_b = { BUTTON_B };
+OXP_DEVICE_ATTR_RW(button_b, map_button);
+
+static struct oxp_button_attr button_x = { BUTTON_X };
+OXP_DEVICE_ATTR_RW(button_x, map_button);
+
+static struct oxp_button_attr button_y = { BUTTON_Y };
+OXP_DEVICE_ATTR_RW(button_y, map_button);
+
+static struct oxp_button_attr button_lb = { BUTTON_LB };
+OXP_DEVICE_ATTR_RW(button_lb, map_button);
+
+static struct oxp_button_attr button_rb = { BUTTON_RB };
+OXP_DEVICE_ATTR_RW(button_rb, map_button);
+
+static struct oxp_button_attr button_lt = { BUTTON_LT };
+OXP_DEVICE_ATTR_RW(button_lt, map_button);
+
+static struct oxp_button_attr button_rt = { BUTTON_RT };
+OXP_DEVICE_ATTR_RW(button_rt, map_button);
+
+static struct oxp_button_attr button_start = { BUTTON_START };
+OXP_DEVICE_ATTR_RW(button_start, map_button);
+
+static struct oxp_button_attr button_select = { BUTTON_SELECT };
+OXP_DEVICE_ATTR_RW(button_select, map_button);
+
+static struct oxp_button_attr button_l3 = { BUTTON_L3 };
+OXP_DEVICE_ATTR_RW(button_l3, map_button);
+
+static struct oxp_button_attr button_r3 = { BUTTON_R3 };
+OXP_DEVICE_ATTR_RW(button_r3, map_button);
+
+static struct oxp_button_attr button_d_up = { BUTTON_DUP };
+OXP_DEVICE_ATTR_RW(button_d_up, map_button);
+
+static struct oxp_button_attr button_d_down = { BUTTON_DDOWN };
+OXP_DEVICE_ATTR_RW(button_d_down, map_button);
+
+static struct oxp_button_attr button_d_left = { BUTTON_DLEFT };
+OXP_DEVICE_ATTR_RW(button_d_left, map_button);
+
+static struct oxp_button_attr button_d_right = { BUTTON_DRIGHT };
+OXP_DEVICE_ATTR_RW(button_d_right, map_button);
+
+static struct oxp_button_attr button_m1 = { BUTTON_M1 };
+OXP_DEVICE_ATTR_RW(button_m1, map_button);
+
+static struct oxp_button_attr button_m2 = { BUTTON_M2 };
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
 	&dev_attr_button_takeover.attr,
 	&dev_attr_button_takeover_index.attr,
+	&dev_attr_button_x.attr,
+	&dev_attr_button_y.attr,
+	&dev_attr_reset_buttons.attr,
 	NULL,
 };
 
@@ -729,6 +1220,8 @@ static struct led_classdev_mc oxp_cdev_rgb = {
 
 static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 {
+	struct oxp_bmap_page_1 *bmap_1;
+	struct oxp_bmap_page_2 *bmap_2;
 	int ret;
 
 	hid_set_drvdata(hdev, &drvdata);
@@ -756,6 +1249,23 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	if (up != GEN2_USAGE_PAGE)
 		return 0;
 
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
+	ret = oxp_reset_buttons();
+	if (ret)
+		return dev_err_probe(&hdev->dev, ret,
+				     "Failed to reset button mapping\n");
+
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret)
 		return dev_err_probe(&hdev->dev, ret,
-- 
2.53.0

