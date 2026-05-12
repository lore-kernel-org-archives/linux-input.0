Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBE30674C;
	Tue, 12 May 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595826; cv=none; b=LMoz01UgiXZm5ExRquD4Kx42fbT1C9z5KMLIk44lwhYpZqWn9ULnffhaXt12FvKdNrzEZvC1jdhUfIPXtjOXSFEoaHzfk8KN+mhJ0NYba9yyKXBJkZuciBd+F9CBdOin1/ch9RkFXC06IvPKLLkKKlFOMlK0Nu1NHxDTLbez32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595826; c=relaxed/simple;
	bh=y8mAbnfihQlbn5KIg2BP/pMGPicJRvRywvyZkkl/7gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEbE9b/zEFQ6rCXwNztCuT7qt1aN51Q+1W3sLcn+/5qbFCGUed5/f5GVhZuACCyznpYzXxaJvXGUMTLC1vVy5fY0rFy8h82dPEskZFfreYMNtKvfDuCAUyc5dnJW/HJrZf0F3z9Bm1IdiHzhwqbZNoKA1cd98Z0oYTH6VjPo90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nRuctoCq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nRuctoCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DL
	u5/4I32U0g3yDdgFjqxLbxkDhEBZD8jR1ow/3kSZM=; b=nRuctoCqivuWkS64ey
	j6SY39o5ytQjijZL4EHakoR1cxOUmmhYcBT2wJkfxA9vH5Nlzw5KD5U7CCDuuqkF
	SLvFYjgHpsOcICXPhOoTviu6k/bWLbsOuSSd30S6SuHlycdFl7sANXJNJmPMQCn/
	5bYpYQqxfB4k78tp7Cx4dwjaQ=
Received: from debian (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnr6PDNwNqKznVAw--.15816S2;
	Tue, 12 May 2026 22:22:59 +0800 (CST)
From: Kean <rh_king@163.com>
To: derekjohn.clark@gmail.com,
	mpearson-lenovo@squebb.ca
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kean <rh_king@163.com>
Subject: [PATCH] HID: lenovo: Restore Fn-lock LED state on resume for tp10ubkbd devices
Date: Tue, 12 May 2026 22:22:29 +0800
Message-ID: <20260512142229.4098386-1-rh_king@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr6PDNwNqKznVAw--.15816S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UAr13tFWDKrWfXrW8WFg_yoW8Ar4rpF
	1UXF4FvFZFgw17Cr4Svw4v9a45AayrJr4xurW3K3Z29as3tryDJrW2ya1Yyr15tFykJryf
	WF4UJrWUWFWktwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKjg2gUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC4ANZCGoDN8MIoQAA3G

The reset_resume callback only restores trackpoint settings for compact
USB keyboards (CUSBKBD, TPIIUSBKBD) but omits the tp10ubkbd device
family: X12_TAB, X12_TAB2, TP10UBKBD, X1_TAB, X1_TAB2, X1_TAB3.

If these devices lose power during suspend, the Fn-lock state reverts
to the hardware default but the driver's cached state and the keyboard
LED are not restored, causing the LED to show the wrong state after
resume.

Add the missing device cases to restore the Fn-lock LED on resume.

Tested:
This patch works on ThinkPad X12_TAB.

Signed-off-by: Kean <rh_king@163.com>
---
 drivers/hid/hid-lenovo.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a6b73e03c16b..4c9fb163b6d6 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1424,6 +1424,8 @@ static int lenovo_probe(struct hid_device *hdev,
 
 static int lenovo_reset_resume(struct hid_device *hdev)
 {
+	struct lenovo_drvdata *data;
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
 	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
@@ -1431,6 +1433,17 @@ static int lenovo_reset_resume(struct hid_device *hdev)
 			lenovo_features_set_cptkbd(hdev);
 
 		break;
+	case USB_DEVICE_ID_LENOVO_X12_TAB:
+	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
+	case USB_DEVICE_ID_LENOVO_X1_TAB:
+	case USB_DEVICE_ID_LENOVO_X1_TAB2:
+	case USB_DEVICE_ID_LENOVO_X1_TAB3:
+		data = hid_get_drvdata(hdev);
+		if (data)
+			lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED,
+						 data->fn_lock ? LED_ON : LED_OFF);
+		break;
 	default:
 		break;
 	}
-- 
2.53.0

