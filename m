Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204699;
	b=s5zJ29hsO0Z30jdtY9hPr8SxyW/9SRpWmi/EEF8gyDenWnrCQw6tI5yqaSXrLyHmL+ZT
	 Yv2uj6JFI7gs29T+hsa+wAMsZvMC6R9ByYQNtK6xm35suQs8D9/Ac3tG/Tvme84QecFWl
	 mqihGNZbeBqKJaczR1QalKb9XykN6qeMspinDqQzKtXKoYBlsHlyTggvHud5OP8u6rhh4
	 4wws+ibWaDSG0V5hD6cp/AEyFF2xv+650UsLbBPJE05rm7psg7kmpSF70Eokzv7sA04tH
	 DsZHCTyzvzBb+lQgmlrzG4T6hEH3/J2Ut295UyKGN4i5Cxx86MnM74uF6K74B7IidMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gH644WbN+LdnH6MmDYYCjv4JulA6E0qcVtYB6UbHl5M=;
	b=f7sK6fspOUpwxcupuBlQm8Us5BUB07FXdzKN/JfkL2pTw+1yPZf9ogkdvlrBeU3UX2vA
	 isZaaO3/2+UExLsRrLsZY7BcUb2Qqm2/cawgFcl/KpaeoJXLdKjZIn+qj4Bui5vPXanz1
	 a1khDflGctoIics/H5CFTB5SjfwibfvAliLOkhtFQOFW53elbOccJZwdLVHcAp+4UCSQN
	 5vqNSD4KjZnL4HR3D8oO/shValQeDYHRcxpowNJpRN/6/0cFpnT5g37K4tVSJ+eifZXSg
	 tSpY7477MDFlOemiuc1NTAI0v6xl1myKPSbHnABoTa65HWetm05wHgnwQwCCH9fQLLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFyaZKK4;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24221606D824
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24221606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFyaZKK4
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so1214462eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204698; x=1794809498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH644WbN+LdnH6MmDYYCjv4JulA6E0qcVtYB6UbHl5M=;
        b=wFyaZKK4rucwtYMp7L2CkJgKG4Cp88lxhnV7RiTy1OBV4s7cDRknWRPDtj20wLYzws
         SuTmKyy7hKNAu1ACfPhYmk9PiWLPkRPpO0ATg13LJje53hVh/6B5I6mJuXdV0wpVpfKO
         D5aj1SgOGVvynNNeyzVCt47n0fW2ZsWxiFpVrOa/75MMjiH+hXnV1Y7wUMVgS7rcM8Uo
         hZwcRZsdm3DNXvbF+64KFwWB7kNjOXVxKbZ4l1j9kniyB5PLmt4Q9TVwd4c6kvjuKAJF
         ywFR98i/Ydmo7RwNgmNz/+Eh8FiwFRTal8xqRbrlnyTIHQZ/g88kosqiUHgzr0xfMFhy
         jtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204698; x=1794809498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH644WbN+LdnH6MmDYYCjv4JulA6E0qcVtYB6UbHl5M=;
        b=EZIZTyTvHCkU4ibT9OHsGuc+EXAsStyooyYBwPlkDeHLM7xgSelImEB+U8ByJcGUmC
         2xFn3wIIuwSsUgLagy0fuAMSESpDj2/IKTMMHHKWrKbVDkifQLCSpIoewuRSwoFyvbI/
         m61AAYviv7ecIinV+4hDBZNorMVgsAC9YpiG8InwSgSiPRAt6etYampxnXh4xoOuv4V3
         NlIZmMXAUULY6CKXySlwib2CQRs36NyBWUTt1H2qeJYwuqZZt+zzaibDcj7Cgk1w7ItS
         lkmynFUoAYghOIJLXjysAMJIydiRTJ192BVQF/fAiek6M+ch7QlcXsLV1dakBvpFqDWU
         6Nig==
X-Forwarded-Encrypted: i=1; AL+hErHHr357spKLd8LF1ywP7USBxLuhw7o4YTkY0jNtwckVHXMRSbwzU3441sIFkxbdu+RNPISbhawc7MdGSw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lI/DVlM57pMGJwldSh0dDarTTysNjjSLW1t/ZfzxkTRqBKRh+
	DqfG/4WcSzu+/CtX0d4NzWp9KoPPNsa4/DGiC2BWY9aauJDkqmQ2RgeF
X-Gm-Gg: AYBFou1vC/dX9y/WtYmd5pn8pDOpEyjQbWx3TfZamarN6cD3PKh/2X15arRPIEkgBHa
	hFuSfXrxTDvrLq9KqcyyegVB5REx0HSGzXp54M573mZEy4S07b3P8BmpCThjiTOaHsBQGavgCJ2
	jH32S/jYcjt1QF1/0TTO0+qrBtiEig/NyJ+RsBWhvga4z8pVg1b3fjxu/eUcCXz/WzNbvFf5AcL
	8y4RBtNBuKF9K8ZcN+VMo6HoxwCm9a/ZikQ0ACW0gW+YIYUD7w1PlyLj7K/tW2aHFKsxzk5yFPF
	37K6QzCt8MOD/hzFUJ61wSi45V4/6y9j80mAaswhgCYTVLhks3XqmI4tDxLS7WUeo6kZGh4z4Ie
	tuzbPlKiQklpyrOJewBRHDmg+96ULB9Pr3n+67/gzVnralHM0J3ZKmZsJq7DUgGF1yD1kN74ppz
	hm97WZcWDE1rEaZTfYdW9GXmP6dbV+HGEHpqfrva0LfQTx6UZ7D1pe9neoh8EWfE781BnQGoPo5
	mrDRjL6W3RdfDBTCePpxSA9Op5o/j9Sz7DEj1MnqbOIwhQhO9SFRTt/xdunj3IykB5Fc+UkXLxZ
	v9pUeKBHFvgMTwOcKQdUopPK2J3gXoZLZFopxGQqiw/G5UODzBYhriS5czAGAPIbvLlGFUeDteH
	baayKNEjSuGtzJCpa
X-Received: by 2002:a05:7301:dd92:b0:36f:26a7:968e with SMTP id 5a478bee46e88-372579ac6ccmr5593616eec.40.1794204698322;
        Sun, 08 Nov 2026 22:11:38 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:37 -0800 (PST)
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
Subject: [PATCH 18/18] HID: logitech-hidpp: manage ps_attribute_group with devm_device_add_group()
Date: Sun,  8 Nov 2026 22:11:02 -0800
Message-ID: <20261109061103.2887636-19-dmitry.torokhov@gmail.com>
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

Managing the power-supply sysfs attribute group manually requires
explicit cleanup in both probe failure paths and device removal, even
though all surrounding device state uses devres.

Switch to devm_device_add_group() while keeping synchronous creation
before connecting subdrivers and non-fatal warning behavior on failure.
Drop the manual removal calls, eliminate the empty start-failure unwind
label in probe, and simplify device removal accordingly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7ff7b7d8e2d2..83a408f91d8b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4739,7 +4739,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 
 	/* indicates we are handling the battery properties in the kernel */
-	ret = sysfs_create_group(&hdev->dev.kobj, &ps_attribute_group);
+	ret = devm_device_add_group(&hdev->dev, &ps_attribute_group);
 	if (ret)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
@@ -4753,7 +4753,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto hid_hw_start_fail;
+		return ret;
 	}
 
 	ret = hid_hw_open(hdev);
@@ -4811,8 +4811,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
-hid_hw_start_fail:
-	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	return ret;
 }
 
@@ -4820,13 +4818,10 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
-	if (!hidpp)
-		return hid_hw_stop(hdev);
-
-	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-
-	disable_work_sync(&hidpp->work);
-	disable_work_sync(&hidpp->reset_hi_res_work);
+	if (hidpp) {
+		disable_work_sync(&hidpp->work);
+		disable_work_sync(&hidpp->reset_hi_res_work);
+	}
 
 	hid_hw_stop(hdev);
 }
-- 
2.56.0.506.g506a7eabc5-goog

