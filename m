Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989195;
	b=xRE7W7Wh/IQY4gI7NU+7c35dHb3qCvuXT1KGp+zoeBpHaFSPiJ0gs5l4CnMT2tfYzyrF
	 9xAtC3pkVNEXats3Mx03l7ea88q1N4NPoKI4KVfNudsCanKUE5EiA/OKKbn2SviRseVtV
	 ueVvv5ooHlVjBsiw18dwxEyt/0GrH3mAP8NFzcSadURcSYXQJKGvUU6G0J4aHP/J9B81K
	 4xAzEoF1Ht302gMwmpEGA3WtQ0ws0FuaBCAi/KrygC/HmgF09PQgppui1NlEa3JmMybwF
	 zKoNq2lpIlnofFnukSIDRbu8kgcEoYy9PJi42zHZutS+6VA22HRyCcGjMQnXlsC4VkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
	b=w/7S1YKw3hq7ioMFW9X7s0idWDWZxnqBMXACuWzXT7V5MHFLnUQ8qiEr6EpSBIe3IKrT
	 ps0u18paxeD9BwKS4r+nmA6EM9JEsPo7D1GhmMc7dQFNAZXRQH5VPopEJBeETLZr+VGAo
	 OylDhegyXLeZ2xocgscq58c4yXsXFuGk/4yuqa54MGBXgog5pmAREVslx/vamn7Iedq5U
	 Cc93G/FjGvkkQgU8ypAhEKoub1mgoHMOcK0z9p3+aeyUalQF4h85pHa2prv8Sy/VH/Vpl
	 YfI3okQupiQpmJypzDfkXd5Ku+hfuE5e8DDHPSGsc5L7FS9u5PElZlTJBy1yuyuCtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7lR27Rb;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47743606A330
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 18:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47743606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7lR27Rb
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-370a1bc464cso550359eec.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989194; x=1794593994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
        b=X7lR27RbrxzayAIqAKtxrfjf53P0bbpYAmfW+QVcAshLVcuM4RBj69px8H/k8CSjsm
         Hi41EFcJE3XccnMUwcmsv/Qq5V/R2F1dc3X2FynpaQXVSAHmwOitYgskIterANLTBb1G
         cZq2+ewPwPG3aZmQstNuutoWF2nCQfBUUYAK2aVBYT7eNrsjOdpm3EHebbwkOShfxHBn
         VA2W3Xx5NYz8untfcuBIhr7eM5pkbpaeaXOxljElRXWT17TfMmLtbfUW1dW5H99cKb3J
         yfwGvemvWV1RDWr6Jli0dtYrVq6PyzIk8i96SzMf3hZOPp58V3Vdxck7Y6ZCaOA3Lrmv
         ulBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989194; x=1794593994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePH+hik62Fy6F4AAmE1n6DWeBVlZXhgjc9v7cFTm+1I=;
        b=kWqn0mTIJ9zq65NU5M4ZtqK3Il0ufesVD5FIDz6531V+4jaf7FclV7439WFjt2NcQx
         hvf942mWuLSrGtGvHuOMC2/foh9cuBdvUrk3QJPVqIKNx+Jur1WpSG41zyASJ8ImWmUh
         8/etiXEhJzorqGc5bGT2s849+KBQlS5fz2zXHlm9qWHs5yh8d+NakFFQn3ICSxLa0NVY
         vO4E5p4c9T4LTn95b8SGmaNL4BoiVyy43Mn3oznW7oIkwstn3a3y7Rqs12jYvz9EtX+j
         qgz1Iyf4BnETmn7wURnZ+CVeZ1JYiW7r/Z23PjBN9Rc+rBE/GS0lp1iPGUNQpS92ASJv
         1nnQ==
X-Gm-Message-State: APuU4Z/Hx9M16u152joD4NKfHsZK8UYUGSHKshyYnaeM6669lDR0AWfv
	l/dHdVHMn4yDSW01kM6m46jjBxcYrujIqYJzlA+vxYIeyGyDFy/+xiu8
X-Gm-Gg: AYBFou08eZafZo7TUbuTDTBglw2zJn2VAou1xxCfANS2IuSacCfF9C0rq+HxfBPdLJO
	mikOp3zGNE1jvAFa087FvLW5v1CbI4XAaCnozFW0xtHSTuHml3XgqlbE4bPc9spRjZHmbX+xWJy
	unRRgQc5StXjxmL4psD5sSNGDUtneQ7lsxxv5psj1rN9PincOXO6ku+cPPF7/QFyVJ6qENvb9eQ
	wQoBrENYmCPDUqndyI2EuAyQBCgxISGLYyhUNbMUzZ63AGfPP0xT4yqziEoLVMIUlRjY5cX90PD
	sV/NNZNCKf3jIKngL54qxQ7rmAONNVmKnQ/YVGOHHDVckwKuruaQ7cIUVZ/jMMdYYofofbHXSsD
	zgYaTOq1i1EhhDWGHex9NfRdN3yRGoPkTyDf5wau4NOvmFGF7H9LrIOrYRhVQFDzVlR1lgpElAG
	ZtwNXzhNGWfLMMMkPWryii0nGXWPA1AVCZvJg3Qe3RKSqtrsQSIo/J5w0RjZzBpm3IaNfDWBLag
	YCHiWwX1KLZElGNb0XrQN3rlBUlwxk9t2BEweqO7eU0jLCLAqmFQGCzoG2Uta/yiwqrZmbuCroS
	oEfFRnr0f2JZWhjT8vovWVqO2vbZZBWbkhRSxcl3405wBYMY/dqb9V65S1qUVJmilvlX+3pgxye
	x5A1NX8XQrR4ZDHmVRbv1V0n+/YdT3uX4LtdeXkdTmB+bgYLTGERf6JMj8uX6LmQPjiCCWBr7ef
	KUt60D8huqaXDBASJVI1BvrxcolYXWvmTw3AByrH0EATPohkS0gg==
X-Received: by 2002:a05:693c:2a0b:b0:36d:d7ec:5e3d with SMTP id 5a478bee46e88-36f772f8940mr4302147eec.21.1793989194075;
        Fri, 06 Nov 2026 10:19:54 -0800 (PST)
Received: from zbook-HP-ZBook-Firefly-14-inch-G8-Mobile-Workstation-PC.. ([49.207.55.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm8241901eec.26.2026.11.06.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:19:53 -0800 (PST)
From: Payal Lenka <payalm.lenka@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	chenchangcheng@kylinos.cn,
	Payal Lenka <payalm.lenka@gmail.com>,
	syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com
Subject: [PATCH] HID: corsair: cancel the LED work again after unregistering the LED
Date: Fri,  6 Nov 2026 23:49:44 +0530
Message-ID: <20261106181944.2535082-1-payalm.lenka@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") cancels the LED work before calling
led_classdev_unregister(). But unless LED_RETAIN_AT_SHUTDOWN is set,
led_classdev_unregister() turns the LED off, and k90_brightness_set()
then queues the work again. The k90_led holding that work is freed right
after, with the work still queued. The removed flag does not help, as
the worker would read it from the freed memory.

This is caught by debugobjects when a device is disconnected:

  ODEBUG: free active (active state 0) object: 0000000097898442
    object type: work_struct hint: k90_record_led_work+0x0/0x1e0
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x189/0x2a0

Cancel the work a second time after unregistering the LED, in both
k90_cleanup_backlight() and k90_cleanup_macro_functions(). The first
cancel stays, as it keeps a running worker from using led->cdev.dev while
the LED is unregistered.

The root cause analysis and this patch were prepared with the help of the
Claude Opus 5.5 coding assistant.

Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
Cc: stable@vger.kernel.org
Signed-off-by: Payal Lenka <payalm.lenka@gmail.com>
---
Tested in QEMU (x86_64, KASAN, DEBUG_OBJECTS_WORK and DEBUG_OBJECTS_FREE)
with a C reproducer from the syzbot report, 120 seconds per run:

  no fix:                     warnings for both work items
  this patch:                 no warnings over 124 disconnects
  only the backlight cancel:  warnings for k90_record_led_work
  only the record LED cancel: warnings for k90_backlight_work

The reproducer does not exercise the race fixed by eb51c9f8cb4f, so that
is not tested here; the first cancel is kept for it. Not tested on real
K90 hardware.

 drivers/hid/hid-corsair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb5..7e5ff3d52 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -526,6 +526,8 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 		drvdata->backlight->removed = true;
 		cancel_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&drvdata->backlight->work);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -542,6 +544,8 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		k90->record_led.removed = true;
 		cancel_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&k90->record_led.work);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
-- 
2.43.0

