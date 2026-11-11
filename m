Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380239;
	b=27N5u8MDdzLU6FLdLwi5LOpUUx9wfzVGeQj0YBTidLP+VWKYMYsU+N40cQ4hRh3/0PNc
	 b5RS+op/XPZ8/GVFrhhhsh+wRzVBT2aVdQceNeaaz/juCnI6y71ce/ftnUcdD2FGjc0wh
	 FhiQWFJbK3izJEIq2KsQLlvUsy9PpwVyeYHwXZu01I4TBX1jw2SNVPclVOeY6Tkd3SgBD
	 u4GwF78Fo1Mq+cKVGxflHlx7xorUgZvPFQujZ1wwgBBO77EUTYHkczki/PQj/2QcAoElC
	 Umcl8dGP1rgsVZWpBEh/1UwoApgH222HN2gyU5edRg/n04MyEvFjNauW8OLCKQRwFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=LLae+NccOKaXCuAT/8LHfaWjJP6dfSgFnTHThUpT/B8=;
	b=X5Uu30BeGBwqhT+FzTzYTsoLlDTv4vQ3/F/kZ1h9t/eqmhJTZoXFXrPWB8oTE9p3svDD
	 EjI2hcvog5UpdWH8jVIA9Ndp/Cnkrh4W2rlmMTf34Hm4C4iv98kON/ugYVVI0WG247bGR
	 AUlxtq+fqLSxIdMciChUb21FsuCkbHi1fpQbwMvniQOYNWtPZQ3jB3J4N8rlKHKE3fm+R
	 1d3TcNldY4j/bmJnUrpAjYNSgyi9PSCT1DdbVbvicIdh07JLDsLc94pswhLfXBubgb32o
	 xIGKKpSDzJ1moWWYn2avdlErBP515ZH4PSlgABeIcMrzDceMV0dbDZaVyK3y6aaR7Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=veJztS+t;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84199606EDA1
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84199606EDA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=veJztS+t
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so374364c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380239; x=1794985039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLae+NccOKaXCuAT/8LHfaWjJP6dfSgFnTHThUpT/B8=;
        b=veJztS+tdKLJJJcjvy4KYbcS8XvcVBC0hP7hKvJVmO7pm+vsce8nBQspOqU0zpnHJJ
         ZFv6RsfpP4253EPQnk71pwdbUK7Y1qS7IKS1A9kw6SNsAp6xWqw8ddIc6TM49fN1DHvP
         7ZSGWHajWbq9M4/6uxTDHDYSptWBC/VbShPaYB7/Cny1JY+Ki7Ck1IpgQWmXnyMt1zeE
         KfNuohp2pRtSxRjhy0I/y7g1ltb12N9jj+qCsn8wzEwIY48kjNtcuA8l5sQJVU1hSge8
         /EGWkMD/z3tHGnJXbj0gm3cvEUVGuBwYCFLD414W5jo3ZFqry5z8Bb5xGY4ZsLkLbegK
         MUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380239; x=1794985039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLae+NccOKaXCuAT/8LHfaWjJP6dfSgFnTHThUpT/B8=;
        b=IzIqpE6MknRwvGOpteqo5zb3wBY5RKeP0BnkV8e3md22cTPivhIqsVjH53H0DyNL7A
         DC5XmlD3a+W+yAgHXWDR8KMzyCVj39VHzFegATtpT0ZB+xHUnaKR0DYs/Ui50yaQDHWk
         3Y2Ze7oEFJP268onMMU7LU4LPWo3tf+PusEU6iJDjy1nFTx51zX84gzAntxfsss8A5gk
         3mGiPQt3CEg85ahQ7v212DWNME1SnuKHehCJrqN29wn3oRy9QlWSTLMngNm5HpuZmifX
         4qAecDTeClG2BSNI2czsm3i1hVG0K/1erA9vECtjZgGdb5wA7R53Aod15NXEiWrvhHzV
         6FLw==
X-Forwarded-Encrypted: i=1; AL+hErH20IPUEszPGPAhJRm4QWZR87gcY+PHQhbcs04cyIxT0QxENQ+EkqYuX1MEc+Inp2KJdItaf/Ts1uiJww==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xqP4ZpPMrhrMwyGtDWuW+VfKpOkG3XjH0Rz3cAZYMjgqVxlJu
	39yuLXRQvaRmx0277LxUDIgX+7Ws4N7Kxzdp3lcinQ/q0n3CllnntomyHv6THA==
X-Gm-Gg: AYBFou0C+mxMndpulX8b+hfKXWbJflYBqEo3UHrp0uju/vADJ8cnJ2+3XFymq+7a2X7
	Y20SdmO3HwMJoBkgwZvopbItwTFy9CQXEbArHCaX0m5inkVbUlQW9Rfr+Ch4SSS3lJmbjDN3PgT
	Ybss8FiI5Z/opktaK3beo2NYyW04Vw7sA0S2dU8yKQDWFEXFqR5qhvjVJb6dmerC7mbn+VfRxil
	7/lcBpaRCWlrQE/EgLwt728RUdq5PP+K/Xm11q9rCIrFntRzKYWDBbpzoalnv9kf+bZeTt3xp9s
	g4aA/wZXxxnecTZfnWpLXztVo/T2RrAEbxekKavUBPmYOiVvl/gm+4rUwhbUvvR/eZGLJrCz/De
	ZvhmzXbj5BqlAb0uFCgoFmIAXycyY+5Obao6uPNwCyyIb/dTOWDVPC/HpmzE0DxAQsiaWvasR0I
	ts78puIyJO8DQdje+F9cwGZGg1AwbH+mjDgYbi6j3kC3Y2fba5Z287FIriri+LlxS8KovPnkjlI
	y5HZiUYi/653Oz4+ZQWK6tgsvECjjYMfDNTLfxDahqKMk3/8qKy/bppRcT2XbTNXH8BFPINeJAx
	6AWHuWuqxS+vUNZsEGDQsInohSJQ6vKlqkBLFmylCOfDBJaqVazmrJ6e/cTO2T7UR33LKUV3oTh
	jtubR+UcbbnSxyu7p/g==
X-Received: by 2002:a05:7022:e21:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1b3c02f09e4mr2248938c88.12.1794380238611;
        Tue, 10 Nov 2026 22:57:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:17 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:31 -0800
Subject: [PATCH v2 33/33] HID: logitech-hidpp: remove unused kfifo and
 clean up minor helpers
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
Message-Id: <20261110-hid-logitech-hidpp-v2-33-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Remove unused linux/kfifo.h header inclusion and the unused
delayed_work_fifo field from struct hidpp_device. Also drop the unused
finger_count and button_feature_index fields from struct wtp_data.

Drop the redundant input dev.parent assignment in hidpp_allocate_input()
which is already performed by devm_input_allocate_device(). Also drop
the stale ret format specifier in the hidpp_connect_event() input device
allocation failure log message.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 019b917c3b90..6529c7b10b8f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/kfifo.h>
 #include <linux/input/mt.h>
 #include <linux/workqueue.h>
 #include <linux/atomic.h>
@@ -198,7 +197,6 @@ struct hidpp_device {
 
 	struct work_struct work;
 	struct work_struct reset_hi_res_work;
-	struct kfifo delayed_work_fifo;
 	struct input_dev *delayed_input;
 
 	unsigned long quirks;
@@ -2847,9 +2845,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 
 struct wtp_data {
 	u16 x_size, y_size;
-	u8 finger_count;
 	u8 mt_feature_index;
-	u8 button_feature_index;
 	u8 maxcontacts;
 	bool flip_y;
 	unsigned int resolution;
@@ -4360,7 +4356,6 @@ static struct input_dev *hidpp_allocate_input(struct hid_device *hdev)
 	input_dev->id.vendor  = hdev->vendor;
 	input_dev->id.product = hdev->product;
 	input_dev->id.version = hdev->version;
-	input_dev->dev.parent = &hdev->dev;
 
 	return input_dev;
 }
@@ -4474,7 +4469,7 @@ static void hidpp_connect_event(struct work_struct *work)
 
 	input = hidpp_allocate_input(hdev);
 	if (!input) {
-		hid_err(hdev, "cannot allocate new input device: %d\n", ret);
+		hid_err(hdev, "cannot allocate new input device\n");
 		return;
 	}
 

-- 
2.56.0.542.g3ef89b7020-goog

