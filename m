Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CE4E01FE
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546581; cv=none; b=fZmWojZXYGmeqA6XaB5+qkanATwGsdvwD54CYR0e8JO+lYMhs8aneFNaS+Yvym6h41k+n5QX2zsepNzu53YJL/1uusOrar2Pf8xH9SoYw7KDv2RwSK5lxHWxAA3fpbiOA6zKUPqcbFxDoZXC6fg4C1LwADb6RRWtXJH8I829GHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546581; c=relaxed/simple;
	bh=kSldjP/LJAFNxvSitEbFvA30E6J1HGiVZNJXHPDdUoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J49uL5p2Zy/OSE1I4XirJagLBJETEyZzy4BefVWvL27VcIGLXsF/a5Xof4FETGch6An3JjgZ5QrTnWEnIQKnwoWn22tOzzDsZa1MDljYSTLYK+OMfRm3kvcLOyY/AAreJnx349wfUwFVcbpdG6MAaiOCaEvyORKq6glvoq77cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBcb9KEA; arc=none smtp.client-ip=95.215.58.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBcb9KEA"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kSldjP/LJAFNxvSitEbFvA30E6J1HGiVZNJXHPDdUoQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791546569; v=1; x=1792151369;
 b=DBcb9KEA+UiQacIChJV3LVSb0P1LZkOrziIXE55PIRDsloHYwq1K7n4LbLwL+0ixZxOLGDat
 RCUcPyskKE5VuPMOMMIc8IG6b1tNqZRHHb5M8+vLvS8GfH4eVw25pnnbw9vHK2CtST1g0wp103W
 uXiNN2thgyFYu4088SZ6IgrY=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5218cc65a865b242;
	Fri, 09 Oct 2026 11:49:29 +0000
X-Mizu-Trace-ID: 5218cc65a865b242
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 2/3] HID: asus: reinitialize the device after exiting a sleep state
Date: Fri,  9 Oct 2026 11:49:20 +0000
Message-ID: <20261009114921.5242-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009114921.5242-1-denis.benato@linux.dev>
References: <20261009114921.5242-1-denis.benato@linux.dev>
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
index 3a8b8b7e90f7..03150d29eec5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1384,6 +1384,28 @@ static int asus_start_multitouch(struct hid_device *hdev)
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
@@ -1403,6 +1425,9 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	if (!drvdata->tp)
+		asus_initialize_reports(hdev);
+
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
@@ -1517,16 +1542,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

