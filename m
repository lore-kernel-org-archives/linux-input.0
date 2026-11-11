Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380236;
	b=CTLJjsQrb2fXfVVErU1ALUdVJGD7bSXZOgZr5mvuxeKpTP9aTMHZUkcKMJwlQhMB3Y7A
	 UGmXPluQO36s9h1zSXiI/RIuNtihdPQsl0rhDhVx8Pn8Blc54kNNtL0m0JhDXOHCGexVG
	 78P0c5E7LQ4ST4tSNIEAVeqxr+5PvR29u+3UKjmwxO0s4ehsvuj25I/2/gkkJYgeqJM9j
	 Ms6Ijp40Ovq6Bl8IV/AKDLDrbDtb+dzfyySC25ZDejY39aFi/CGyJTOpKfLU7MDnNN7v8
	 /XUsKDpQGn8Xker+7qRvwlZtZmhNWupex2tW7KWOsGzBAFpTopUt9lqlvf4GLyWFPfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZHsFZhQ/4wAZApRj3ZGgA+KMlqW5OQzafAFFcUtWCwU=;
	b=tZ3C9FAjwjCgzvECw+uJ9/J1k9ymV4i2QSPTBRjjkZUFn/451TARmOwfegIs5WJmE5xl
	 wuudEiZ7UvkqRdJMtZ5K9qwN/LTve3EYOfd2uvfRCb/wDWW8X3fl7MvVDGIbRasfo0v2L
	 d3tRbslnNhqy0sAZ8hKXjNgM7te/u/veeeaOqkGyETJdrgxZonuSt4j7WC3KsW5pRC5Jh
	 Ew2m1vIwq8bcjh6DM7A82WCAEq6qCJpr8GFsa9OC4cmdZd9jTQ0HlrfxPU8BzdGeVCVzK
	 d0IMI7Kx7AQKvSkRKtTfmza2iHaZxfFx/v3bsS2pbfhCXbxFNkidGCsuXsm6TxuK0zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZqPdEgJn;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5B606E231
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD5B606E231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZqPdEgJn
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so4894863c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380235; x=1794985035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHsFZhQ/4wAZApRj3ZGgA+KMlqW5OQzafAFFcUtWCwU=;
        b=ZqPdEgJndpIWqn9Ec3zf0lnNUS2PDQVT05hPJ4qzZShL5SAofoJQZKa67gN1pAO1IU
         upQwUZKDp8hq/OSRIZeJhQBvrm9v/5iXo+oz/0cGMk2h0zvSX+egudyaSHJCA2RTyiyd
         5ga0aYy3B2MXKJ46s6m1OgShqQ+rB1qo1fDsVJlfeROegzseWdO0Kr5by3ZUxzc8rarq
         ZpSfH9cGJSSgHoI3h6qiY+EMCrbIZOsMV0EAHbCuQeuCK25H3SsZigbwSD9xZKXmo3FN
         75vb9fFIBShjwCvxu54sgc6B2DDvxuNX/qQCwOJw+Aiux2i1h78Aokbxs+Dsgw54v0gk
         i25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380235; x=1794985035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHsFZhQ/4wAZApRj3ZGgA+KMlqW5OQzafAFFcUtWCwU=;
        b=LAF0P3muQnQpLbVNnfTCT/ybMe4w2Ee5fr7wC+eZr+kFqm6d1DaNpSB3sxHmE+6tUj
         ZX++WlZRLRWBVoP0wKFjaKqofZEwHGahvlewMa3xCpyglThplLY1AYQV1/lObMca708t
         L74J3YYA25kFLsE5j6vn9+yaJDldHeDzoj9YeeCYQhba3FfwHUnmCe1+SUM/lvyIXRPf
         50OQGePv5o18SthvBssqoREHnX1D+1Xlk5kTdVItSqxKMoNTgIt+ubNUdchORanx7gz+
         7ILaOzT5zAzj6fUfxeDRBZp/YAhfpxQ9Ly0GGPXyzsYhG8Ht8xh5WO4t1MV16Qb3zAHZ
         Y2WQ==
X-Forwarded-Encrypted: i=1; AL+hErFNaeyTjM3Sfc3vnAHc5nDi6prsPWg6IapAwN1VJAtN0G/Ef8KRcv2q1FzD4bglZoR7U7H1v8lKejNGDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vg3Ys/cF1aHtloR3Q6e+dtpKxvLX6XBbG4qLqvJtnlD+xv0a6
	dFmWPsbNvML5ppDXALYuagBt8RXiUoXQe4Mqg39E6L9nPu5mWoZI108Y
X-Gm-Gg: AYBFou2yeaoGGFLsOySXYJKjN5elM+yyYpUUvHs7QHK5dvSZR75YvSzR4r6dLZHEdRG
	dDF03/bSli7TJVf4f2NhPxujX0U80OVIp70dGju2ITpNC0o5pKh8mgPbKofdWOk60JLiM+SQ9UX
	BDegB25kmIf3xPJ46Uw/UxbZoa6K/WGldNp90tJFE6JBQ2yzoqXTDozoBaKo3jXDtpDuW8+oOHY
	5ZRcLBtmhbwSY61I107Rutho+eggEN+JPr3qEqtjudpqFIKugbdptFVOxQH1bkSoRG50s++Seod
	TMCRHr47ikz/hSPB7EtB8MDoG86dRICUKzJ6+NwDXGthxsXgTXnb/hbY4wFtGO+SLU0GR8QsvRg
	Iom4535EbYD/DbNRf8QWzY7tDi9tFSH/nKGJPRkO+mNfyG2ZszmWim41El1REfue64VEYrvZ2Eu
	PukXbBL6/BgImEP1lAtVZUUMYSvka7x8f44/qhI182mJgqnOeYFsS8z+x5uwFmjZSzqbxPzajuQ
	e/T6iDeWyCCSy+ouWKqS4eY2A9kA1GrQq+9vb2aDKMy1cybvVjGntuzKkeMZR3JKfeiCa8NnIJo
	Kb7A6E+uQCqqD9fvrGP2leBqpCfAAf3sBJ9zEfe4C7bgatqoLNuwLGw6wfWbDzKlhbNnzRc40XS
	53Ca3Gf+mcv+OaPnA8w==
X-Received: by 2002:a05:701b:42c7:20b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1b3c02f369dmr1565441c88.15.1794380235205;
        Tue, 10 Nov 2026 22:57:15 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:14 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:29 -0800
Subject: [PATCH v2 31/33] HID: logitech-hidpp: manage send_mutex with
 devm_mutex_init()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-31-30743e91d83b@gmail.com>
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

Manually initializing and destroying the HID++ command mutex in probe
and remove destroys the mutex before devres tears down managed child
resources such as the delayed input device and battery power supply.
Switching to devm_mutex_init() eliminates manual teardown boilerplate
while keeping the mutex valid throughout child device teardown.

Initialize the command mutex with devm_mutex_init() during probe,
returning early on allocation failure, and drop manual mutex
destruction from the error path and device removal handler.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b6c7a951cc94..be3c2649b0e3 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4631,9 +4631,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	INIT_WORK(&hidpp->work, hidpp_connect_event);
 	disable_work(&hidpp->work);
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
@@ -4710,7 +4713,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
 
@@ -4737,7 +4739,6 @@ static void hidpp_remove(struct hid_device *hdev)
 	hid_device_io_stop(hdev);
 
 	hid_hw_stop(hdev);
-	mutex_destroy(&hidpp->send_mutex);
 }
 
 #define LDJ_DEVICE(product) \

-- 
2.56.0.542.g3ef89b7020-goog

