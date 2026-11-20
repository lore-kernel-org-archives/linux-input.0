Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164071;
	b=hhfe0a0DP8A2t8ut1Rzfx6umcW3yh5f6X2jXYXlFn1ht0AFlhJOo1XjnSg5qcotCtFjs
	 s1xjOcRdTfhALNxalWiuMowN2KoTgkZBKfu6DiCXDiKvQZtsQ47dtZYMaXt4x79QKEukk
	 I2xnjMF3l0DzHLF/n17lHEntM4OFtyCSItwFPok8vc/M6BpSsl0dMmiC/BOpPWIz4tEtx
	 rJPzaEeiK7whxHucuGV1IM7cakE4nAGDprTAERgW/DIdfDzJR4B6FTrGAaGimKm+ETnoi
	 YaqfhS/oyZ7ypQQIi2LNJyZdeQ0SKaAhyxcO8w4mRFaOhsrOodvOYDe5Z5BZ9TO/0Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
	b=uyhLFAsT93NvAB4SGqsyspDSEF04QpM5+IJc9flS3NicFK19xcHTQUqMlUTT2Qf1ZlKG
	 Q+1087CsUAEThWAUZd70fy9UBST53YSiXD+2kC/W245y25N6HxgWQJ2hQ6TeyogiUg7LO
	 edvuqtYskvLWAsB7Oz8B83sx7lIhkSLv++FoK9S2Vd8svvGHG16l8cp7cJthyRFd9fdAB
	 CLPANsGPj9cTH4uK4aXUlUsLvbqJdfCS5D7llB+qELXxJUex6VQHhiGXnBDQEXl+ScOLc
	 Nf4D1sdcMY37xC/IiGvPK43aTYMifSwauDDDeyUqQGs1dFriMvOcpBHJlVGqAji4Nvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFxXblBq;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC660A5BD3
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADCC660A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFxXblBq
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38431138772so774368eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164070; x=1795768870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
        b=BFxXblBq1otoODFiqEI2i/efkRllhYlVxPiXINOyzCa87lxGRzRvo4ysEgErBhelYs
         8k8DFKpTnbFiViNMEIcQiEl7ek4JT8smZcZwR/XoEUg0HXOQuXzyfIWYXJ3Dm6erP4ar
         JYZ1oZQQ5uDIg+6LlfR2OHha4IK4Ub9DWeLmUuLsYQwOOWF0dl/zF0hoiJTr48raameH
         ZaUn6fd0Dp2ppnh6GWoz7swz1kHULWeoKiqN5seP7dAB+Nd9/y/JMeQOQeHBW2+7pXCb
         HGJJr8XQjTy4uB1JCHT5Q0FaRY+004ORNMLRjWvcxTQ/li7WDeuwUZeG26j1d6Qo8OJy
         Jowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164070; x=1795768870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+q+bk6wBeU6DAMOAVWLCyHDeeW4f0hRfi2USDPpSdvY=;
        b=HWKmQme8x4StmxXcS0fJC6mCMt77BE3qLlxWFMdql+go+3zNytvqva9f/NlBTdOfKu
         PMVP80rQ6IfFIvf03WrvNYEl/mlhEwmjuuQj+aJSAAP7BjKO1rsa1gqTLHBU5bk4mM7r
         IwtjtK+93kik5b/tF+flg03OqiBSQLLwulVtzWcWgjjM9tbRJSXLqS3GzwzFF9XnH6Sb
         QUWxIcW6b2D9iNhTLKHMWu5Oe9fbWdNDZ1wEPWKaq/oSqH8lqw7Ai7WPBm8MbvvagawX
         Gg/OH5WxCL9hU0XUxCJRifTLJoGPOSEL0LylDd+tT7mQvbCFVveDJDWqhsZNqTiA7U5x
         6AbQ==
X-Forwarded-Encrypted: i=1; AL+hErEyIT3ruASVYSV65nHwoc7quFrJs1/RkMw8K1ZI1jCSNU6pZP7a6kWV6OgBIX1wV2gPCNevnArCTmTl0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gIKEWHfRtfBJjVhf1i1bQJrS0ZWob+kkDX34k3Ci/5UmfF/sH
	33tci+vd4wX3g/kF9Mlvk419YW22EFBQrQGqTl8S1a9404aksCLMlTu+
X-Gm-Gg: AZFdTZf9fGZZZBETnKNB9R085uC8CuuivpeHRbs/vPeYl0lNGSkqN9sCfkV2R3G3ndq
	8y7VboDmMm//kDQ28DuK1Ca+F0WDXWaQzhm8WtmNRSpTc4/h/MXa0KaFGwaURhe0tXUfUcQ/RQa
	wSHOCwD+Z2d035Cdqr2bM/QAbGMUvVI5kdkWc9pEv0YtHJHTOWKKAA2ZLY94Tkajsz8M4xm/3eM
	SoDGhTj0trAa6l6WEmqVLSk8kiw3kZU8xDbMf13Gcudntf2iyAjY/T+MJx798OZHe63d/Sr6knC
	8+QlkTdRX/+dECPTxmeqCQ5FIpW/7A4zsTPM6aX3A7ApcvWKljSR4D1UOF9o4vHeQSjLB6x6Zva
	wjLQILzb0Ejd/3eUD/aDxtrAxRGeFWN5w7KlrbOAtdR83NEJbWhYIASd0ixB2/w7uXEO6ExHRi3
	CEdRn24T6MVeDBU9BNO8He8HWZnKqaw+c8C+KhRS2xXeba/HJGokyoly6Wj0dASk9jxziPg5lQo
	7EQeXuG/y+3FGdY5cejeBrZgJKz7hptzaZb73lsrNmODC8UAfp5YIlA7ZJNwS2+hMKLyMVGezFp
	K4U98rS5T06SQL//wxzg7NcsBa02se6kvCfxi1dDMTma8K83RUIOiue/xr5xsIIsliBJCRx0VI1
	AdPVe7Q86h4Quml/iTQ==
X-Received: by 2002:a05:7301:fc02:b0:384:c043:c5c with SMTP id 5a478bee46e88-3856c6b3470mr1883528eec.3.1795164069863;
        Fri, 20 Nov 2026 00:41:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:08 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:56 -0800
Subject: [PATCH v3 08/14] HID: logitech-hidpp: do not retry timeouts and
 transport errors in hidpp_send_message_sync()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-8-cfe2caa1d0eb@gmail.com>
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

When a transport failure or timeout occurs, the synchronous send helper
clears the response buffer, setting its report ID to zero. Because the
retry loop only inspects valid HID++ short, long, and very long report
IDs to decide whether to return, a cleared buffer misses both checks and
falls through to the busy-retry path. Every transport error and timeout
is therefore misidentified as a busy error and retried three times while
holding the send mutex.

Return immediately when the low-level helper reports success or a
negative error code, and only retry when the device responds with an
explicit busy protocol error.

Fixes: aba7963544d4 ("HID: logitech-hidpp: Do not assume FAP in hidpp_send_message_sync()")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0264e4541edf..c486488efe99 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -364,6 +364,9 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
+		if (ret <= 0)
+			break;
+
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    ret != HIDPP_ERROR_BUSY)
 			break;

-- 
2.56.1.750.gf70dc682cf-goog

