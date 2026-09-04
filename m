Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC54EBAF8
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534085; cv=none; b=WabM5jRQk/okAhnk9UuwezCUZOqx6xQhNsoK0yodC4kuTCY3xOX0vmpcqN4d/uAkCvHJZ1bVePL0u3zM3+A9uk2nnGhdIXnlmrFLMluvsrUKxSePSUThpjLkALFQCH4PN8ue1lnF9tn2m/diLrNRyLb455cgWJ59p8lAJe2Hi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534085; c=relaxed/simple;
	bh=s1tCujWEhQUGKDrIj/SWc90xs4vo11d1o+0/tXUXAv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCzOOfH6r1xJIqJ3zwAlc6jMGzFg1GFA1hI+kwzh+7uXKs8uy36YEs1zE/7vmzQjeAqvym2YuhnyBWWJh2MzriaLUGkalITkAjaOMWPHdtMjwcUpDsy9tBX3a0NtsgB7TjwwS0NayAZa9NmAHd8yKQLTiWzsRGJwEwPXSK0FWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=etBDJ/8T; arc=none smtp.client-ip=95.215.58.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="etBDJ/8T"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s1tCujWEhQUGKDrIj/SWc90xs4vo11d1o+0/tXUXAv4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788534078; v=1; x=1789138878;
 b=etBDJ/8TDiFjpqpUv5I1q3iJXStaGeCHGvBZrbquF8wotZnp/9XCryE9CwV5LvsYDwqa7FLb
 3DvUqg2gROWEXf53Ap+TM/AEpRGKrOVZ8Vpq4VxoLv7V5uXvE9+4hdUrut/gyOg0f5PHGYhOHf/
 TgJ1PxRNaEUeCmdItPkPmnDw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bcda9f4ba48e80c5;
	Fri, 04 Sep 2026 15:01:18 +0000
X-Mizu-Trace-ID: bcda9f4ba48e80c5
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v5 02/13] HID: asus: reinitialize the device after exiting a sleep state
Date: Fri,  4 Sep 2026 14:58:33 +0000
Message-ID: <20260904145845.184887-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904145845.184887-1-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ROG ally needs to have the EC string sent back after resuming from
s2idle since the USB device can be turned completely off by the firmware
when mcu_powersave firmware-attribute is set to 1.

This may also be true for other laptops and certain features might stop
working after the device exit from sleep.

Assisted-by: opencode:glm-5.2
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bd46aba6622a..2125680c7eff 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1360,6 +1360,28 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+/*
+ * Initialize the reports of the device.
+ *
+ * Failures are intentionally not fatal: asus_kbd_init() tolerates a wrong
+ * handshake until this is verified to work for all devices, so a failure
+ * is only reported and the initialization of the remaining reports is
+ * still attempted.
+ */
+static void asus_initialize_reports(struct hid_device *hdev)
+{
+	int ret;
+
+	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+					 asus_report_id_init[r], ret);
+		}
+	}
+}
+
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1379,6 +1401,9 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	if (!drvdata->tp)
+		asus_initialize_reports(hdev);
+
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
@@ -1493,16 +1518,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (!drvdata->tp) {
-		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-				if (ret < 0)
-					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-						 asus_report_id_init[r], ret);
-			}
-		}
-	}
+	if (!drvdata->tp)
+		asus_initialize_reports(hdev);
 
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
-- 
2.47.3

