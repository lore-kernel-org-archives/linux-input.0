Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164067;
	b=oZfi0BEKI/opLXhbet+V+qn1Zwpxq5OBDFZXVJ/vtSzMJKa/o3jPHSAWYp4stY4zprBe
	 lG6SXgGG1BpS/1kRa3ulizAqPrB0JIcgn6DpubVB2xYV0W0YM3M22C91FM3auYcMrs+av
	 3H2GhiUZm1WiXY3nAteLWLMibHimDUyXeuQtUjUsOvOagr3khDw4x+rSGoOwrylBNrwpA
	 MXQ3LZV0L6gp01mtag8FVB6wHBVkK+Qz8RF2d4YIcMxeFB9XjcZUECR4GeKaoq/EKkM7E
	 VkObuJUN8vhGtLBy0BHN8Hyg+zVVnCTdNUXNov4+Xn62F+gJkK8x/kghdAcu0TMuKEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
	b=2wXZco2VSrBJOgmRyKktvgxUbiC4hJFDnKVO0WrRi7QySw19YWwuZftovwNozPYxRWjb
	 9k8CRon79m9euO1wkSOvGgpd8oY+nzdkK5Dqzc6gRgntv0/YCZtN4ZygG8r622oBmj2AD
	 nTgqQqVPresy5gdM5mUC5JoKB+BlOctGoz2orR2xmZdnnhZezOJwy/V6DCSydnZgKWXGD
	 D8c3RwNTLqh3YDOYQFWua65ydYO3j6Fq7/LjrbB4blHjeiAXBASv4lGy0LP76VFXYbXIo
	 toluejSZPvhYi5ho47oz2N26qhvJIl+kE2g9yZr2sitcBPTs1YeCMUdZ9Smk3NSuHNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6vS6VWp;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B860A382D
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742B860A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6vS6VWp
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3863db981d4so141442eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164067; x=1795768867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
        b=L6vS6VWplOM9URretomgFujZAhoTdSfoJ2zAX66pifJCF/cI5mcSbF06OrbisceRGl
         bh90xvXb2S6z+Cr/HNvB12Zhbcv+56FLs6hwcEvM9zd6MLli71IkpLf4dmfkhsUmmmtB
         vz6j2DHQKVG5FuHUOf3ORvr/lKqkewIK4CW5MtgfLx1+hsU96O86QTvue0oi645hd22Q
         cKa82CzO0OdVZT6oA8UAnCqnYTLMnSWBaeKEnG9T1j0QDBOALWw/Dszb6MDgeJzQfhju
         HBwv6STamCDm3swZ2S8+XuwApLKq//O2ylCa9JFlEyjzU6QlsOgVmG3KqjW0YSt0tw53
         aYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164067; x=1795768867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
        b=rluBg3l+V+i14ZrjwY7WO68ZlJuIR4Jqp0ZqrEnnvgtA/Ee8QqYztH4kzrt7fNuIJ3
         LrpUcXxzH/bW7Xi+epP/dSq/KaCkTs5LFdJy/0lNgG+jYWdn6/IXS9hm4EnP1zdbwN6+
         DXCh3N0w/vs3b0bRBDZ2uwVSdYGfw+qZHL3TL3kEl6P4F6jpJkmgpZhmoHV22tHfL3Dk
         CZj3hiYhXAkk0jvvCzkmvGL9hbqVHRbo54BU+iazUPHMJhlv7Du03z8XFwUYWG/hcWbS
         LbuZK7LuJjGFu+M1AOQb+C9gU3msoHeMHgLLqzI9J6W/xUpuKHupC42gCNnivm31cVe6
         Pm1A==
X-Forwarded-Encrypted: i=1; AL+hErFNJC1kXc8/efB7CloWOpj0T0KqOMCUMhPF/SlUS+m8MLS4jg3dZg5clTDKptBM76xa06ey2SdG0XZB3g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2YvvAx/Pd+KGv4niz90Q3Y7nsa79Ir80gN/bmeDWCWLjiKmFy
	RGFtL33tKNazqz0fACuBLFk8UtIAN7hb5c7UEu+/OCJOo8ZW2PtI2LXZ
X-Gm-Gg: AZFdTZeFQ7wljxtOrqGecvOLZEMVLROTtfhmn5wpoDoiJtUphc6FkgJSke61qnbFLq5
	XhbxIuo/Li/ax1H4TDC0j8btXNVWdNMdQUnZpRRR+rhFpj7HnM4LuhoWgfveK2P46yAfETE8lR5
	Y04yzP8MEA3+1IFSc0CBf6d5yqPT842l6MCIenXDaItBVyYR4uTKI2eqO6wcd2iE+lkJ2DZ4TcR
	0nKmKH+iEpcv9KAU7rezUvYUYIy598UtwSeRgJo0e/6r4WN8lNnQupX/1tuxFCHtJAde58T/KaN
	93jovn3/zmjwXWvhtu/WpyVJPbZQRQtqeWbW5k9hq6IqtcuAG/x7Aht+k+peApyQqWiE0ZT0xfJ
	NEiqRSzNae4Zy9cgthI1kftGKeneCnK30h0VVw6EJhe6eEirhszhf48AL20uIrFnfL7GcttWXpY
	Zs0QGPbAklQkmdZ+qmiHXD77iJMoP+oPjsSLumBv7y7pkt16UwKx+TJCIE10zlH8pFRC3uaG8RV
	g//OQA7Cci15685mlu+e4Yd/zxvGvKxoY453wQzGtT5nSoPKGJWxMsE1qqc8zF44cTf7/RLLB9t
	/M7ciTUSkd+Rgow9HHwyQyvd/mVFi5qd1xwloh+BjmsBpPlj5rLQ74GdmQXFuvCmTwJqzOl/SEt
	GbyZUSe8ucKereSND9v3Dpg+Bx/M55JhFi+HsvQA=
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id 5a478bee46e88-3856f65f251mr1756514eec.10.1795164066585;
        Fri, 20 Nov 2026 00:41:06 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:06 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:54 -0800
Subject: [PATCH v3 06/14] HID: logitech-hidpp: avoid NULL subtraction in
 consumer key report fixup
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
Message-Id: <20261120-hid-logitech-hidpp-v3-6-cfe2caa1d0eb@gmail.com>
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

Report fixup runs for all 27 MHz devices because the keyboard quirk
is only determined later after parsing the report descriptor. For mice
and other devices without the consumer collection, searching for the
descriptor fragment returns NULL, yet the remaining length calculation
subtracts the base descriptor pointer from NULL before checking the
search result, triggering pointer-subtraction undefined behavior.

Ensure the search result is non-NULL before computing the remaining
descriptor length.

Fixes: 42bc4f3129e6 ("HID: logitech-hidpp: add support for HID++ 1.0 consumer keys reports")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6ac41b7d76ee..53c171dfcf96 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3872,11 +3872,9 @@ static u8 *hidpp10_consumer_keys_report_fixup(struct hidpp_device *hidpp,
 		0x26, 0x00	/* LOGICAL_MAX (...                    */
 	};
 	char *consumer_rdesc, *rdesc = (char *)_rdesc;
-	unsigned int size;
 
 	consumer_rdesc = strnstr(rdesc, consumer_rdesc_start, *rsize);
-	size = *rsize - (consumer_rdesc - rdesc);
-	if (consumer_rdesc && size >= 25) {
+	if (consumer_rdesc && *rsize - (consumer_rdesc - rdesc) >= 25) {
 		consumer_rdesc[15] = 0x7f;
 		consumer_rdesc[16] = 0x10;
 		consumer_rdesc[20] = 0x7f;

-- 
2.56.1.750.gf70dc682cf-goog

