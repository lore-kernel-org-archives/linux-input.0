Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204678;
	b=a2cD56r6+q4AsBx5MVsP/sTzkJEqAgVRJkyBbbiFfhSHVuYFO0BmVKGBcT2uX+Dv8FuZ
	 fffmfVzdGPSnQxPgidYoMwsrW8UOokuNlco2q3If0mXHnqx+PJLSOyLHBPxYKC+7IXlC8
	 Y1RBNXshpWFAEn2J1Zz0j5TAjl490vU0jaAEsdk/t/t0rTTuFKiY/U6LhRs8N7Q/jS2gr
	 DWsKxtgQc8EyD4TIqNiCdgzoIc79Zx957RSPDC3MFswG863Ms4ZbRdWtB4QAKJzuv841/
	 xKPWBkOwPsrh1Q5rLBLB/JehuDB2wfCOuEqMN0qiica9VeEVBCxcQXZZg8+UrAQpTew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
	b=i7EVPmax3GneJMVPXFPofN71EfpIHNZJHK+a8LCxjsR1MDiXtz/Jblpq5d+RRIqviYeE
	 Ouc+74BPy9Ou0WHDBZTl+AHwlW8n+4CnSpzySQmByjpLwglVsxYmhhvFR6/yMz0jC6HUn
	 RRlCKeq7b+hmTOQE6WvenEniloSK0FXFe0xmwb9GfOV2wLsbFrEOjxM/1PvCxh/BkgS2y
	 acngmPkdIGH7ORxhJiMZapk8uE5QFJ7rhMyqpPzn9gma3zSeoxdQsczfVvGzolW/kZ/do
	 lngG2wc/VFMxDisS8pRIA5b+Wd37sJ0CINP8of/o32QXN+MdfqBRNElON8oDzAL6Ktg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbG3f67H;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66C606A33B
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF66C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbG3f67H
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36ff9c9da34so901250eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204677; x=1794809477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
        b=CbG3f67H9GUeuN8CRNc5kJQBRsAnWzfsF5ytysEWLD0oDckJ7to9w+mGZ51P+JI0gK
         mZsG8X1UFhB7aWz6wSl+gvElBeCgseMK9GMdZej8g5yglvAZILYXfTOmlOHuI52QYiFM
         Cky21RlWHqUQxh/fhTZngLTW958l70dcKIDHIacfIaoapajRzBFJlc1Vy4rjIBd1aPZY
         P7CSFN1jzfHti1TC32gmJI1j7VhoThfghd/qO1+UmY6TGurTJloY2MEPo2TV8UBlUJ4o
         GiiWbrhjw686kzrn3W3oo3Yej4w44vnL4be2s7XaRRo2nwamXgWXfFshp8SFPQx2foee
         MzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204677; x=1794809477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
        b=Q70kdn9LZuQI0MsgkFkYHELdbeEetW/Guy4zcG7Rlw/fc19Jwn+OfCBCrU42MVdUTU
         Cj98BOD7+N/0pr8TQ+zzHJHeCvg4+ebJkykvGYE8nlKb2jfeoPaeGnzS9we3VHLB+u+I
         o4Ka+xuyKZDVquTCxuk/UPVejoKTJFde8CxNT+4olL2wO7/Ii3sfLr5IjOQRU27cdxHB
         mzOisz24igV9O1xG8MoanXrJfihCWHQaVIB3PtcdE/ZVHQK4eJGkeoPV7pfGDm1Nmg9w
         8/tUymi8C+fy6ereMxo34OI+6ouyFbajwfAwiF38Q4o8RJHJlQgLNCs+28l6gpR4wtb8
         1hcw==
X-Forwarded-Encrypted: i=1; AL+hErELzT5cRTKNQOuY59Z5sXGN5SndgR4HjdAZ1hLr+kfmsk28eMOwvxKbC8/kYIOWykwfzAsi0TQSTpAFMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4owURm4YFYWsCOBzmJYapJNJ2ziaAuQgiBAdSXwfsNQFK6gbq
	1C4k6zSU3BhCZnmR2kaTRjCeS49/WZ/KBSWPphd6qxfa9gKJ0Uh+/12N
X-Gm-Gg: AYBFou0CkrG3+jGXBzKAD+23YRWnSRvINtrjdwyYhlVyO04F9xhGwj+fHIoE/oJ7tLY
	2b8Cszo5euuTJPe/9SUHLOluJRCvgXibgzSIV/bBFui0Z/LPRScUtzYpIY3yE3EsvoVcunfurTg
	L8sYgAUsL3fUcVcnlLlai5NdiSg/qJIunG1TM9d2CQhMEW2vNcXJQKGphg3mGSg+Kzwpl6e5w9x
	mqaR968xIXR6xStBiclISiBs1bvvgVMIT8KYxVAvl00DBZ4MmmL3a913D3yckgulO9P20OqZBCh
	cIPCV1wgq1BEju7eowW698TkjjFjY2IP0beSRT2f99diJgXADboslI7m32livks1AST2y4j0Jfr
	Po49bEXbQKQ6YijPpcNWF1j1NILGofDHTcobRE1RbCRlT0i9cwUx1oFAo+NdN9BktKvCxve6OnC
	IX+EvVUFGFADXbypbDVSIFMXwT+6Bs/iSB28HZrYju/hv03qmB3eYiTGj/b4k6pmBOygG5c5RS8
	e6X+Ga2VO/5HLC7iCU9+tD3xzip/4PuaXXWsR68pdOIBvCls8ERsmy/bRtwfXVNsDlS4Mhm9EDs
	EmeL4y7XC9Nq2N+yqmAHzInMf8F0ncydCEWtkBGEX9nh49D6Kc4pyLUl25owF8aEZ+v98IjHdg4
	REwF6lyUq4I4P7+Iv
X-Received: by 2002:a05:693c:835b:b0:373:9551:b971 with SMTP id 5a478bee46e88-3739551c52dmr2920611eec.14.1794204677033;
        Sun, 08 Nov 2026 22:11:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:16 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/18] HID: logitech-hidpp: avoid NULL subtraction in consumer key report fixup
Date: Sun,  8 Nov 2026 22:10:50 -0800
Message-ID: <20261109061103.2887636-7-dmitry.torokhov@gmail.com>
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

Report fixup runs for all 27 MHz devices because the keyboard quirk
is only determined later after parsing the report descriptor. For mice
and other devices without the consumer collection, searching for the
descriptor fragment returns NULL, yet the remaining length calculation
subtracts the base descriptor pointer from NULL before checking the
search result, triggering pointer-subtraction undefined behavior.

Ensure the search result is non-NULL before computing the remaining
descriptor length.

Fixes: 42bc4f3129e6 ("HID: logitech-hidpp: add support for HID++ 1.0 consumer keys reports")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9f3ae8724dd2..a1a69705338f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3866,11 +3866,9 @@ static u8 *hidpp10_consumer_keys_report_fixup(struct hidpp_device *hidpp,
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
2.56.0.506.g506a7eabc5-goog

