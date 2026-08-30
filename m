Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C18343D7F
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133408; cv=none; b=Cqya81MXtS8kmQ2WcnFPAMDE5HvxrTIvUa+Z5g/479i1LnFWSdCV29O7sGGHwo/5pCw0NdB/nbW1L5SAJgl8TDcOt7qgzO/m2Z4vJbEjB/pCRDDQY8zvOY/Z8whRauTpC7lp2yp8HPUhOvXfiKAVDqRujVZP2zOHf1zN8xHAjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133408; c=relaxed/simple;
	bh=zLK9ilxnouBl8OfzKtWT4IUHOCTEywTf0m+xYBuIXWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIkNgXDH1gogR808fW6I1o/7Dab74eRqdUuBe4Eyls1sokDYdmcMW1XdMk8F+qoIpmleczvvoHvDOohc7/FeNW59zGKn7OKhc6wz0Wi2iFDafC90drj7qGeuk9BF3DUuqNvPmXTnMLSGVEpnJ2MAgRNsNk7/2vqtDHM5c2IhSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QsNf07/Q; arc=none smtp.client-ip=91.218.175.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QsNf07/Q"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zLK9ilxnouBl8OfzKtWT4IUHOCTEywTf0m+xYBuIXWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788133404; v=1; x=1788738204;
 b=QsNf07/QAo9FFycttjg7kduQvyE9kg+ODF3+savGYpsucHU2qmNG8HJZhQDUv5fq2Dltr5Mj
 j3/FB684IppKKhPGxeNjjIw1M9hfUhCW8HMSAe2pkSq3lRZe7kTADd0UeG14st2W88L08aOPS7g
 JMLdco0Bd/o5Fe9cCeH+Od/I=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0aa1dce65fc93252;
	Sun, 30 Aug 2026 23:43:24 +0000
X-Mizu-Trace-ID: 0aa1dce65fc93252
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
	Panz Dev <panz.development@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/13] HID: asus: do not send keyboard init reports to touchpads
Date: Sun, 30 Aug 2026 23:43:08 +0000
Message-ID: <20260830234320.114356-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830234320.114356-1-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Panz Dev <panz.development@gmail.com>

Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
loop during asus_probe() to send keyboard feature report initializations
(asus_kbd_init) to all ASUS HID devices.

On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
sends invalid feature requests to touchpad hardware, corrupting probe
state and causing the touchpad to become unresponsive.

Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
keyboard feature initialization only runs for actual keyboards.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: Panz Dev <panz.development@gmail.com>
---
 drivers/hid/hid-asus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ec966fc0a411..bd46aba6622a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1493,12 +1493,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!drvdata->tp) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}
 
-- 
2.47.3

