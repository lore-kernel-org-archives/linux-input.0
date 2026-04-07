Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A832F12A5
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775536841; cv=none; b=b18/DXSJ+B66fPsJKtYKH18oXI0TVm/BlECyi74ay6FfqfDNpJcZHuCg9jFFn/Lcm7eB+hcAepvR3vHlxONgNfP/2fBv/a+D/ZdlUw4RgDFbKKsaZiGk0ok1/AyOzPcEu82RV3rMK1RYz4zB7wqMMoAfMxGhSTW5JNyhkpb+tmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775536841; c=relaxed/simple;
	bh=FOF0neFWWaaLfQSnlZbS1uzOwUueuXmwO7/YHCtS1CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAjCiSRrxryi98IHbCBNgWL1J9g0UqiaYNfyBH1JC9FjtdevOKg50R3rjkbD45NrKHjOUQmE1yBKbZPRnP+tvNtDQv2UgTnIxWw0M0SuJZ6kKSyV4R9MP2jrRSEtZh2DbL91DRen+tdzL/pTbePKjNZvugSJq0aXMFR3Fj8FX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdSZ3E5q; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdSZ3E5q"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c54c68db4dso9168699eec.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775536839; x=1776141639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LeF1/BYPCTI6YZHbck6xE/ER6OHXIciv5zbHjd6JPw=;
        b=SdSZ3E5qsFYZncQL08HKotjbbKW/7sPWjdKTuFErHNLxhpnFj8P+4Ipe0xK7jPLF4K
         OPLDAY4FlxKi0sCCjztrNQV5iA+2VfftIGNZOISltIEqQv0xPRxpEbFWNetFRXsqhmEJ
         K80jAS9iM5WQg7sH+fuBwwjLznBGaxDglMUR86UaZK/1svErl/BSbXY2TOrw6zLA/Lyv
         ifTFuRtur1oBo93kMH3nZR6jzfkFvOe3D6qrLNrN+sgoJ7QZ5lxTGBxnAM6olyQFmkVT
         RR8scOKwR9FIBdQ1+gE8d0yw7EgmEvxbXIM5ftPCkMtK/O0A+Dza2lbHicCmnZVADpq4
         91ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775536839; x=1776141639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LeF1/BYPCTI6YZHbck6xE/ER6OHXIciv5zbHjd6JPw=;
        b=FvCygyx8v+G9+Mwosr9UPxGSl0c89P0n9tILfzH6lsTo8Izh7Iyl5Dw+X+AlE+oafi
         bIr+ljCgAFfrOgFBW1lxb2urKM+jGfhrH41SiLBo2tFMYJpxxPt4uJqI/EN991wrZpB8
         mlvvSQrCQjlT3HZeqf6Me1yffYl78XiK05FNRUk4qNbh/kRutaxxPDZdUiSD+7r5l19p
         ogRmiaBFS0y6ztNa82JCxG8rrXMkz0j4jLQZHyNXYd/47ba21qeXNUiPmA/RBcXU8hNS
         xcJIsIWb6m3dmosFGjtln7IBWw8onjE+7BvjoQYFNPTN0OFP/XkvEElEYTSLKJ4rO4hZ
         0BFQ==
X-Gm-Message-State: AOJu0Yw+uT14vTOuooIBlV2kPEubA+hYp/nmpAr2/Erx4Tg5R93WekTd
	LONApdGHzZ9/4JRKP5f/wlgzwiqH6rNn9q52B/Be2s3aRR8Lscd/bdNY
X-Gm-Gg: AeBDiesQfUlOulXOM6Wpp2wcBTw7oXy/wpfUltQ5uRsL3bDDHpJPSAZgkFoZZ/s9SRx
	afpiKl1J5sgTuSdN7MaDH0NhSLubTAuG0aqne2Jo2XUMXNqHptXn1Z2gx32OErtZOUkGSIn0maw
	5G5S1/sjwgZLyy+x7/JqTqCCpmbbNrKiROow8aNZKZdJWcqD3eA3DmuIEg3RNr91oC8aNuKYHKd
	vpbQi5lA/luncquJtDMQWcZdBLeMb/2Y/+bg0DUzd+T7GRIRfXW5thEuJ384HXawjRyCCUlzK2H
	oWOilY/IT3QE+anIEGpHgG949+Pj7MCje8lU2iJrntbVzF7foTJJsDljxgdpNiMIBIzudiEMgDz
	2La2RexirlXWibUImIXsqGKnMuLX0AQRwQhUOHj0M6R06czzVWRypSWNdgKmrC1Z5hABl6NXgtI
	BdRaz006cpitIQaoXv047CyNO5PdI02dcled+0d5Lrts0=
X-Received: by 2002:a05:7300:b906:b0:2c1:59ea:10f7 with SMTP id 5a478bee46e88-2cbfbf79640mr8083990eec.18.1775536838523;
        Mon, 06 Apr 2026 21:40:38 -0700 (PDT)
Received: from halfdart.localdomain ([208.64.186.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba5df5c24sm13293165eec.27.2026.04.06.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:40:36 -0700 (PDT)
From: Aaron Webster <awebster@gmail.com>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Webster <awebster@gmail.com>
Subject: [PATCH] HID: playstation: Add DualSense Edge extra button support
Date: Mon,  6 Apr 2026 21:40:08 -0700
Message-ID: <20260407044008.40222-1-awebster@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DualSense Edge controller (product ID 0x0df2) has four additional
buttons compared to the standard DualSense: two front function buttons
(Fn1 and Fn2) and two rear paddles (left and right). These are reported
in bits 4-7 of buttons[2] in the input report.

Map them to BTN_TRIGGER_HAPPY1 through BTN_TRIGGER_HAPPY4 so that
userspace applications can use these extra inputs. An is_edge flag
gates the extra button handling based on the product ID.

Signed-off-by: Aaron Webster <awebster@gmail.com>
---
Tested with a DualSense Edge controller (Hardware: 1000208, Firmware:
1000087 type 3, Fw version: 20 131082 6, Sw series: 68, Update version:
0213, build date Jul 4 2025) on Debian 13 (trixie) with kernel
6.12.74+deb13+1-amd64 (x86_64) via Bluetooth.

 drivers/hid/hid-playstation.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 3c0db8f93..962159239 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -112,6 +112,12 @@ struct ps_led_info {
 #define DS_BUTTONS2_TOUCHPAD	BIT(1)
 #define DS_BUTTONS2_MIC_MUTE	BIT(2)
 
+/* DualSense Edge extra buttons in buttons[2], bits 4-7. */
+#define DS_EDGE_BUTTONS_FN1		BIT(4)
+#define DS_EDGE_BUTTONS_FN2		BIT(5)
+#define DS_EDGE_BUTTONS_LEFT_PADDLE	BIT(6)
+#define DS_EDGE_BUTTONS_RIGHT_PADDLE	BIT(7)
+
 /* Status fields of DualSense input report. */
 #define DS_STATUS0_BATTERY_CAPACITY		GENMASK(3, 0)
 #define DS_STATUS0_CHARGING			GENMASK(7, 4)
@@ -178,6 +184,9 @@ struct dualsense {
 	struct input_dev *touchpad;
 	struct input_dev *jack;
 
+	/* True if this is a DualSense Edge (product 0x0df2). */
+	bool is_edge;
+
 	/* Update version is used as a feature/capability version. */
 	u16 update_version;
 
@@ -1486,6 +1495,18 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 	input_report_key(ds->gamepad, BTN_THUMBL, ds_report->buttons[1] & DS_BUTTONS1_L3);
 	input_report_key(ds->gamepad, BTN_THUMBR, ds_report->buttons[1] & DS_BUTTONS1_R3);
 	input_report_key(ds->gamepad, BTN_MODE,   ds_report->buttons[2] & DS_BUTTONS2_PS_HOME);
+
+	if (ds->is_edge) {
+		input_report_key(ds->gamepad, BTN_TRIGGER_HAPPY1,
+				 ds_report->buttons[2] & DS_EDGE_BUTTONS_FN1);
+		input_report_key(ds->gamepad, BTN_TRIGGER_HAPPY2,
+				 ds_report->buttons[2] & DS_EDGE_BUTTONS_FN2);
+		input_report_key(ds->gamepad, BTN_TRIGGER_HAPPY3,
+				 ds_report->buttons[2] & DS_EDGE_BUTTONS_LEFT_PADDLE);
+		input_report_key(ds->gamepad, BTN_TRIGGER_HAPPY4,
+				 ds_report->buttons[2] & DS_EDGE_BUTTONS_RIGHT_PADDLE);
+	}
+
 	input_sync(ds->gamepad);
 
 	/*
@@ -1785,6 +1806,7 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
 		ds->use_vibration_v2 = ds->update_version >= DS_FEATURE_VERSION(2, 21);
 	} else if (hdev->product == USB_DEVICE_ID_SONY_PS5_CONTROLLER_2) {
 		ds->use_vibration_v2 = true;
+		ds->is_edge = true;
 	}
 
 	ret = ps_devices_list_add(ps_dev);
@@ -1802,6 +1824,15 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
 		ret = PTR_ERR(ds->gamepad);
 		goto err;
 	}
+
+	/* Register DualSense Edge back paddle and Fn buttons. */
+	if (ds->is_edge) {
+		input_set_capability(ds->gamepad, EV_KEY, BTN_TRIGGER_HAPPY1);
+		input_set_capability(ds->gamepad, EV_KEY, BTN_TRIGGER_HAPPY2);
+		input_set_capability(ds->gamepad, EV_KEY, BTN_TRIGGER_HAPPY3);
+		input_set_capability(ds->gamepad, EV_KEY, BTN_TRIGGER_HAPPY4);
+	}
+
 	/* Use gamepad input device name as primary device name for e.g. LEDs */
 	ps_dev->input_dev_name = dev_name(&ds->gamepad->dev);
 
-- 
2.47.3

