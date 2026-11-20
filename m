Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164064;
	b=5TDxZI4SsAPOpdPLVhkXlxzBbO8SBxA50/70g6e2rbFQRup5K10V5nYPTrITUw5bSAYP
	 4EKYY0LhcrXZXsSlVY8ynKR9Guio27ryGArEzhwwbqUqHqQ2VUce/dsjHQ8JaX5SiYorV
	 zJhzMZD2XMNIRugaqOP/r/XOArmqvHWXti6QVeJPeGaTOaT7m7bVk3yYuI7hg2qZYpxU0
	 eBEV2jeFkv8iFyuPSSc8XNjj/4zfZKhDbxgRmi7aX7/xwpEAlTFNjZuQhw27u1uRH1Jxu
	 xxsj7sjPZT4CEXNUgucOHpvjyGLWth1jl2s1afGG7rDVsw4+p8G7gAT8/huGuld/GBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
	b=mv7uFm6C3Y6SFVLtroDBrfZogt2qrqE2J1/IqAbQ/uTh1f+1QbG3wxbM553RXTQQjENp
	 TxSpT+9jnduC17dlL3OTtOTQS5gvMIMIYNp/ExbTPIKD9W2QzglfwADDVyAFbyy3nFp6S
	 jkvIFFI7KyIQrbFyHZsjixOrcKTGteBXP+PI2Q201orT2fCZww1HKJHfJ5+LUuYPyVWRs
	 dN1Z5ySq7PpDTSqZcmI3dAlc7TJRjUMNuDQQVyuUHyhtCuLq+tuirR91YUa+R7GBKMbNx
	 m0px2pkb/J6dbFvlMQc8G/WghxA3AmpVrmjwCiyVDy96EBsXDtmVfkIzJal3wgBX9dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UVPBQkQu;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944760A380C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8944760A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UVPBQkQu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1ae58d17cd9so656816c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164064; x=1795768864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
        b=UVPBQkQul5d5hGJi9LEsCi4HC1Y8wHc7Q7prFHIIYy/TdiZpZ68ChYJK5k6dR2x3XC
         RlhjqVYuIgxpltaVjXqGnNUbzSFPsDU0H/mF46DFV8hktQPBY91untQx6YI12kry8E8H
         yxUveY4GUAHbQxErgx3q+WCcgwe9U07Hdogzxwy6PHgqfeZo07z4CF3wP24xrB8nOEq0
         ENgNy5B4yyn8UoSRtFfuvy7y+5Z/Jlef4PzcHEYT/Ik2GrH/fZrfdB0cMW/DhS31cDnv
         bY3M5f1fSFKT/ayIeCfxmjpWdMNZhIfz2X3E2YhpqWBkQ2jV68ZQGd/WL8UljTyfDu4H
         eJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164064; x=1795768864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
        b=NJ05IdlZS6xghZUvvxmES7rXG/9AAoV4HZOYsaChxiL4ncjRgkzywr6C+PfnDQc9nu
         oIiNsPVuOVGdRC1HwXVPP2bIs9E0/Uty6s2iwedGrP2x4WR3ZHUk/yXwokIwmhZblL5e
         L+6ncNTPqcnL06e/m9G1g80QqeTWQLQIfsqpyUGO+G7t/Y35340JLPJ5i6zkOQevQm+I
         uQG73J/S7iUW0jstOfdNdNqeO6bXxeRUu0XTp5sBihNjVkHW7hjnFKhhrmGmSm+EG6fh
         0CpXZHXI8LGHEkXpL4UVZSBWF95/sOlebp7UpyAczwUNGGkJnDrtdhX+y2vcNmSd70hT
         CKww==
X-Forwarded-Encrypted: i=1; AL+hErE1YH78hPfub24dqJmj/NDStnbOrJC03Qw5XmFFJHHLzHxHFxRoLLbYabZ6VcK0nTY24sAogh/c/EuGFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8S6b0Q83anXK59IuRkdLlmj4rtLsi8ik5UQVsLFG3/Eu5iZvuf
	GmCY2iKz4BK20Qi5ZjEdsk5JIvfK8I9pgmu1YQofPthzw7VJuECrBX+a
X-Gm-Gg: AYBFou0hAQ9FiuUT8bqphXnlgnPQjJ7bpHaMGT+ms8uQhOABgNbzOyB2cjrYC0zHh2d
	o2dOZLjAB/c2QQOUWPdDFLHOH3/GIQ1kicnl3XRNCsVW1PfAX1qdmqk8IUuZOW1F5QyVqrhuAru
	mpJZgRROO79cT3yXHa8RWaRcMXdBa1RzBUungYDfYuKG/E6OHbbDaOFY6Z+S1FWtHjujU83cug5
	8lNbztLZD4eqM8uWbMzUAlrgo4elSb5YEvY7uWIPgbSfdtdT1uiFhez9sOkixV7q7BgbFu7hnn9
	oIPcfSiKCvcf0Lff7+AIi1J5OJlgnYY/b7bD4MY6heWSRlMqjT871+v90vqu6hmcvfrEYqfg9PO
	dvpZ7X3E1PKoLt6xJ/HLuW73Bn6Zd8x1dORbF8KzQh+yUlvG+LudW8+RqXKjVwaFmFh+MUpt0Ek
	4ECcuzS/ldoGlzjs0zswPs6/4cHNKS4hQoapKra17m01I2A5OXC7Vp42eI9nXewi8XpMcEXlmsZ
	NTDFjGo3f3QXnqIOJh1MLGf0dpVXq4qJnLr6ebNt5RCKUb1hF25eFvwoUHzijMg3peMlgR8SEGk
	WVjFJ/W6w0XANjF5S4Em38hetazbioIsjRIxUnXeYHQsaoM5yKgCrhngKnLB7p9UpeVmaZ0s1rQ
	OT/A9pHSoHC9mGsTi0sWui5cYXcwcGL79PnG+mSQ=
X-Received: by 2002:a05:7022:6985:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b55686d5c1mr2567968c88.10.1795164063592;
        Fri, 20 Nov 2026 00:41:03 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:52 -0800
Subject: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Device removal and the probe error unwind path cancel the connect-event
and hi-res-reset work items only after closing and stopping the HID
transport, leaving in-flight work handlers able to issue HID++ transfers
or register power-supply and input devices while transport teardown is
underway. Moving cancel_work_sync() ahead of transport shutdown is not
sufficient because incoming reports remain active until the transport
stops and can re-schedule the work items before hid_hw_stop() completes.

Disable both work items synchronously before closing or stopping the
HID transport on device removal and on the post-I/O probe failure path,
and drop the unreachable cancellations from early transport start and
open failure paths where incoming packets have not been enabled yet.

On device removal where HID core enters with device I/O stopped and
driver_input_lock held, temporarily re-enable device I/O to flush
pending work handlers and disconnect input devices before stopping the
transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
reports can still wake synchronous commands without dispatching events
to the disconnecting input device.

Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d5f53b35ac6f..0e1a9fd98faf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 hid_hw_init_fail:
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
@@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	bool claimed_input;
 
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
+	hdev->claimed &= ~HID_CLAIMED_INPUT;
+	if (claimed_input)
+		hidpp->input = NULL;
+
+	hid_device_io_start(hdev);
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
+	if (claimed_input)
+		hidinput_disconnect(hdev);
+	hid_device_io_stop(hdev);
+
 	hid_hw_stop(hdev);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 }
 

-- 
2.56.1.750.gf70dc682cf-goog

