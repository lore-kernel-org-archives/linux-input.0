Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C73A5E9E
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616091; cv=none; b=REj9qMnnl2bNHhWrxpHa0X1e2kYKJbWrXZ3EFZX38bi8ovIJzbZofgRxRlqtmJlSFWlKrW16ztVX2taqNw/ZGf5th6FhvW1lbdZPpA82TgVpYfybnRYiZQrCdZkBEGYCo0I/OQ1VTbAMbbRJtf+NlCzVYpawd+by3HjfLFeSVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616091; c=relaxed/simple;
	bh=sK5IjQdToVT0TAaqEGREyYsZwanInWPwbXitoyQomOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF84qEmTcAVF3h0ZMVzy9+N2Daw6yUAyDxke4OVetfenmpA7TAUga8FUm/IrVyjIj/fUgwYsJv8nNSIV+0zXGHDIo1hxUV4HRDYEteOEFBH8VMnnRDkkxk4gL1g5MnJzstMmSbuHyaVq/lVX7fwi0GediY7YLhPDPmuv+MiTOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=TvgDlnZ8; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="TvgDlnZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1778616089; bh=sK5IjQdToVT0TAaqEGREyYsZwanInWPwbXitoyQomOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvgDlnZ81vQ6r7jPqZAwFpZeL6eG1yQfO6sLMvYu8bX7odF7PKXXKQucZc2nWRkvk
	 ZyF+dEovowbyKOrD3Z9/wPwYBxBMWpc556sy9ebN4CxZEqTbTnv5MfVAwKJAa418f2
	 O2/NB968qfszsu1iFabIRSERPAYwTyaphaMkZEa+2LCPWhdwmNwPFQLzgWj+Mk1C4n
	 mlx5OtefaNaKamVTf5byOhReeHlyGoCwMI1l2YzqOwEPffaxbtY5mv50hblKjOTj+C
	 7auKk79BKLSuTXbvYLp1W/G8XoJoOdhm8UTAcLlSmkw+SyTGivNgwZRj1GbriXexvR
	 3tczbJvyll9Tw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id E2A9E13202C;
	Tue, 12 May 2026 13:01:28 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v5 3/3] HID: nintendo: Add unified report format support
Date: Tue, 12 May 2026 13:00:49 -0700
Message-ID: <20260512200051.2534081-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512200051.2534081-1-vi@endrift.com>
References: <20260512200051.2534081-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the "unified" report format that all controllers also
support, which has overlapping fields for like buttons and axes between
them.

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>
Tested-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo.c | 148 +++++++++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 9801799a9075..9e7eda7b70bf 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2824,6 +2824,36 @@ static int joycon_suspend(struct hid_device *hdev, pm_message_t message)
 #define NS2_BTN3_SR	BIT(6)
 #define NS2_BTN3_SL	BIT(7)
 
+#define NS2_BTN_U1_Y	BIT(0)
+#define NS2_BTN_U1_X	BIT(1)
+#define NS2_BTN_U1_B	BIT(2)
+#define NS2_BTN_U1_A	BIT(3)
+#define NS2_BTN_U1_SR	BIT(4)
+#define NS2_BTN_U1_SL	BIT(5)
+#define NS2_BTN_U1_R	BIT(6)
+#define NS2_BTN_U1_ZR	BIT(7)
+
+#define NS2_BTN_U2_MINUS	BIT(0)
+#define NS2_BTN_U2_PLUS		BIT(1)
+#define NS2_BTN_U2_RS		BIT(2)
+#define NS2_BTN_U2_LS		BIT(3)
+#define NS2_BTN_U2_HOME		BIT(4)
+#define NS2_BTN_U2_CAPTURE	BIT(5)
+#define NS2_BTN_U2_C		BIT(6)
+
+#define NS2_BTN_U3_DOWN		BIT(0)
+#define NS2_BTN_U3_UP		BIT(1)
+#define NS2_BTN_U3_RIGHT	BIT(2)
+#define NS2_BTN_U3_LEFT		BIT(3)
+#define NS2_BTN_U3_SR		BIT(4)
+#define NS2_BTN_U3_SL		BIT(5)
+#define NS2_BTN_U3_L		BIT(6)
+#define NS2_BTN_U3_ZL		BIT(7)
+
+#define NS2_BTN_U4_GR		BIT(0)
+#define NS2_BTN_U4_GL		BIT(1)
+#define NS2_BTN_U4_HEADSET	BIT(5)
+
 #define NS2_BTN_JCR_HOME	BIT(0)
 #define NS2_BTN_JCR_GR		BIT(2)
 #define NS2_BTN_JCR_C		NS2_BTN3_C
@@ -3069,6 +3099,22 @@ static const struct switch2_ctlr_button_mapping ns2_left_joycon_button_mappings[
 	{ /* sentinel */ },
 };
 
+static const struct switch2_ctlr_button_mapping ns2_left_joycon_button_unified_mappings[] = {
+	{ BTN_DPAD_LEFT,	2, NS2_BTN_U3_LEFT,	},
+	{ BTN_DPAD_UP,		2, NS2_BTN_U3_UP,	},
+	{ BTN_DPAD_DOWN,	2, NS2_BTN_U3_DOWN,	},
+	{ BTN_DPAD_RIGHT,	2, NS2_BTN_U3_RIGHT,	},
+	{ BTN_TL,		2, NS2_BTN_U3_L,	},
+	{ BTN_TL2,		2, NS2_BTN_U3_ZL,	},
+	{ BTN_SELECT,		1, NS2_BTN_U2_MINUS,	},
+	{ BTN_THUMBL,		1, NS2_BTN_U2_LS,	},
+	{ KEY_RECORD,		1, NS2_BTN_U2_CAPTURE,	},
+	{ BTN_GRIPR,		2, NS2_BTN_U3_SL,	},
+	{ BTN_GRIPR2,		2, NS2_BTN_U3_SR,	},
+	{ BTN_GRIPL,		3, NS2_BTN_U4_GL,	},
+	{ /* sentinel */ },
+};
+
 static const struct switch2_ctlr_button_mapping ns2_right_joycon_button_mappings[] = {
 	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
 	{ BTN_EAST,	0, NS2_BTNR_B,		},
@@ -3086,6 +3132,23 @@ static const struct switch2_ctlr_button_mapping ns2_right_joycon_button_mappings
 	{ /* sentinel */ },
 };
 
+static const struct switch2_ctlr_button_mapping ns2_right_joycon_button_unified_mappings[] = {
+	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
+	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
+	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
+	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
+	{ BTN_TR,	0, NS2_BTN_U1_R,	},
+	{ BTN_TR2,	0, NS2_BTN_U1_ZR	},
+	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
+	{ BTN_THUMBR,	1, NS2_BTN_U2_RS,	},
+	{ BTN_C,	1, NS2_BTN_U2_C,	},
+	{ BTN_MODE,	1, NS2_BTN_U2_HOME,	},
+	{ BTN_GRIPL2,	0, NS2_BTN_U1_SL,	},
+	{ BTN_GRIPL,	0, NS2_BTN_U1_SR,	},
+	{ BTN_GRIPR,	3, NS2_BTN_U4_GR,	},
+	{ /* sentinel */ },
+};
+
 static const struct switch2_ctlr_button_mapping ns2_procon_mappings[] = {
 	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
 	{ BTN_EAST,	0, NS2_BTNR_B,		},
@@ -3107,6 +3170,27 @@ static const struct switch2_ctlr_button_mapping ns2_procon_mappings[] = {
 	{ /* sentinel */ },
 };
 
+static const struct switch2_ctlr_button_mapping ns2_procon_unified_mappings[] = {
+	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
+	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
+	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
+	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
+	{ BTN_TL,	2, NS2_BTN_U3_L,	},
+	{ BTN_TR,	0, NS2_BTN_U1_R,	},
+	{ BTN_TL2,	2, NS2_BTN_U3_ZL,	},
+	{ BTN_TR2,	0, NS2_BTN_U1_ZR,	},
+	{ BTN_SELECT,	1, NS2_BTN_U2_MINUS,	},
+	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
+	{ BTN_THUMBL,	1, NS2_BTN_U2_LS,	},
+	{ BTN_THUMBR,	1, NS2_BTN_U2_RS,	},
+	{ BTN_MODE,	1, NS2_BTN_U2_HOME	},
+	{ KEY_RECORD,	1, NS2_BTN_U2_CAPTURE	},
+	{ BTN_GRIPR,	3, NS2_BTN_U4_GR	},
+	{ BTN_GRIPL,	3, NS2_BTN_U4_GL	},
+	{ BTN_C,	1, NS2_BTN_U2_C		},
+	{ /* sentinel */ },
+};
+
 static const struct switch2_ctlr_button_mapping ns2_gccon_mappings[] = {
 	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
 	{ BTN_EAST,	0, NS2_BTNR_B,		},
@@ -3124,6 +3208,23 @@ static const struct switch2_ctlr_button_mapping ns2_gccon_mappings[] = {
 	{ /* sentinel */ },
 };
 
+static const struct switch2_ctlr_button_mapping ns2_gccon_unified_mappings[] = {
+	{ BTN_SOUTH,	0, NS2_BTN_U1_A,	},
+	{ BTN_EAST,	0, NS2_BTN_U1_B,	},
+	{ BTN_NORTH,	0, NS2_BTN_U1_X,	},
+	{ BTN_WEST,	0, NS2_BTN_U1_Y,	},
+	{ BTN_TL2,	2, NS2_BTN_U3_L,	},
+	{ BTN_TR2,	0, NS2_BTN_U1_R,	},
+	{ BTN_TL,	2, NS2_BTN_U3_ZL	},
+	{ BTN_TR,	0, NS2_BTN_U1_ZR	},
+	{ BTN_SELECT,	1, NS2_BTN_U2_MINUS,	},
+	{ BTN_START,	1, NS2_BTN_U2_PLUS,	},
+	{ BTN_MODE,	1, NS2_BTN_U2_HOME	},
+	{ KEY_RECORD,	1, NS2_BTN_U2_CAPTURE	},
+	{ BTN_C,	1, NS2_BTN_U2_C		},
+	{ /* sentinel */ },
+};
+
 static const uint8_t switch2_init_cmd_data[] = {
 	/*
 	 * The last 6 bytes of this packet are the MAC address of
@@ -3690,11 +3791,48 @@ static int switch2_event(struct hid_device *hdev, struct hid_report *report, uin
 
 	switch (report->id) {
 	case NS2_REPORT_UNIFIED:
-		/*
-		 * TODO
-		 * This won't be sent unless the report type gets changed via command
-		 * 03-0A, but we should support it at some point regardless.
-		 */
+		switch (ns2->ctlr_type) {
+		case NS2_CTLR_TYPE_JCL:
+			switch2_report_stick(input, &ns2->stick_calib[0],
+				ABS_X, false, ABS_Y, true, &raw_data[11]);
+			switch2_report_buttons(input, &raw_data[5],
+				ns2_left_joycon_button_unified_mappings);
+			break;
+		case NS2_CTLR_TYPE_JCR:
+			switch2_report_stick(input, &ns2->stick_calib[0],
+				ABS_X, false, ABS_Y, true, &raw_data[14]);
+			switch2_report_buttons(input, &raw_data[5],
+				ns2_right_joycon_button_unified_mappings);
+			break;
+		case NS2_CTLR_TYPE_GC:
+			input_report_abs(input, ABS_HAT0X,
+				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
+				!!(raw_data[7] & NS2_BTN_U3_LEFT));
+			input_report_abs(input, ABS_HAT0Y,
+				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
+				!!(raw_data[7] & NS2_BTN_U3_UP));
+			switch2_report_buttons(input, &raw_data[5], ns2_gccon_unified_mappings);
+			switch2_report_stick(input, &ns2->stick_calib[0],
+				ABS_X, false, ABS_Y, true, &raw_data[11]);
+			switch2_report_stick(input, &ns2->stick_calib[1],
+				ABS_RX, false, ABS_RY, true, &raw_data[14]);
+			switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[0x3d]);
+			switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[0x3e]);
+			break;
+		case NS2_CTLR_TYPE_PRO:
+			input_report_abs(input, ABS_HAT0X,
+				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
+				!!(raw_data[7] & NS2_BTN_U3_LEFT));
+			input_report_abs(input, ABS_HAT0Y,
+				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
+				!!(raw_data[7] & NS2_BTN_U3_UP));
+			switch2_report_buttons(input, &raw_data[5], ns2_procon_unified_mappings);
+			switch2_report_stick(input, &ns2->stick_calib[0],
+				ABS_X, false, ABS_Y, true, &raw_data[11]);
+			switch2_report_stick(input, &ns2->stick_calib[1],
+				ABS_RX, false, ABS_RY, true, &raw_data[14]);
+			break;
+		}
 		break;
 	case NS2_REPORT_JCL:
 		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
-- 
2.54.0

