Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380200;
	b=36XHAeFgdMLJ0Xt9p3/X1oJC54/37KL7HVs0leCLQ2Hh5Uva7VLrQgZTAzDw2uFp1i4b
	 Le4fWF3OYjc00ef//yP3xfrTKenvyGXoMZZ8dTue6rYvxL4ajUT2y/4SIPswAx4w7luGl
	 6ZlxYjBYPSj7XwgwFvg60HJY9Ik6pZIkn2NqZwZfTOA5mdMrcvm3mifPhbcYUESZ+d1EI
	 22h/FTkQklRoygCs4cRGMGBMUEwaFFtM9VuYCEK5O34LdN0/zfH+ErnWV891a9uTwU8Gn
	 2+HJO5vS9MkIxnQmlpgjhHw6YsgRKF93lfIhUhetOnLfTbiWUJwPC020n7M2gh0GcDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
	b=pz8vB30kPIczEmZivw+XLo0JA4BNIa7PshfoHWdwAYGMl6VCiHEsAygGAuEpVwBin8I5
	 7phq7GQResO2ajsZ/saY7gnWUNqyCFYCIlG4Hln8CMZ9k0hKfGkGGWiOJz0i94+2Me3R9
	 ui3//r+nYhMBJsM5ux0Xl3mtVfTyk4waF4yqmbj+P79z8jK81uo/OM91hDYTdlBCQQbjm
	 oOEWmmGAJFTmaPDliG16J1HPT0vZF+s8kw9EZt8TKuFtNIu7HWw1+yBDwNe1DlSwwIaJe
	 NBSYI9tLNc8zZgORIyhmqUE40t6cO6EfFaBUq+y51/Bj5FKj96kYVpVxBnII+hFVDCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHqp2NLG;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539D60A5BD3
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6539D60A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHqp2NLG
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so373855c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380200; x=1794985000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
        b=uHqp2NLGhzK00XTIfrkQRkQuKuh0Mmw5nB/Kat4LqWbqhnMoF9FAnCYO72jDqDvksL
         Df8i04ZsPDBrImnMyZRZFGMuRlO8BTUd/nrGj2C/XCcd3Sw/Pypv6A4hX96itvrSKwGD
         gcpI3tXeOCYEfxmvDMoke8M36spvzjONIRQGerRRpnjrxto+uw7iacIxRuo9yLHtRxBA
         muGbVzAki4EKjgZ0bk9GJ9s0CUGQ1//D1kRp9hes2LTBixo6E8nKapTwnAG0FcMU9f1F
         XMOdO6e/nyn5GXPWX/lp5G5XUYytIXbRpvNMMmIwlen9Dcx+yBvgQJrjJQ99NocQaKgj
         KnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380200; x=1794985000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SmbT2885p8gf81jXCe3S6/qBsJ2yVrjvPyxx2QWJ7c=;
        b=FYaVpUTFk14zWCgZZ9IiJBh8zpdfOm3B5hqPV6z28qOVJmvqOHYkAQgP2kXFR+bvm9
         +0sQl0P2TmMnNNuF/El+/Kd/ls12TR3yn5nqbAZerOshYqpUKld+GyEEYOX4C+ArJn7a
         y/+SXQCiwZU9dzGbgUyoWGrA2sxF/MK1Il0gMca8/pGM6waJUmo3ZofmxIGRh9mD7y4A
         vYnOjnomzNw0WgFiOpzojep4M1mOppHEVyOlrf00IwlOnHrpHddyZzIKubHlZvm8l1c6
         NSyoWm7JSCSGG0ZDCcueuz8FRV9hrbvilZ0ZoI+h+w3JSRjTOHqJ5P0/sCjKgjhcFiT0
         4M7g==
X-Forwarded-Encrypted: i=1; AL+hErFM5/p7PUARiFxuWDGhY6DXJCdwloTKlv0hW667w9OVlSqzcRstlHJDs4pSwaJbB4sm+LSgZwuw6cpMKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/av5fYG7Wx0JhPKWzxm4abN7r8p0hd5nQ5lvc8YY+RTksemFG8
	VnKxCYe3Ch3tR0CYdCkLtOEa4PSzqjsSi4fPU0dHlIw1ObcGOx1fwuTS
X-Gm-Gg: AYBFou0tgBPX5iFRYXnWdC5lmSDybD1dzK2Myr5SDBNog47GPA7rS1thORnOeRgcsWv
	Wmo75GacDk532XvrJHtrDMfHshvuWfaGDFkKrI6G14z5I8U/vR/WgDITyQnOUrJDsfCWQwuyTfb
	bRpFbmCbP6V+/rF8rtGYLq0j0MVMm2M6Gho3xRjewN+NzraI+1Q4ohM9bqWXNB6k5ZJLGsh7OVC
	GBk9WYmcdwWZHwxscwnqYEurAk/cdGp32YyYXkFpj6nJ5R/t2o4qoJQn/u7TJNqlTSWwnyEtE/9
	4GG/xHnvDwnuoJUPrQAFSPfHqmw1MGGwFQcoyC3c+rxLEwYQV2YSdhQiEuDVBt1tN+8JCkMDf10
	4G0TrLm7WvY3nVg+kM5xP5sn/ffQKiEASNNp2mh+Dk01deCwSqyW9aA2fGaDNQ6xN2qxwW4ss8F
	kxJVK6XP5dxJV7uKYLrUnQUWCv4i+lNz4tKXdG6g6+EnwzBP0Nmu18YCOJRVHkL6Hch/ZBRCyaw
	CbzjqkGZ0T+TmUJ+2LZ7LMzyAPS2JsDjxYM3fbjKhSuGxWrh9EmaNA2PV81oV5naXRbe2/Pw1gu
	oWfTmtThZeB9kFHOtWeaNPdwUND7Ebm/YqFSSdZ6Bth1zQ52QIvW0ZKLylKtMAcdyqyT0Wuvqpy
	88LrTCIc2wgLymJ0KQQ==
X-Received: by 2002:a05:7022:7f0b:b0:192:e5a8:6bae with SMTP id a92af1059eb24-1b3c034e292mr1417864c88.40.1794380199197;
        Tue, 10 Nov 2026 22:56:39 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:38 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:09 -0800
Subject: [PATCH v2 11/33] HID: logitech-hidpp: handle negative errors in
 hidpp20_get_adc_measurement_1f20()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-11-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

When hidpp_send_fap_command_sync() fails with a negative transport or
timeout error (-ETIMEDOUT, -ENODEV, etc.),
hidpp20_get_adc_measurement_1f20() only checked if (ret > 0) for
protocol errors and fell through. It then parsed zeroed response
parameters (0 mV) and returned true, marking a disconnected or
unresponsive device online and triggering spurious "possibly using the
wrong voltage curve" warnings.

Return false whenever ret is non-zero, logging the debug message only
when ret is a positive protocol error.

Fixes: c361982a13c9 ("HID: logitech-hidpp: Add support for ADC measurement feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ec2f2fd6dec..28402baf04fb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1952,9 +1952,10 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
 					  CMD_ADC_MEASUREMENT_GET_ADC_MEASUREMENT,
 					  NULL, 0, &response);
 
-	if (ret > 0) {
-		hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
+	if (ret) {
+		if (ret > 0)
+			hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+				__func__, ret);
 		return false;
 	}
 

-- 
2.56.0.542.g3ef89b7020-goog

