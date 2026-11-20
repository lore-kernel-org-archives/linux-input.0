Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164276;
	b=iRvqGh/mDD8iBl96QgljNo41MZNqWPBPUH29MK16Bm48eM87SvV/RPDtUUB4Uu2z/g4A
	 4Yi8jO7GaBOuhhweNZ2hh+7Um9GYIzFGdlrZ2wv6FM7kEc9D+mfDAr6EigN2Q4xpN8FkR
	 uVK1/u3z4uQGeBBn9kQ0UqQSOXhhDUlIzlEqBR88s1rIw2ZymQ3tBMzGHOOW2HFOm54MY
	 T8MgE8agl46TZMlo8jV6EvbT9ODNq07uygy4KCdEHfn0udLaImpFnr8/eZxqXpgQgnn2e
	 U0Y0SGpSIBgFYHFKzPr4SYQ+u2qY8QPK/W5Ybp3+YeB0lsx3/5b+mVUEByfNR0x4TQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OJyJgZhm9cp9UYClWtGOIe/UnREzWNGjtCvJbSuxIDU=;
	b=wDaoRzmw/Qn9gB8/2WNwHiPAAatmzscKh9P6Yo/ARCoDa0VuiA3Cmb7MEJ4Q5H/hkFKP
	 /jyZQBquuZ4UlKZJPBU2fVSb232VvwT9uV4Ihb66yzUVzmNq0MnnKwpKKL5TtP/IllT5X
	 ZK0q8ezt1FhIlVLae4/n5bVz3m23IKAN3fgtiI9CdA31W/kvfYEmKfLbhbonO9FGAp34x
	 AIq/e6FYw0bxoiTARI6Ubj7H2s3HJjg0Oh/fXNXbZOSPJxd66coAFtoclclKbilGchneZ
	 OoRDRF2mTajPNqgWcLMFaI7xEVVLxknecaYyJ8oX5GudofEw9aG481syYOaq2lTOt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gADtE0ag;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBE606A7F9
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DBE606A7F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gADtE0ag
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae58d17cd9so659647c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164275; x=1795769075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJyJgZhm9cp9UYClWtGOIe/UnREzWNGjtCvJbSuxIDU=;
        b=gADtE0ag0Yu358+Jr2GttRb271ajTVW/rczWLDYGLiSCnFk2L3Uk/4DIqfEEqPYuQL
         2omcC6Ui8YcQRMZlz0LPckjt7iYctQk1V2clhNQebMgKG2F3iv6waVVOEkMTjHqdhkI0
         n4H4bd4VyNrEVf+nWwD0nLqyS2v1f2d5o8dp1g0Q/GE+vOPwCb2nrY2KFL2Iz8sG1pp/
         ficU5N4ivECGkuFVVsTLBheO+GaQCpqIaR95ZsVc5u+5nvB2kxzR2/Ojmo9ABpWrghjS
         xksu3DRb0Sp0cWaY9RubgO0zfwzxKrdGmoByJqjMLum2OzxFKXcO7vEde+pOjrY2K50n
         Kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164275; x=1795769075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJyJgZhm9cp9UYClWtGOIe/UnREzWNGjtCvJbSuxIDU=;
        b=nY3tnlvFbtrttoC5nu5l4A/rY8Ja9IthA3z5J2O0oQDEehJrQlA89bYWW+PxOsWO0C
         Cdr3Ai1gN8url8aulCJ3pR+/leYn2CwwOHjTp0DA2gmB8wsfqUo+tTBnEQJ7VE6GZNpW
         BOd94GPH9SSt0WG99hb26ohiDIHon5JyvGYCkIygznxRCeAYAuXEots9pj+Hkhn9rynn
         SlPrmyEgg5lEqxeCfph5asJ/tfFDth/K5uheNkiwb30GlpAkU5Bu7V9d4Gq/XYSyJVbR
         IdeMeqWMa+an3jpbc5lp0UmyUXtDIsZMlldFqnwJmIZNwMVficlqVrHB74yifhIdG+Gr
         2BGw==
X-Forwarded-Encrypted: i=1; AL+hErGJfzojcZWeVVb7hK9cQ6WV5XPY30KhnAcG21XVe/CGcLKAgay9qChE8lKeLR9NaZJjoiMPHK6WVFEvfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nxzc5iexWlVfCTQ8ar5SJLi1Dm/A5i+i0LIQUv0HW5Rv47kno
	ZtIpkC3OzSrYsoXcixmkTGblpxk1BdMgVfANBjSR9D92mufY9NaCp5L3
X-Gm-Gg: AYBFou0bDWijWsLO1pFomUxJvUFoeR0nusFtXtbYBAN6/15n5LbE0VV3aXlq3BCArHN
	5GIlv7VJMc0DspYV4EkQjMbqXsPACr2au9kYHjV3G/JUFm3ZgAT8FFQmhTIVh2VmFkD1rFa7AII
	aSipnGjY1w5mzRCltQhIbELH1UAlWs37V6shVZP5HgPvw9skCFKg+QpAfNgoW7KVDSMaojP26rh
	Po5CA6391LKWNikrbLwRokuS1cZLjW9bVhaBZwJPRJmTcW/k6dP6qTz9s6ejt0dER2SvDDw+YcN
	pef3ItrPSyh+ICn0feZxaGAoryJEfrfmh/KpEKCkuWq0YQ4JnziqcG7pWM1HCphb/V4myzwP+kg
	9YNoYT/h2eyoq/BvCoTqZfPnJr33raF9zkrUeqpD2pYgYdoHTSG7nHJy6lj6F0Hro+knkporHpy
	LAYKj3Sp/vzOSJ+c1P8TICJ2q6CDI79gVAPeAjiRZaC2SjV06jwoxt5FGDf+46kZsA0iDF2oK1j
	jVBCWSfOB0h2lsMDYu7Ox2KGp6/0STJFnsXtJTDEG2ZkuUWtaFj72uxqUFudFcdUzxvJkSKDhDE
	i5zzP7wq05VbX6D0QZDCKLkXIapXvlcFcAClH66vcjyjkWu+qPO7pHdH5I1ex2JVgrUe4N1aPQB
	Mbrht6Bl32OXObwmiqA==
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id a92af1059eb24-1b55688dd29mr3272803c88.19.1795164275440;
        Fri, 20 Nov 2026 00:44:35 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:34 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:07 -0800
Subject: [PATCH v3 16/18] HID: logitech-hidpp: manage send_mutex with
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-16-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
index de9087459273..261022e4088b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4618,9 +4618,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -4697,7 +4700,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
 
@@ -4724,7 +4726,6 @@ static void hidpp_remove(struct hid_device *hdev)
 	hid_device_io_stop(hdev);
 
 	hid_hw_stop(hdev);
-	mutex_destroy(&hidpp->send_mutex);
 }
 
 #define LDJ_DEVICE(product) \

-- 
2.56.1.750.gf70dc682cf-goog

