Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380193;
	b=fGmF4NSOHNJv+EMTTAwlfvXZ94ZSSGQe4NeibgvFBexw4MFfIcVMzqco2hlOEGe8if0u
	 rW7MR3/VpdpjFeOxgyKFyj1g1j4Pppj+07SrONYmutEU9Flxmh7PgILHzvCgyHUTGzuPI
	 7lzSbJz+UHUJ3wJnKegurKxbSUgCTW6nH3Q/NMGoMoCUu9qcWbTSyn7/ddq3z51x7w22S
	 HaP8f1eHEHRRHzwNyrLCiqNnmtQMyYQl+0brYMPEa12+KeH9Vix7yO/2JQtWua7LPftev
	 V6OXEkJZ6o7MIbuT4Cybs9ivz1gDvhibNc9gtOMN6aqtjJ7Z7y8uRrvqsfkYWhvmtMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
	b=e2yw98WqGI3OJaTIw0eu/owvfHyx1ykhczuYEbJsIPiS9ffWNNJZ1awrA4Zj7/qBJYsb
	 M4811X61QjUKl9qirWe/ynLeTwO9gI0qCra/BRG5xZpKfV9/p74P9ehmo2+L0yFD9SQ/n
	 JMKzZ34t6fkfjTldcXTucqWF7z/g21LiTWWEP8TjPpi0DGAL6T/LR9RZg756QQd1vPEkf
	 lQ1n+0vMuHtExF+NArZbWoeYI6U2kiLfchtOI5E6vzaSD538CvQa1Yzcg96TNezyrtPT7
	 YqobxWnKvpeU/yDmdAUnU6V2qMwopVz4VZxNdokS28TIVy7dmi1zVg+Y764xqV//thA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SsBkwh+R;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C760A3814
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318C760A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SsBkwh+R
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so3679345c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380192; x=1794984992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
        b=SsBkwh+RkvYyTpBTtc/4YgnN7aLAWLHZYO7IaApfZg/2+mTAURxhK77U4LOuamHTSu
         jkFkqCfyuaMmtT0wzFNdgVG7m+iuWt4idS3/lGzNjhfCRRgDTLRyBOJas3oH3WKoL2uP
         zkj3mIEaV/jebvGfL4BvKZ6nIZUfw8qc7jNHIvr5JGMHJYYdhVTgtVfmD9Za1zaIM6Rp
         DDI3WFIcsBe3/fSsOo/440Mz6TSKbTXDzC5bE+50fn/VvNa8V+vb/LCtusu8KTWhFqzQ
         tkG1oSN8dvPWpgWUA/UITBPpy5UJK4X0H83gp3Yter7D72wb1o9nAIdY7J6eQVz5NOE0
         3eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380192; x=1794984992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
        b=Kfabfvl/RmxgiHljgzbdyfogO43bF0FA42263Hf1d4tDgw78VxL0i6CNdlspLoIzDS
         TgihCxnnwLOTBbAH42ZVja3ElPM2CtJFNk1cPaWWkF6TQnjyJcnigxKzKw/PDaLvL8o3
         R4ssZIEF55LeLbhnWTPyUlDAZYzBMN/zBPc4La8b8HH/SE0XbDYBE+R9lD3Zj4Ci91Yt
         WBVVE6z3qxqAlMEpKq0KTYGecUmb3nFHGdu76J0Hkuu8YhgSO9E7m30sA0TCzoVFG2B9
         DRAKqdtPJLefBsEMRLtqMN3go1P2cnb7liTMDA4RZQlH2cN2zqbWchQCOfFxClFiXMGS
         qf6A==
X-Forwarded-Encrypted: i=1; AL+hErH46TsbE7iKAt3kUz4r1kex0Et91R+pHRLktezBCBokUs49XuzZn+33WaFFHN/0NnRwXn9ZpjRBiE8PIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+m9UFs66tmSGgIhuZPwNbJVFOEzmnr/yTVTNPzOy6quoy6vSo+
	MmtwD0zhYUoLubC8UTve2+UJGMGJdDMQdYiYf8/YimfQrH6BtBqC0QTO
X-Gm-Gg: AYBFou0zL2R0y2swqjyhROE7SFko+zRGtbk/TCKC6itQauKMlLPuCeVWMd3uEhi0H0S
	KhyGp/67FFeVgVk7EkVHEAC7VdXtWZaTOdaKxnIYyAwsNBafjTATnGX+jcN1gWn1IeRhPXP3YzB
	0tv/wyI3ASejUZCmDDqZKC16U++GPTXW1H8vSd5QDfpTX4xa6kPw9+7TUqs2SbNzay2QGb4SZis
	Ty0yDikLntTTOE+HOGWdSIs6O3xQM0vQ24F7jiuiw5lBTJL9BLRylI4rJ45BtdKk9coq2PldHtz
	lo5NksdetiZl0AnE0RUkH+YPF3vp9ta3d96qk6KVcVPV78ZJupeOPV4fAhqQkH8GVnr+m90an1b
	O/5yvKgbehG2Kt76VhAOkE643WrJPv0Yy3yiKsCDcEghnMLytZ0jyHZB8eD12JHrc/50xqk8lf3
	f3aLbPnwmCRmxx88j/nlKiv0lpwobP931bjujMztfhRVxm4XpIglVximjpep/Ayt8eK0478p2uH
	B/x+M6TI+dMoTyWDhzW/8eR3y9L7Xo0Gnrda5JLaWC82TOoo31okbFQIAv+JN8FaCUptpjYnGbT
	C2/SKzvJE/C4xGUvTajuuYT6+0hla3k3qBtJnFyDXPeW+ih9JDRJo3L/JQCLRodkTJDuLzyZfhs
	RDwyBzTo+WYZwfkBGYg==
X-Received: by 2002:a05:701b:4513:20b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1b3c023deaemr1635953c88.4.1794380190728;
        Tue, 10 Nov 2026 22:56:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:30 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:04 -0800
Subject: [PATCH v2 06/33] HID: logitech-hidpp: avoid NULL subtraction in
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
Message-Id: <20261110-hid-logitech-hidpp-v2-6-30743e91d83b@gmail.com>
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
2.56.0.542.g3ef89b7020-goog

