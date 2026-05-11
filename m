Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C923A0EAF;
	Mon, 11 May 2026 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531595; cv=none; b=dEAPbxvhhLwFbDhbXNIdzq/IglGJdsK4S6oGnSVWxYjyZZcrSjGH5X+Vl90FeAUS3IKyB5cYVtrSo32wiJnt7HEiUPSrrnO8/cY1TbejIryUcvCta+fiKd4ImSbnQy3NnfniXGipuU0CvI0J5DV9oHmvMJZ7VV/SB3EWETxF6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531595; c=relaxed/simple;
	bh=/ZFnQ7h5d1rmY6bMZub6uFSkgjI6FCdPzgQCAWChS4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWUSzbfaXxEBVz3fR97nt3CGer0BQy8Wls6hjxTagXNeZtIZ/yqzV/2K3VXgtWxbUNJle81G4HKQE4cVlPj7tyYn1cvfSlFFqBbx7gjsmfDc2htZ6D0nsWW1fzr4QteA+g1XRNKH1FGWWbDBWTVTc3vROoQlz/zPB4YgD9OxwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fressl.at; spf=pass smtp.mailfrom=fressl.at; dkim=pass (2048-bit key) header.d=fressl.at header.i=@fressl.at header.b=Ank2/Xq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWuTjt2x; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fressl.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fressl.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fressl.at header.i=@fressl.at header.b="Ank2/Xq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWuTjt2x"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D0CEDEC006C;
	Mon, 11 May 2026 16:33:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 16:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fressl.at; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1778531591; x=1778617991; bh=nA4wPNAJbmjgbmwn5BCRi
	aCJim7nlvv96FAHBgXYspY=; b=Ank2/Xq0XFJ7Y/S+az15SCNHAG4xVqQNMJSFQ
	uDBUraSqS5FcusNWobimSCg+Iik+EH0q98zHlkXVjUSYISGm3z7LQweEuBh7zK7L
	nJ9zWKZ3tFKoacP7/c2xPqpgbFQnYuGUwBbLviPoGAABaQystiV3Kp3Ws6/Im8B0
	AwdqKdDrjzCs7+6NpNCeXtQ3jSG6SuQzX0O5bEAFNrHYx0on3175X9jlaYaUgoAs
	KF/I0oCqkmFbQwjxSERFOUxcjc0zOFCyIluUNM2M9kq9iX6jv4TdzFQzLLhFtlPz
	e4KU7SehjCVqaG9rJukx+n8Mn3DIoNPdwhq1aZAl0ZHZTKQPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778531591; x=1778617991; bh=nA4wPNAJbmjgbmwn5BCRiaCJim7nlvv96FA
	HBgXYspY=; b=dWuTjt2xTDC4N+/YeuwxQy5k51CqkRe/rpZmohdVAKvtKQPhERQ
	90aphMT1ZRWmXSLkpW43ucfsAruUbY+XQvyeIVTQRK9SslEYC2I+K+CHtyOjXn/5
	01mPy/aX2o5NgFO2TnnAG1Un7W/pWkmGvVxlFFcEA4H61ZoFfocNmE8sn1UInpwR
	lMbNIAlHhYjQBJg3INz3SSgwshXlWq6dC9kROAtPjccgJNa+Pnfvk//GLjr2x0Mx
	ioVUeSpGTGucnw1bSh9xG3mw2bJhHT7LwDgCPBKvT6j+UnCNze1jbIU/CqGJ7yiN
	iaZNR3HBrkyBeEqszjq5Rm7MyNDZF2SE9Gg==
X-ME-Sender: <xms:Bz0Cau8f-Ras_z1hESYauQtZSTwz42BXvXLpKbhG8ebm7gIojREDnw>
    <xme:Bz0CagN9uNLDr94zVGf32Y214JPaGsha-kb2chfgqbImMmvKYUw9P2YqJ_rwaTgIL
    zn3v3_eyOAPkq1dDlm0iG4ZQpCLZcAGGubBAV_jqrV6rgpzJUPusAA>
X-ME-Received: <xmr:Bz0CakGpt4aWBAIh1ia2hiqU-CWktNZDzyxHL6wX1AkTTCjRZbAC7YTlQ-7XgpuxypQbLwqJfQDxe6m_HlKD9IeYI4oyuzir6ISRNHiEo1fjU7oReHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvehhrhhishhtihgr
    nhcuhfhrvghsshhluceotghhrhhishhtihgrnhesfhhrvghsshhlrdgrtheqnecuggftrf
    grthhtvghrnhepleevfeeiheejhfdujedukeffgeelleevhfefvdekieejkedthfffvedu
    heeuhedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhrihhsthhirghnsehfrhgvshhs
    lhdrrghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhesfhhrvghsshhlrd
    grth
X-ME-Proxy: <xmx:Bz0CamTQK8j11DwQ__UGkDglQfbxqEk1luwTX4hG0Vyw8KI1zKGfAQ>
    <xmx:Bz0CapvaSsLlDorYst1x6S1ozLwx8-6k69p-eRd6ez5KmZ-oqHEhMQ>
    <xmx:Bz0CamKXm-KLAIBMxDmq1X9uea_EkEyekwpQa9JUYIin2Yrah-xjmg>
    <xmx:Bz0CamnbXBkEUuL4thwqxzw6k394Tu0VUB6nmDPV0Be5Ludfq_Apyw>
    <xmx:Bz0CamX7GHDT_T0VqtorgeOY18K_Lu5otDeFfPeRrqslERgQUgQrOyea>
Feedback-ID: i6b4e4bd3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 16:33:10 -0400 (EDT)
From: Christian Fressl <christian@fressl.at>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Fressl <christian@fressl.at>
Subject: [PATCH] HID: magicmouse: add haptic click configuration for Magic Trackpad 2
Date: Mon, 11 May 2026 22:31:15 +0200
Message-ID: <20260511203115.104087-1-christian@fressl.at>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple Magic Trackpad 2 devices support persistent haptic feedback
configuration through feature reports 0x22 and 0x23. Add an opt-in
module parameter to select either the verified silent-low profile or to
disable haptic feedback.

The default remains unchanged. The report payload format is
reverse-engineered, so keep the existing payload bytes fixed and vary
only the known 24-bit feedback value.

The USB-C Trackpad exposes multiple HID interfaces. Use the one-shot
actuator output report 0x53 only to identify the interface that accepts
the persistent configuration reports; do not use it for the persistent
setting itself.

Tested on Apple Magic Trackpad USB-C 05ac:0324 with Ubuntu
6.17.0-23-generic. Compile-tested against HID for-next.

Protocol information was derived from public reverse-engineering notes,
then independently tested with local hardware.

Link: https://github.com/mwyborski/Linux-Magic-Trackpad-2-Driver/issues/28#issuecomment-451625504
Signed-off-by: Christian Fressl <christian@fressl.at>
---
 drivers/hid/hid-magicmouse.c | 101 ++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index e70bd3dc07ab..31002cb1f108 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -51,6 +51,10 @@ static bool report_undeciphered;
 module_param(report_undeciphered, bool, 0644);
 MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
 
+static unsigned int haptic_click;
+module_param(haptic_click, uint, 0644);
+MODULE_PARM_DESC(haptic_click, "Haptic click feedback: 0=unchanged, 1=silent-low, 2=off");
+
 #define TRACKPAD2_2021_BT_VERSION 0x110
 #define TRACKPAD_2024_BT_VERSION 0x314
 
@@ -62,6 +66,17 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define DOUBLE_REPORT_ID   0xf7
 #define USB_BATTERY_TIMEOUT_SEC 60
 
+#define TRACKPAD2_HAPTIC_CLICK_REPORT_ID     0x22
+#define TRACKPAD2_HAPTIC_RELEASE_REPORT_ID   0x23
+#define TRACKPAD2_HAPTIC_ACTUATOR_REPORT_ID  0x53
+#define TRACKPAD2_HAPTIC_REPORT_LEN          14
+#define TRACKPAD2_HAPTIC_CLICK_UNCHANGED     0
+#define TRACKPAD2_HAPTIC_CLICK_SILENT_LOW    1
+#define TRACKPAD2_HAPTIC_CLICK_OFF           2
+#define TRACKPAD2_HAPTIC_SILENT_CLICK        0x000015
+#define TRACKPAD2_HAPTIC_SILENT_RELEASE      0x000010
+#define TRACKPAD2_HAPTIC_OFF                 0x000000
+
 /* These definitions are not precise, but they're close enough.  (Bits
  * 0x03 seem to indicate the aspect ratio of the touch, bits 0x70 seem
  * to be some kind of bit mask -- 0x20 may be a near-field reading,
@@ -812,6 +827,81 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
 	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
 }
 
+static bool magicmouse_is_haptic_interface(struct hid_device *hdev)
+{
+	struct hid_report_enum *report_enum;
+
+	report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
+
+	/*
+	 * The persistent haptic configuration reports are accepted as feature
+	 * reports, but are not advertised in the feature report descriptor.
+	 * Report 0x53 is the one-shot actuator output report and identifies
+	 * the HID interface that accepts the persistent reports.
+	 */
+	return report_enum->report_id_hash[TRACKPAD2_HAPTIC_ACTUATOR_REPORT_ID];
+}
+
+static int magicmouse_send_haptic_report(struct hid_device *hdev, u8 report_id,
+					 u32 feedback)
+{
+	static const u8 report_template[TRACKPAD2_HAPTIC_REPORT_LEN] = {
+		0x00, 0x01, 0x00, 0x78, 0x02, 0x00, 0x24,
+		0x30, 0x06, 0x01, 0x00, 0x18, 0x48, 0x13,
+	};
+	u8 *buf;
+	int ret;
+
+	buf = kmemdup(report_template, sizeof(report_template), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = report_id;
+	buf[2] = feedback & 0xff;
+	buf[5] = (feedback >> 8) & 0xff;
+	buf[10] = (feedback >> 16) & 0xff;
+
+	ret = hid_hw_raw_request(hdev, buf[0], buf, TRACKPAD2_HAPTIC_REPORT_LEN,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	kfree(buf);
+
+	return ret;
+}
+
+static int magicmouse_apply_haptic_click(struct hid_device *hdev)
+{
+	u32 click_feedback;
+	u32 release_feedback;
+	int ret;
+
+	if (haptic_click == TRACKPAD2_HAPTIC_CLICK_UNCHANGED)
+		return 0;
+
+	switch (haptic_click) {
+	case TRACKPAD2_HAPTIC_CLICK_SILENT_LOW:
+		click_feedback = TRACKPAD2_HAPTIC_SILENT_CLICK;
+		release_feedback = TRACKPAD2_HAPTIC_SILENT_RELEASE;
+		break;
+	case TRACKPAD2_HAPTIC_CLICK_OFF:
+		click_feedback = TRACKPAD2_HAPTIC_OFF;
+		release_feedback = TRACKPAD2_HAPTIC_OFF;
+		break;
+	default:
+		hid_warn(hdev, "invalid haptic_click value %u\n", haptic_click);
+		return -EINVAL;
+	}
+
+	ret = magicmouse_send_haptic_report(hdev,
+					    TRACKPAD2_HAPTIC_CLICK_REPORT_ID,
+					    click_feedback);
+	if (ret < 0)
+		return ret;
+
+	return magicmouse_send_haptic_report(hdev,
+					     TRACKPAD2_HAPTIC_RELEASE_REPORT_ID,
+					     release_feedback);
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
@@ -894,8 +984,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    (is_usb_magictrackpad2(id->vendor, id->product) &&
-	     hdev->type != HID_TYPE_USBMOUSE))
+	     hdev->type != HID_TYPE_USBMOUSE)) {
+		if (is_usb_magictrackpad2(id->vendor, id->product) &&
+		    magicmouse_is_haptic_interface(hdev)) {
+			ret = magicmouse_apply_haptic_click(hdev);
+			if (ret < 0)
+				hid_warn(hdev,
+					 "unable to apply haptic click setting (%d)\n",
+					 ret);
+		}
 		return 0;
+	}
 
 	if (!msc->input) {
 		hid_err(hdev, "magicmouse input not registered\n");
-- 
2.43.0

