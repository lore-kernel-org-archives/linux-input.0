Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C573D5C32
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169527; cv=none; b=Oxu/hIpWfh+8tFp87MHvKpRESv4P0zOZD6AsdIhbiFCutZLTEGBcH5OF3vvLdaSrutHpOqDbMJzME41ke4iu+0H644ZwUC/dpR1VYPLm5Exf31/XbNxRyQKI3o4xdjJDfWM5slIxY3mCBevOuLCMk0l/F1mkw7JJYKdpuDtYYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169527; c=relaxed/simple;
	bh=Bp87kOeClRK8ag3auzASadPQSRjPJ9UqL5zQDK3Nbso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTCuu6NnX5LURT+6umeyrmj3NAmwuoIi1Bb9tyugzyieHapq/uo7pxnfXtk/SiPZpQkJEc1VskDbBB0q8gPzdfltm5Uw+jRszbW5XqIrmLcNDVdopWjeo0E8zuFTWE3C9rP8CN5UB4ik/Jq4t1E6WvdxkQvjuUpaelaSDV87E40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9tfCJMG; arc=none smtp.client-ip=91.218.175.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9tfCJMG"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Bp87kOeClRK8ag3auzASadPQSRjPJ9UqL5zQDK3Nbso=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169522; v=1; x=1787774322;
 b=Z9tfCJMGjwpREsdoPLlMHOJdApeXm85H88IOq7wVh4dmA3nIStFdCOOzOsa6APt46UBKIVMA
 q2+IWdfgZJSMa1kEEwWjWRc2SK4TIo+f6kuzM3RU7dKDcirdRtz9AVdd5MYUIt1iN29qOj1pv1S
 FdwZXrhQLAggbBBN+wmSce80=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 19f693c6b3337f17;
	Wed, 19 Aug 2026 19:58:42 +0000
X-Mizu-Trace-ID: 19f693c6b3337f17
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
Subject: [PATCH v2 01/12] HID: asus: reinitialize the device after exiting a sleep state
Date: Wed, 19 Aug 2026 19:58:24 +0000
Message-ID: <20260819195835.1649657-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819195835.1649657-1-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ec966fc0a411..9ce21fcc7d2e 100644
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
@@ -1379,6 +1401,8 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	asus_initialize_reports(hdev);
+
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
@@ -1493,14 +1517,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
-		}
-	}
+	asus_initialize_reports(hdev);
 
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
-- 
2.47.3

