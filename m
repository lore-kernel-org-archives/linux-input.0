Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253433556D;
	Thu, 14 May 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778995; cv=none; b=CpV8gnURMxvtcVzZnavN4nzPknt9gP/8rOglUvs0NmJGRL8rjVX0ElH6wSKXbn8Yd1rDAUip7FjGk9plzHd+aApUZpYkh1O+3BmuJAg/ztIdfqeCLZ888hiz99T5ihpUvVg3TsSHItyHDCxhUUlas9sKAjjQ/Ef2NDdt7k2Szlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778995; c=relaxed/simple;
	bh=s0x3Of3Ott00mjF+YJ7PkSGzXwpTvoiodtYgYgaOg/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsZUjK7Bpa339RMiiTnTaspBfpWc8u5tDtm4oL8v/vsC6NHJRZJKQ9Pls/iOIUwIat7i1WJURbX0/9EMMf0cAwOeaY2GvgcW3bVNtm7hbL+hn9RN0D8T/btP7aqgz7diYjw8ScXauUO7JnL67RJYso2h3GAY8ht2Pnzx2DVZYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fressl.at; spf=pass smtp.mailfrom=fressl.at; dkim=pass (2048-bit key) header.d=fressl.at header.i=@fressl.at header.b=tlCZE21V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pyPv7YMV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fressl.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fressl.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fressl.at header.i=@fressl.at header.b="tlCZE21V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pyPv7YMV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 36C2F1D000CA;
	Thu, 14 May 2026 13:16:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 14 May 2026 13:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fressl.at; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778778990; x=
	1778865390; bh=LmUz0B1oTvKXRyQFSfgyeyw5Wr6ijHk0JUVcDtCBV3U=; b=t
	lCZE21V8O+SVFvsytWzIfUpHaE7w31Dgc0PUSrdKVBr+5CsIV9+Hi5ZUrB8DnX9Z
	j6cZhyNePOwZeajc5ETB8h7wmzvxWU2/jlqABhRN0dX5kwI1MwpWasLyh7bGvxvj
	vaItWK2lD0TMiKXBlTfVqwcxk1zSYlXtu0xrCqJeZb2kPqskLD4iM8aW4owaYNRl
	s9P/n5nSvs2Jmyoj7sJ1CG3yMlVgShvtSGVpFRlwmx/Ks2fYOkTVDqx776CxXbvN
	m/CFsibyIPSFxaEc4g8HlsWplr4l9THwfUZtcMSCRrD9aTCgNXIu/DzIwCSpVmpP
	2AfFBPdHqyuRQAudQKI6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778778990; x=1778865390; bh=L
	mUz0B1oTvKXRyQFSfgyeyw5Wr6ijHk0JUVcDtCBV3U=; b=pyPv7YMVyAuHL97vM
	t5QzNQWuG6RrYAFStn5gnJ1+4nJkKBm46EFnfhxCGgXZBSMd1bW3EDMqNyNjgrji
	2V00YWyH4p1Pt4T+TcV5MvyTzD/v1Sl3Kg1SWeyLryrJo2dnea7Ow8MSbzoNWlbL
	GPj6dIr5Vq2kCKnBzbfPkj63g+MX1TgHmOPW0Li8NCmCbfz3eSTimz/BKcuUdSDa
	NTK1I9hf+/OueHQ0JT87ZvAfmWYUgAR/BCFUgJjrBcaQnuB3cx869510wSn1VPY5
	oK347yafl2W9b3a7z6D6nnX19bVCuBjHK3RXtnXah/QStQqlKd+Y/SNOkGJNQCU4
	9lJ8w==
X-ME-Sender: <xms:bgMGas3zOuSKUqjPtUHieANWH8Crx6_ygrULQrsnitnwhRJd3oqCBw>
    <xme:bgMGaokmwTBHEsFQ3v86W5GHr2NfASf0szVQEYcHPyRbLohatBnolYw119Lz8Avwd
    GPF2OIq_v60yV7OX-pazxCtCgmiov_A7PN9l8u07P_FPX_lj5_F4Fc>
X-ME-Received: <xmr:bgMGak87PtQpCw1HYc2fjWpTGruG19k7BDEuZcRkybnKGH-eALoF6TSs_8kBOM28_r0daDDE3j1hdrO0GeQfgJs3YTv7UA-Wiqn4XS8RRi2DuTxdOjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrhhishht
    ihgrnhcuhfhrvghsshhluceotghhrhhishhtihgrnhesfhhrvghsshhlrdgrtheqnecugg
    ftrfgrthhtvghrnhepkeduvdejvdekleevgfekgfetvdehgfetkefgieeiledvgfevgeei
    gfeiueeludetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhrihhsthhirghnsehfrhgv
    shhslhdrrghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhesfhhrvghssh
    hlrdgrth
X-ME-Proxy: <xmx:bgMGalqUmHqxStVa6d7TAGyJScW5DW7065-cC3Uo0wigByifIoiSLw>
    <xmx:bgMGallOcW0AxrDHN3WWeP4610TgM09uPOE6lPhVIVKQbw2Az8bVEw>
    <xmx:bgMGakiTH8UYp9b0PBfEEiQZ45ncDyPWSHfjdLHBqWztouVj65oHVw>
    <xmx:bgMGalfA58vOmj8RxayNFseXmM6zBTO_UoEvZvjncsevR2UBzRIq-g>
    <xmx:bgMGastntreLKjleYHSN9HdKJEjgb1pHt5Oy3WrfYezlplKVfiJFzOqL>
Feedback-ID: i6b4e4bd3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 13:16:29 -0400 (EDT)
From: Christian Fressl <christian@fressl.at>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Fressl <christian@fressl.at>
Subject: [PATCH v2] HID: magicmouse: add haptic click configuration for Magic Trackpad 2
Date: Thu, 14 May 2026 19:15:24 +0200
Message-ID: <20260514171524.110189-1-christian@fressl.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513001649.E9EE5C2BCB0@smtp.kernel.org>
References: <20260513001649.E9EE5C2BCB0@smtp.kernel.org>
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
Changes in v2:
- Cache haptic_click with READ_ONCE() before applying the setting.

 drivers/hid/hid-magicmouse.c | 102 ++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index e70bd3dc07ab..e941c95f0703 100644
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
@@ -812,6 +827,82 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
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
+	unsigned int click = READ_ONCE(haptic_click);
+	u32 click_feedback;
+	u32 release_feedback;
+	int ret;
+
+	if (click == TRACKPAD2_HAPTIC_CLICK_UNCHANGED)
+		return 0;
+
+	switch (click) {
+	case TRACKPAD2_HAPTIC_CLICK_SILENT_LOW:
+		click_feedback = TRACKPAD2_HAPTIC_SILENT_CLICK;
+		release_feedback = TRACKPAD2_HAPTIC_SILENT_RELEASE;
+		break;
+	case TRACKPAD2_HAPTIC_CLICK_OFF:
+		click_feedback = TRACKPAD2_HAPTIC_OFF;
+		release_feedback = TRACKPAD2_HAPTIC_OFF;
+		break;
+	default:
+		hid_warn(hdev, "invalid haptic_click value %u\n", click);
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
@@ -894,8 +985,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 
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
