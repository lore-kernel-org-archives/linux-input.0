Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8733BBAF
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632463; cv=none; b=mmUKtPllN4p/W0a4JET2iWysZ7qPn164osaxVjh9IgiwG6kjvyPS1EtkmQaiAb0wo+0PrPd9J6+MF5yVZjhoYA9TvqvyTB6nzbJtziOU9CL2sjGrCweJK8/zlhQYkaEiNE3U9huOfhEOvxts+jIihVDUeI7TsSJuBxyUQH/OcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632463; c=relaxed/simple;
	bh=y3eIEBF5EK5TQFhn1BUwspWnzp/b9sqp424+AgORn+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOzuFLKFbG3Zj8ysp3FWO7oJEoX0kpUqC3PNkhSypG0vqYxWUqOlRnRHM3cQZ20xMkLUPOfnJecxQXFNW1xO2SAT/A7Tw51xtvK6YdMrmIOjuM2CqRWqVWETetOuFXkIk7kpQ301U8dLpXkVnxcy0N+/scITIPP2kBPcNfdjwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rnMjt7eU; arc=none smtp.client-ip=95.215.58.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rnMjt7eU"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y3eIEBF5EK5TQFhn1BUwspWnzp/b9sqp424+AgORn+c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632459; v=1; x=1787237259;
 b=rnMjt7eUS4iXOI96TmruVqt38zPC1q9pKNWF4y5o8rSo9l8WZwgVtu28z1/zxPjAygex4HDN
 sxBXT1bvyQnWPDVn0uLb2l3BFhTd/i641xGCZSF5+1zj/5+mcMq/IDM9VJCKru6gL5hm70NOHaZ
 0C7Cy9uiARLDkKFA+QPukuZs=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 080fa5f0f35b4450;
	Thu, 13 Aug 2026 14:47:39 +0000
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
Subject: [PATCH 01/12] HID: asus: reinitialize the device after exiting a sleep state
Date: Thu, 13 Aug 2026 14:47:25 +0000
Message-ID: <20260813144736.2477941-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
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

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ec966fc0a411..897b04d06b46 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1360,6 +1360,22 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int asus_initialize_reports(struct hid_device *hdev)
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
+
+	return 0;
+}
+
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1378,11 +1394,20 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+
+	ret = asus_initialize_reports(hdev);
+	if (ret) {
+		hid_err(hdev, "Asus initialize reports failed: %d\n", ret);
+		goto asus_reset_resume_err;
+	}
 
 	if (drvdata->tp)
 		return asus_start_multitouch(hdev);
 
 	return 0;
+asus_reset_resume_err:
+	return ret;
 }
 
 static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
@@ -1493,13 +1518,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
-		}
+	ret = asus_initialize_reports(hdev);
+	if (ret) {
+		hid_err(hdev, "Asus initialize reports failed: %d\n", ret);
+		goto err_stop_hw;
 	}
 
 	/* Laptops keyboard backlight is always at 0x5a */
-- 
2.47.3

