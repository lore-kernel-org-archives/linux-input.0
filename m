Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EC25DB0D
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727742; cv=none; b=T8VBSFVHV/vZRE3YFvNfCLE6PK+1bGf5mV+773C6yn0yIDwTex2rEDewGCVu/vmbkFT8ZlrTw9S9g6QGabYPu7CyVLcwJwmQXeaXHoDWHdN6nPvEgeXim5s5nUbyUnHakleCtL5VPS+B6CmMQ1wyKyfpsZOoXgTM9aRRpD3amhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727742; c=relaxed/simple;
	bh=RS3ADzVfxL8qqGmpxz4abkEC5P9mt7MTpddiH2NP6KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xij34kWVk42zAXPw3mrf/6YeHOnoxF3Du7TJF9UxblCIOKdJ1VpDgPof338fhtajfqzzC761MNTxIptm1SIq+gYmGc2icGnSNW/h0M8EvoaoF+5KVvWVIfEjB9JgDRie8mRcLSDIXB4u6R7uu43GiMMhQlTEctIiv/IFcOdO1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K58U5GhN; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K58U5GhN"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so1728173a91.3
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727739; x=1791332539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CfCX2ufsEicMArdWfEJGMSdcRPfc57DekObWO7Y+3J0=;
        b=K58U5GhNGfnTm7QtEqNrNPJG8XBAuknpOsqxO1wc6OgktYIGPkMtt8oh4BzG+yTsBQ
         sIg/x0YJp7ZUzWsCz4bnKuVqxeYkXckOejjWqYZiiu6Xwjyw8KhhqQzmjjYm0enAKcgc
         rHxbrpFTC/AvL7mFlq5dstGWjsKIXCwgugX8JNowdgdz3JoU1LWjhDaVo3A+V+GibmAX
         s4ia44m1AjTXZdoJ+xTRoXb0ZAP1zuNV6/zW0bW2IErewaJsAxxo7Djaxnf1T1SLAdB7
         tKSVLUby8UHXYB3a0W26teomcDe1LisR/qeI1trTAp5Ez4EIaUxRs0eryowzsEC6VTcd
         EPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727739; x=1791332539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfCX2ufsEicMArdWfEJGMSdcRPfc57DekObWO7Y+3J0=;
        b=oF9YXHwm/mKU9qqfin0MFknGIGSSJLX8ivbQre+XE0lswbb2dTZqGjBCdkBOPY4Z2W
         hehTOFCIKQam7k9Ai1e8TJTAOmTtUDEtXb/iEsiYYzZivI+giCsFfbO9JIzR3EDJ/03o
         SKx1yZjezmgqhJkZ49l/TRO1XEs2tMxtKK7YmyZRC4OT5kIHMg+Y74IXhH6A5vm9Y1xJ
         xLFVzVQAkXQ622PuhGEzdgxSQdju0l39ybFTfAfoBldnh268K3yR0fBW67bXK5IdreDZ
         iLwJqyEJuPtLp/mh1bIB+WT2uUISJh6jFFi4+XBTr9VXygpI3HKVt4KbhSRkxGaNE8ie
         0ZFA==
X-Gm-Message-State: AFq9FYIEpejsG3AUiuEAbKF3YsEeC1EvkCqFbJlsZxsomjqmMQ8Yr/sv
	mtV9frZpGB1uLgEpJe2lu/zJqozCW1cBegU44XYx9zVhWp+NI+Np/hi5
X-Gm-Gg: AYBFou3w1oVBstdC2UjWBe82SQnEuAifvjrW/PklmEFxHOB+znlWIW6bxhmzx2TY4A+
	CdjeilNt9tSMyeqfhP1PZtAuplePjjx/kp4K99OeK7isEsx95i0DpQrBZXiOmIBVhK9bgJFyp5g
	7uuKUjpwXPdK4KuW2nJm2QIeyZD4SgGOdKLM3FPGcAkmddiyWYMsht1iOY3l9o/Ty0RBI5yRob/
	9szbHiiVgXj93T9eJOzeaonlQ1Oc/MIhZTZs1X9FCeJaOpJSekJd+X0Re7qkCWN2JCT+EX0Zztf
	hcCoDyCMzZ4hSDOOUbK1Pa3YCMgRVwJWNYU9rk2+kKFLduRw0vVba71/b77/6ZvW1XUcFlX/uVB
	ZHzf+KZFQhtdRuv5SAFKojfoAkAly/nJdWL27Z2HWIU9D4yaDcfsOXsdbrDEhnsNawUJ2foWNjv
	gfnPjOw5fcfAl9bkxhWiXfsRXfxPTJXVLTVnlbDkA4nnEIbnsEH8JBIW+MfEuW8bK0
X-Received: by 2002:a17:90b:4a4e:b0:39e:237c:50e0 with SMTP id 98e67ed59e1d1-3a4bfdebb0amr783292a91.13.1790727738878;
        Tue, 29 Sep 2026 17:22:18 -0700 (PDT)
Received: from fedora ([2400:2410:5f2b:700:6bda:eb8:32f0:3372])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c7632de2sm242073a91.4.2026.09.29.17.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:22:18 -0700 (PDT)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson@squebb.ca>
Subject: [PATCH] HID: lenovo: add fn+F7 display switch support for X12 and X13 Folio
Date: Wed, 30 Sep 2026 09:21:33 +0900
Message-ID: <20260930002133.10794-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ThinkPad X12 and X13 detachable keyboards FN+F7 reports the Super+P
key chord, which behaves differently from FN+F7 on other Thinkpads.
In particular giving a shorter on screen display time making it harder
for users to select their preferred display mode.

Newer keyboard FW is now available, allowing the keyboard to be
configured by the OS to provide the standard FN+F7 KEY_SWITCHVIDEOMODE
code as used on other Thinkpads.

Detect if the capability is present and enables the mode if available
on initial probe and resume.

Suggested-by: Mark Pearson <mpearson@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/hid/hid-lenovo.c | 71 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 3976d7b53b14..6b4b689c8834 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -44,6 +44,7 @@
 #define TP_X12_RAW_HOTKEY_FN_F10	0x00000803
 #define TP_X12_RAW_HOTKEY_FN_F12	0x00000403
 #define TP_X12_RAW_HOTKEY_FN_SPACE	0x18001003
+#define TP_X12_RAW_HOTKEY_FN_F7		0x00000815
 
 struct lenovo_drvdata {
 	u8 led_report[3]; /* Must be first for proper alignment */
@@ -557,6 +558,34 @@ static int lenovo_send_cmd_cptkbd(struct hid_device *hdev,
 	return ret < 0 ? ret : 0; /* BT returns 0, USB returns sizeof(buf) */
 }
 
+/* X12/X13 folio Fn+F7 reporting mode: feature report 0xa4, [id, mode]. */
+#define TP_X12_FEATURE_HOTKEY_MODE	0xa4
+#define TP_X12_MODE_DEDICATED_HOTKEY	0x01
+
+/*
+ * Select how the X12/X13 detachable folio reports Fn+F7 (display switch):
+ * a dedicated vendor hotkey (report ID 0x15) instead of the default
+ * Super+P key chords.
+ */
+static int lenovo_send_hotkey_mode_tp10ubkbd(struct hid_device *hdev, u8 mode)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = kzalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = TP_X12_FEATURE_HOTKEY_MODE;
+	buf[1] = mode;
+
+	ret = hid_hw_raw_request(hdev, TP_X12_FEATURE_HOTKEY_MODE, buf, 2,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(buf);
+	return ret < 0 ? ret : 0;
+}
+
 static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 {
 	int ret;
@@ -739,6 +768,10 @@ static int lenovo_raw_event_TP_X12_tab(struct hid_device *hdev, u32 raw_data)
 		case TP_X12_RAW_HOTKEY_FN_F4:
 			report_key_event(input, LENOVO_KEY_MICMUTE);
 			return 1;
+		case TP_X12_RAW_HOTKEY_FN_F7:
+			/* Fn-F7: switch/extend external display */
+			report_key_event(input, KEY_SWITCHVIDEOMODE);
+			return 1;
 		/* Power-mode or Airplane mode will be called based on the device*/
 		case TP_X12_RAW_HOTKEY_FN_F8:
 			/*
@@ -794,11 +827,22 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	 * Lenovo TP X12 Tab KBD's Fn+XX is HID raw data defined. Report ID is 0x03
 	 * e.g.: Raw data received for MIC mute is 0x00020003.
 	 */
-	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB ||
-		      hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2 ||
-		      hdev->product == USB_DEVICE_ID_LENOVO_X13_TAB) &&
-		      size >= 4 && report->id == 0x03))
-		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
+	if (unlikely(hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB ||
+		     hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2 ||
+		     hdev->product == USB_DEVICE_ID_LENOVO_X13_TAB)) {
+		/* Existing 0x03 vendor hotkeys (8-byte). */
+		if (size >= 4 && report->id == 0x03)
+			return lenovo_raw_event_TP_X12_tab(hdev,
+				get_unaligned_le32(data));
+
+		/* Dedicated-mode display-switch (F7): 3-byte 0x15 report. */
+		if (report->id == 0x15 && size >= 3) {
+			u8 pad[4] = { data[0], data[1], data[2], 0 };
+
+			return lenovo_raw_event_TP_X12_tab(hdev,
+					get_unaligned_le32(pad));
+		}
+	}
 
 	return 0;
 }
@@ -1366,6 +1410,12 @@ static int lenovo_probe_tp10ubkbd(struct hid_device *hdev)
 
 	lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, data->fn_lock);
 
+	if (hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB ||
+	    hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2 ||
+	    hdev->product == USB_DEVICE_ID_LENOVO_X13_TAB)
+		lenovo_send_hotkey_mode_tp10ubkbd(hdev,
+						  TP_X12_MODE_DEDICATED_HOTKEY);
+
 	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tp10ubkbd);
 	if (ret)
 		return ret;
@@ -1439,6 +1489,13 @@ static int lenovo_reset_resume(struct hid_device *hdev)
 			lenovo_features_set_cptkbd(hdev);
 
 		break;
+	case USB_DEVICE_ID_LENOVO_X12_TAB:
+	case USB_DEVICE_ID_LENOVO_X12_TAB2:
+	case USB_DEVICE_ID_LENOVO_X13_TAB:
+		lenovo_send_hotkey_mode_tp10ubkbd(hdev,
+						  TP_X12_MODE_DEDICATED_HOTKEY);
+		break;
+
 	default:
 		break;
 	}
@@ -1526,9 +1583,13 @@ static int lenovo_input_configured(struct hid_device *hdev,
 						hi->input->propbit);
 			}
 			break;
+		case USB_DEVICE_ID_LENOVO_X12_TAB:
+			input_set_capability(hi->input, EV_KEY, KEY_SWITCHVIDEOMODE);
+			break;
 		case USB_DEVICE_ID_LENOVO_X12_TAB2:
 		case USB_DEVICE_ID_LENOVO_X13_TAB:
 			input_set_capability(hi->input, EV_KEY, KEY_PERFORMANCE);
+			input_set_capability(hi->input, EV_KEY, KEY_SWITCHVIDEOMODE);
 			break;
 	}
 
-- 
2.55.0

