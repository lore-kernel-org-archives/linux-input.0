Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380195;
	b=JJH+EhzE91MlclfTj+6YX2v6vCP6YqiSekYDFAhE3+xTFwtM5B9N3qa5G8tpHUW0mlpi
	 rtKct9H3zx+YyfIFC7W41MEVHobmeOqvR+/zBh7a0IkaS+RGW7V1bD+tJ9qXRGqFFdKKD
	 JF0dcPLCDFYk2hyWfSJSfeClOb7tlV4lWXZXqv97n5DZhF5XQ/5qLwHW0nL8iy83Lh+gO
	 sAsS9OdJtTub1haU/xpGc7DlzLYdrYJ7zSosRSmvUOH5kx9Q7I9V7TVURMVraAorVtiZs
	 jHuc46vdM5rKUjUq0psVcuBOwUjuTEiv4c3sDILgqhahB2PGrCGWHU6gTpZIJxdOBVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
	b=ke2r71B7Ts4YMURgRqOXb/iRdnFUD+ZhOdXxgsrBe0cgVoSUED/OjrRoBv3pn+S/logH
	 1m3441LRuhq2nSDGRRwImb4alfgkpOFXxxCUMSXFAJKdlO90x/2176l16ayHWp+QNN0fG
	 4XONxaeb4vCXm8qOzvZS4+37ynJcw48JjDgmG2HtG90Caf7Mg3yqfjvtDe0kbnD6RGi8L
	 BclSjl6Y1TqeDRNB4r7/Rk23XSzfnGMRDtUAcuOO1Dd6Zzn9M4e/tz6ZBAKuRHLs8SjqS
	 A22ALSfM42rOxHNZu7ZWN2F/tl2xSR+UwQpnHWo4Wteg0xEFCLqbFwE4FwC4VAEMKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alDg0Nkw;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E160A3810
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9E160A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alDg0Nkw
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2810798c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380194; x=1794984994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
        b=alDg0Nkw/Goh7tkzFfaMY2tWf9hxbbeUgJuknoJjkC9RHcCOsi5Tj4OduEHh6okdZe
         vQbUMgqpB9uKGBfVWNE9LREmlO4f33LRHjpnqPi3qFC9JmEfWxgDvuDuqkZA6di5HG2L
         +XO5DJhq+GlPLq9OoJy4HkCPEJu1rDsMTT8ADXuAw2sZZ71R+UUxOmvJtYukgcvrwLYA
         +4LZE8ZjATIpClxMTVruGIbHi5XV6yvTCDQYdhFswqf2ThdZ3kudeOWsGRDqCPsdymHq
         38Qdz9UkFc0eLh3anBhNHh3UX51cV/efXNIjlLckYBYw3e0OF2jsaQPfpHGBzWe2NwAH
         m48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380194; x=1794984994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
        b=PUF+qdhMEhKiNJW/24mdLlcTRewjkKkkGHfKWQMJnonSUTk8CtUO77mhU+i3uUc5/J
         gyXAJSk8owhZ5Uno74vVxu+uZz3X2J70RIycrcl49cE0GGXFk5RXBw7darbI7NY2Jm/2
         PkDQ1mhi2LRksIVndp3vSXeOS3mhO20fWJt/2ccqjpOnT35Fp+oTKtftdAIOKySujHNs
         7JhInOy2j0hYgXhKKjQ3nb9W26BOHlsg5b6/ZepuGF3CsyxkOkxB0rC8GF41+kNRCqhs
         feGeIVyngVmkebmNZO9MncwOPG64RLHn4p5a0TLq9vfqq8CkzGox6VeH/a+6U8qADh1/
         4lFQ==
X-Forwarded-Encrypted: i=1; AL+hErGlBu9JJubCHEkSA2x9RG0fML9ANV4Zos1C/71fqKzWDP2fi8JbsFSI4tvkZIA/k+e3ZR5RSPEZBOK05g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/uyU/ZM2LusUHv8S0jYLX5j/oeKNeDEM8GU+kvzUur7LRlqUrm
	cSFvHUrBlaZHY9VmmuqE8i/RXfH1Opa80ACKcPTg5g+uSNJACXwGyA+2
X-Gm-Gg: AYBFou2cMmDtbABcXiYl3zntLcI3V9EkpFra7cmNb46H9De5+D+SV40HV4YxXdnvEur
	Spnyg3ko0CpXlL7yaNX14UcrZJZvYvZRjipUtPuHhaDXvM9uszjU4qVRrOvNjDELayf6WIfmSJo
	hBPbgw0gFo8HsXja2TxEkkbpjnLxGcDWhDCeiT2h/expORfM5zHWuVCOTf+qQx4vh1MT664wvxt
	Wd2+eGfiiY7PJbWJx7wxLKoqlb6o9KEVXCSpoRXnTUriCT6/EK2PzfVxk1SrcxKy2qlkOFol9xj
	b+OLzlpxiHVfMTC+vUU+F6odCn+B/uDz3EsEITMw6qtJXR7l4mZd1WF3HASHtSqLZltuk5D5X3T
	hsMU2EK0yfLDyi2VXQn9sxOLb8IwCo9zmd/JOhWA8Nvw0OP7EbVI0smwH7RvR0j4O3MNQzgVMII
	N3guR6vHwttaPd65rjwuUha8/v4SdDugOWBe+gM0GbqIWSfLTxdv9Le5x2ARZDD2HfI/YY4cnjh
	nT4NqS63fAsRH2CJL4FxuVufDj/SPFhjdkPfUWXtwav3PGTMOybeg2KF+mH6a+VWKr+UeaVsFls
	vwAHyCcIxCsMKciVqg2pNo2yzbka0thSalVYsVhqgDhMiB97O+xo3RT+zWJWQNRC4JYfymd3k/G
	6G8anGIzTfwtj4zusqw==
X-Received: by 2002:a05:7022:e805:b0:1b2:558a:d769 with SMTP id a92af1059eb24-1b3c024e6f5mr1663279c88.4.1794380193835;
        Tue, 10 Nov 2026 22:56:33 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:06 -0800
Subject: [PATCH v2 08/33] HID: logitech-hidpp: do not retry timeouts and
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
Message-Id: <20261110-hid-logitech-hidpp-v2-8-30743e91d83b@gmail.com>
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
2.56.0.542.g3ef89b7020-goog

