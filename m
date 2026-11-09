Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204697;
	b=1uSh9bY1tQYYCkroMRs/IrG2rhgblI+Fo8xuZFAUbfueuILmMhpuEmIrdzwWa7YYG/Al
	 iAx4qGtosJ0BWayrE2gIQm9b7/IKYsHgP0MUaTkteOOiQKGjqtubfsktY4d46sfgWUqti
	 gFDhcrXfnbMnqellefFMGJgh4ZrE/zSkNCdJogGGMAe2hkRK1RNBM8MfQm4dQ00uKe1Ks
	 2IryI1ZmEv+r0ZlVOPq0eOKGnMe/C/eeQ0Q1S0QLwvgRBYaPl/bFCV+4PJZOZ7ExueiFG
	 Glagyb56T8LAUHgLSppR3zef4THTtjnY85yIkm3DNkVOUTgF9mCffnvlq77qIwMcBzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8m7dQxCboWCqtELVdkToHmnIGOnHpHH542//byrS0DU=;
	b=GHqmVSslfjUegvmTaxiem5hvyuw1vNLbKQuTLf94+WlStJd2w+S+E3cjSAo0byfYg/gH
	 F3JAeFgjJegKkr6hmht0wobY7ih8czUel2WJkxq67+nltWtryo1UeIR4ZVu8cYH6YEZzA
	 HxdqpCUf94dEh9oVa6CV8Ut5IRHaqiBWb5MZtRDEArX2A2AlPz2SpTukAHJzLGyfSRWsM
	 AMSAbq6y8E0sHu3C+cgs8ifZF7LF7ozpd8TfOnazxQkb01LdNo00gVZtLbJkv5pSB4ZgE
	 N3RCbV+lpWi6pYtUeDtAlkm82WhpeA8K/lUu/WbL1AM/YZaf/DTHscJKuPLH5VQp2mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8oFTGKh;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A36083603
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738A36083603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8oFTGKh
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so935839eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204697; x=1794809497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8m7dQxCboWCqtELVdkToHmnIGOnHpHH542//byrS0DU=;
        b=T8oFTGKhw9v4RXYtjS9yUVjenGTa1WR7im2XzJP1xDmptDuvUzm9VVCMk9lbc04PUj
         LrZQT9YHSfwiAFtj2pf5Cl4VcvgDr6Vubv4fvAj3rWP6FcGVNH95J0iZdj3rlpjkW6Np
         vSRAtiLneiMPXq0S8FpyRCJSVLV9nwTxiIKDet3UB9PyYT7OL+PIzc8PO2E9LS4JtHpf
         GpLT2qWV5n1rnHn7A94VPgRdeporT/FwPLidLh6rI9h/55TZ6nuxrIQdgpdt1s8rIODM
         14QO3IrINzGk7u1MGbnL03nvXYGuqwCb9zlgLXWjtHhfgpLzlql4sOhlsQSf96xHSzoo
         Or8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204697; x=1794809497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8m7dQxCboWCqtELVdkToHmnIGOnHpHH542//byrS0DU=;
        b=w9MRmOCR5STYYdzmLkEM4/XueouQnyFfj9EzikpBEOEEFKOk/M0xZx3SdJVd0Y00dx
         e/O5hXXW1APEdyv9lW/COj4Y0CUnw0isp5CFjAzvJ75xm5kDiZsHU7DHttcz/goVr31Y
         dshGx9nqK2OnGB3dzoaMhTfGgb0w+h08aq2Y7qv92gJoaxLSYWuY8RmuL3FZlTYxutGJ
         O0hW24yOFHSP8jQplJ0qNCPNsPnCk61vgRUmWxSMLw1WRk1zNdYgNbuMbUVxrMWNV/xW
         yP1EBwzjgk5dd0UOknR1AiQLWS1Y2hqg54TVXmQi/GkS+3PUb+xXTEvhOBOqPyARpeKs
         Zq+A==
X-Forwarded-Encrypted: i=1; AL+hErHW2igbvqkBiMFJKL7aZ3YnGzxUsS2bf+EtuqrUnqBYqWYbMbKDNipYVCwe0HNZHb2pe6BTavEqfgQqiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4/hctIqo/S2Z0tOtSaym8AL+6sPT3e/yWO0HadT2x48e8RVjM
	WhLAcfK8uXl6DsEXYrV03dhgjXkqvJRaM+fvKLgNR1SxU5spq3Ov2pp0
X-Gm-Gg: AYBFou0JQXxgTxuAxBWA8cpZE0eb8iOuT+Xp0ZpZa+dRFeDg76mcy2NZZ+nVmCG3EG9
	4hHqKjqIZDX3CPb6d1QbBnraK0/ax8Ul1fjZrtIOTlY8t40WOBXs2+ljYJqHAfUY0f5MHcbMNnM
	iZeg2vrcIdA0Zsk1d0+O34cQn00bJtWWBtXbTUG7VEHM0hPsBR7loGJsD+TAM83QpP2M9dGnYUu
	5ZbsOrGTMe8VVwZjp9Fe9TEXI8QJm3mz1hUSjuK39ucshled+afhd8dnETKS0Gm3q9I/+O8J4Vu
	L0bo31ti9MDv1Z/Jpf1ioalXLSt9oZfHIbX/GmgMmTHRj3CUPGBYun8+BKw9pVl+wtQvzdYqdk+
	VFg+zm26D0eLAXb0yaXU0B+KxMKfbaORBC3nHbIykfeJAq/lzKUjTyWU10Y0veyJKWoDbpew+Fn
	NHiBk0ZBV7QP6L2TtJzVmWZlPNk6yAgV2VydszAvlnvS+PNqVve/zrva+RUa1C2pJz4EnGuXnkx
	vAPOfKdCPzv1xNAzA7p47GkHQljIWg3eG2fwQTuBpiMyBgW5s97tw52VhJpBAuNhViIlcOfQF3v
	ZxcgOVu4ZVZdOw8KFoqV5GyNoKeHF5MxdX3i2vsUNaPohKEZKW23Z210P6MCmVNkfw8hhl1arkm
	CAZeI/ZGTSHO9v5Z4
X-Received: by 2002:a05:693c:2109:b0:36d:394d:e690 with SMTP id 5a478bee46e88-3725808378bmr6046926eec.40.1794204696568;
        Sun, 08 Nov 2026 22:11:36 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:35 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] HID: logitech-hidpp: manage send_mutex with devm_mutex_init()
Date: Sun,  8 Nov 2026 22:11:01 -0800
Message-ID: <20261109061103.2887636-18-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Manually initializing and destroying the HID++ command mutex in probe
and remove destroys the mutex before devres tears down managed child
resources such as the delayed input device and battery power supply.
Switching to devm_mutex_init() eliminates manual teardown boilerplate
while keeping the mutex valid throughout child device teardown.

Initialize the command mutex with devm_mutex_init() during probe,
returning early on allocation failure, and drop manual mutex
destruction from the error path and device removal handler.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d0ec973a4b49..7ff7b7d8e2d2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4732,9 +4732,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	INIT_WORK(&hidpp->work, hidpp_connect_event);
 	INIT_WORK(&hidpp->reset_hi_res_work, hidpp_reset_hi_res_handler);
-	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
 
+	ret = devm_mutex_init(&hdev->dev, &hidpp->send_mutex);
+	if (ret)
+		return ret;
+
 	/* indicates we are handling the battery properties in the kernel */
 	ret = sysfs_create_group(&hdev->dev.kobj, &ps_attribute_group);
 	if (ret)
@@ -4810,7 +4813,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
 
@@ -4827,7 +4829,6 @@ static void hidpp_remove(struct hid_device *hdev)
 	disable_work_sync(&hidpp->reset_hi_res_work);
 
 	hid_hw_stop(hdev);
-	mutex_destroy(&hidpp->send_mutex);
 }
 
 #define LDJ_DEVICE(product) \
-- 
2.56.0.506.g506a7eabc5-goog

