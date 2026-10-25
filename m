Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972385;
	b=q+KX6IQKacX3gNldeLdBHY5j55oX5xb3RRLVDvc4uzL+O/wPWEkzRKIt8y7xL8za018x
	 pHiyXxruybsn2Y1V5FbE3kJ1juR2gWEHTWZEyEpw7p0yl6UyS8uPTrb+R3lm0oY8MeR62
	 7P3vds2/KdbOG+xudJWGzhG+dkJh1A/g1EC4WnY8Zf3XZbyuOW4UwTEF6Uw/3MpVDLg44
	 ng0HMt/7mvha1uY6ph2xo0LkGsA2TUvcVyILi8eAsl9tzttqsdZEmx/GMU9T83re2gsr5
	 GXVFBPpeGeTrSKU1Wktz5P+ThQQ4zCMJRY8YwZcH5MIPHeN8CA2jkb0QfN4mhlQtU/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972385;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7A8P4RzYpNGwGiQBGJaS8LAYy4G86JrRiE6cgjDAfdk=;
	b=EebhJy8ejw8GHOY2gv5dorfH7KWqnKFhWMKx85/33eoM3QGYMvYSIL+b+vNfuoHm1Pbj
	 qfAbfiHtguX4YuyszHpOs+yeskJuocBfg2OVxw2bWSpHeMeGeuXGNGqVGnZmtejKLDkUk
	 03CLnY7VgnT8LuiNafjYTCU7iXPqGjLbu3+LzLFY9s0b/P6I8a9D1BROgPQoz0ZD/A1FK
	 bVChaKpTFeMUf62b4UkJr/zD7wm17ehfpRYkVRt5cU0aY2uLUSRGKjcuPdxSv0vvefnDY
	 ZGd0+MMpSZoTB4iiHkbHaQil4t2Z7SYKS3DGAcUSnWKPaaLWjyb229y09AUYRD2R3Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UnBQqN3w;
	arc=none smtp.remote-ip=95.215.58.98
Received: from mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAA60A261F
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BAA60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UnBQqN3w
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PQj14AKff6OHLvol8saVkczSv7fprx10zXikezABRl0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972382; v=1; x=1793577182;
 b=UnBQqN3woKHNQIhrx3sBf8hrP7YG61+qCo3JLd25xN7Y7fmsZJcJJldjwvJzIuOjeNR6miXN
 nHuhv7uxNGVsKPubtcyNhQaPK268VmGXNPtP1+jD9Me1hw+yUqyOS4UHljXIROFTMp9yJdZjk1A
 FVUJFu857CofYGTgHiUFotgk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bfc0de32eb9d6a2d;
	Sun, 25 Oct 2026 23:53:02 +0000
X-Mizu-Trace-ID: bfc0de32eb9d6a2d
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v11 12/18] HID: asus: size feature reports from the HID report descriptor
Date: Sun, 25 Oct 2026 23:52:25 +0000
Message-ID: <20261025235232.129945-13-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025235232.129945-1-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Benato <benato.denis96@gmail.com>

The ASUS vendor protocol uses the same feature report IDs across very
different devices: on N-KEY keyboards and ROG Ally report 0x5A/0x5E are
64-byte reports, while on XG Mobile stations report 0x5E is a 300-byte
report. The driver currently hardcodes transfer lengths (16 bytes for
the handshake, FEATURE_KBD_REPORT_SIZE for reads, ROG_XGM_REPORT_SIZE
for the XG Mobile LED), which mismatches what the hardware expects and
would break if a new device used yet another size for the same report
ID.

Derive the transfer length of every feature report from the HID report
descriptor of the device at hand:

- add asus_report_len(), which resolves a report ID to its struct
  hid_report and returns hid_report_len();
- asus_kbd_set_report() now zero-pads short payloads to the exact
  report size and rejects payloads that do not fit the report;
- add asus_kbd_get_report() and use it from asus_kbd_init() and
  asus_kbd_get_functions() so reads are sized per report as well;
- asus_xgm_led_set() sends a minimal payload and checks the transfer
  result against the descriptor length instead of the hardcoded
  ROG_XGM_REPORT_SIZE, which is removed along with the fixed-size
  buffers in asus_kbd_set_fn_lock() and asus_kbd_set_brightness().

Captured USB traffic of the same commands issued by Windows shows they
are always written at the full report length, which this change now
matches.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 148 +++++++++++++++++++++++++++++++++--------
 1 file changed, 120 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ea27495c3df6..fe2a326ccd86 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -63,8 +63,6 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
-#define ROG_XGM_REPORT_SIZE 300
-
 #define ROG_ALLY_REPORT_SIZE 64
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
@@ -658,6 +656,51 @@ static void ally_probe_release_role(int ep)
 	spin_unlock_irqrestore(&ally_data_lock, flags);
 }
 
+/**
+ * asus_find_report() - Find a report of the given type by its ID
+ * @hdev: HID device
+ * @type: report type (HID_INPUT_REPORT, HID_OUTPUT_REPORT or
+ * HID_FEATURE_REPORT)
+ * @report_id: report ID to look for
+ *
+ * Return: the report with the given ID, or NULL if the device does not
+ * declare such a report
+ */
+static struct hid_report *asus_find_report(struct hid_device *hdev,
+					   unsigned int type, u8 report_id)
+{
+	struct hid_report *report;
+
+	list_for_each_entry(report, &hdev->report_enum[type].report_list, list) {
+		if (report->id == report_id)
+			return report;
+	}
+
+	return NULL;
+}
+
+/**
+ * asus_report_len() - Length of a feature report for the device
+ * @hdev: HID device
+ * @report_id: report ID of the feature report
+ *
+ * The same ASUS report ID can have different sizes depending on the device:
+ * report 0x5E is a 64-byte report on laptops but a 300-byte report on XG
+ * Mobile stations. Always size transfers from the report descriptor of the
+ * device at hand instead of hardcoding lengths.
+ *
+ * Return: the length of the feature report in bytes, or 0 if the device
+ * does not declare the report
+ */
+static size_t asus_report_len(struct hid_device *hdev, u8 report_id)
+{
+	struct hid_report *report;
+
+	report = asus_find_report(hdev, HID_FEATURE_REPORT, report_id);
+
+	return report ? hid_report_len(report) : 0;
+}
+
 static const u8 asus_report_id_init[] = {
 	FEATURE_KBD_REPORT_ID,
 	FEATURE_KBD_LED_REPORT_ID1,
@@ -5370,18 +5413,64 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
-	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
+	size_t hw_len = asus_report_len(hdev, buf[0]);
+
+	/* The payload (including the report ID) must fit the device report. */
+	if (!hw_len || buf_size > hw_len)
+		return -EINVAL;
+
+	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
 
+	memcpy(dmabuf, buf, buf_size);
+
 	/*
-	 * The report ID should be set from the incoming buffer due to LED and key
-	 * interfaces having different pages
+	 * The report ID should be set from the incoming buffer due to LED and
+	 * key interfaces having different pages. Short payloads are zero-padded
+	 * to the exact report size the hardware expects for this report ID.
 	 */
-	return hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
+	return hid_hw_raw_request(hdev, buf[0], dmabuf, hw_len, HID_FEATURE_REPORT,
 				  HID_REQ_SET_REPORT);
 }
 
+/**
+ * asus_kbd_get_report() - Read a report sized from the descriptor
+ * @hdev: HID device
+ * @report_id: report ID to read
+ * @buf: buffer to store the report in
+ * @buf_size: size of @buf
+ *
+ * The transfer is performed at the exact report size the device declares
+ * for @report_id. The device may answer with a short read, and only the
+ * bytes that fit in @buf are copied into it.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int asus_kbd_get_report(struct hid_device *hdev, u8 report_id,
+			       u8 *buf, size_t buf_size)
+{
+	size_t hw_len = asus_report_len(hdev, report_id);
+	int ret;
+
+	if (!hw_len)
+		return -EINVAL;
+
+	u8 *dmabuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, report_id, dmabuf, hw_len,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0)
+		return ret;
+
+	/* The device may return less than requested (short read). */
+	memcpy(buf, dmabuf, min(buf_size, hw_len));
+
+	return 0;
+}
+
 static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 {
 	/*
@@ -5390,8 +5479,13 @@ static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 	 */
 	const u8 buf[] = { report_id, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
+	size_t hw_len = asus_report_len(hdev, report_id);
+	size_t cmp_len;
 	int ret;
 
+	if (!hw_len)
+		return -EINVAL;
+
 	ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
 	if (ret < 0) {
 		hid_err(hdev, "Asus handshake %02x failed to send: %d\n",
@@ -5399,19 +5493,20 @@ static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 		return ret;
 	}
 
-	u8 *readbuf __free(kfree) = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
+	u8 *readbuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
 	if (!readbuf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, report_id, readbuf,
-				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
-				 HID_REQ_GET_REPORT);
+	ret = asus_kbd_get_report(hdev, report_id, readbuf, hw_len);
 	if (ret < 0) {
 		hid_warn(hdev, "Asus handshake %02x failed to receive ack: %d\n",
 			 report_id, ret);
-	} else if (memcmp(readbuf, buf, sizeof(buf)) != 0) {
-		hid_warn(hdev, "Asus handshake %02x returned invalid response: %*ph\n",
-			 report_id, FEATURE_KBD_REPORT_SIZE, readbuf);
+	} else {
+		cmp_len = min_t(size_t, sizeof(buf), hw_len);
+		if (memcmp(readbuf, buf, cmp_len) != 0) {
+			hid_warn(hdev, "Asus handshake %02x returned invalid response: %*ph\n",
+				 report_id, (int)cmp_len, readbuf);
+		}
 	}
 
 	/*
@@ -5426,7 +5521,7 @@ static int asus_kbd_get_functions(struct hid_device *hdev,
 				  u8 report_id)
 {
 	const u8 buf[] = { report_id, 0x05, 0x20, 0x31, 0x00, 0x08 };
-	u8 *readbuf;
+	size_t hw_len = asus_report_len(hdev, report_id);
 	int ret;
 
 	ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
@@ -5435,23 +5530,22 @@ static int asus_kbd_get_functions(struct hid_device *hdev,
 		return ret;
 	}
 
-	readbuf = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
+	if (!hw_len)
+		return -EINVAL;
+
+	u8 *readbuf __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
 	if (!readbuf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, report_id, readbuf,
-				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
-				 HID_REQ_GET_REPORT);
+	ret = asus_kbd_get_report(hdev, report_id, readbuf, hw_len);
 	if (ret < 0) {
 		hid_err(hdev, "Asus failed to request functions: %d\n", ret);
-		kfree(readbuf);
 		return ret;
 	}
 
 	*kbd_func = readbuf[6];
 
-	kfree(readbuf);
-	return ret;
+	return 0;
 }
 
 static int asus_kbd_disable_oobe(struct hid_device *hdev)
@@ -5476,7 +5570,7 @@ static int asus_kbd_disable_oobe(struct hid_device *hdev)
 
 static void asus_kbd_set_fn_lock(struct hid_device *hdev, bool enabled)
 {
-	const u8 buf[FEATURE_KBD_REPORT_SIZE] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x4e, !!enabled };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x4e, !!enabled };
 	int ret;
 
 	ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
@@ -5486,7 +5580,7 @@ static void asus_kbd_set_fn_lock(struct hid_device *hdev, bool enabled)
 
 static void asus_kbd_set_brightness(struct hid_device *hdev, u8 brightness)
 {
-	const u8 buf[FEATURE_KBD_REPORT_SIZE] = {
+	const u8 buf[] = {
 		FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, brightness
 	};
 	int ret;
@@ -5957,17 +6051,15 @@ static int asus_battery_probe(struct hid_device *hdev)
 
 static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
 {
-	const u8 buf[ROG_XGM_REPORT_SIZE] = {
-		FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
-	};
+	const u8 buf[] = { FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00 };
 	struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
 	int ret;
 
-	ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
+	ret = asus_kbd_set_report(xgm->hdev, buf, sizeof(buf));
 	if (ret < 0) {
 		hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
 		return ret;
-	} else if (ret != ROG_XGM_REPORT_SIZE) {
+	} else if (ret != (int)asus_report_len(xgm->hdev, FEATURE_KBD_LED_REPORT_ID2)) {
 		hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
 		return -EIO;
 	}
-- 
2.47.3

