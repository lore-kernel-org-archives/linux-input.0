Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380195;
	b=pqOatkyPnopxN2mN5jSQXZlRwmS70fykZId5Hk+9BasLSUvXMoZb2tZboe76D4pNP2jD
	 i7UaAhT3XM3D51/5opyY4+u0oZOyQ1J94eMzOwDssRbbUaKLno2tZ0iqygZzp9fpjHhpe
	 Oo6gLl6wOXOGjHSXfDAlgUGYTI2pK94wtHvB1Hykzd4gy8+IOeGlSRhfwLawUc9ikUpgx
	 3lHhQwGCgImTvHYCSd2b5Z9THWlcUBLqh0OEQuCtJeT19MhGc+Oq8m5idcY+oiouoecBv
	 kBL+D8h3ByiKYxPQo3b8iO633tAglxj6Pb1El/ZdYCDw4DxMXR9XVhbh6yXHdZvIiAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
	b=pM7XwPBIL/Uo5lo6XGhSpeb19cnyplOh1lBANyKIMC5JWfZjogxOQTKTEk0mHzH0IVhg
	 ur+cMybVsX6AR6dHDsH06Mi6HLx5Wl3SOSQoy09cB9z4WutUOjHRL2E0D6YU7t42IsgVs
	 PtQq79MI1SgJQqOP+no2cfTdaUpkd2//ml4hFC9OMkq+275yPIXvRgOC1oklhgInEMaY3
	 VabCB18h7AZowBhclxs9zA0OhA3DL4Bbl3RX0D/aRD4GglkwM0m6Q3S42co6L7K0xjohq
	 nYA4VADa2RsVVynMOEbkEgFwJp/fCUOhcMBVw6776SfRlz5EECfMci8mznDC9p2aICw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgH4CO1L;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD260A382B
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAFD260A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgH4CO1L
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso4759071c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380194; x=1794984994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
        b=NgH4CO1L6/IdLdAq0+9WpBqbnVs+8tX53Goq7wZ14nOpJL7byez5VZqqvA+zNRd1hQ
         4ArsNOTRtWHBsUTyvuXab50p19fxL0ehexshnh9DgpdmXtqIGwiXXEHyYHX+I5LxsjHs
         Dlc/xcqKjvKZ3k7EGSa961+Dx9x/r1tDBNsPrx15DoqCOTGZPwf/ttLG1ZNx0q+p40+C
         p2xkHz53ea3MZYUYoFX4qOUHokWfk7VHolb6p9O4I6o60lPLuLtvCMpMYkNuBFRYFT9O
         AdpLrMH9/aoXuD4mG7e0BqUqZ8flktAuOTElJzJdKFfmrCiWT7quxKw6TMtW2G9YqMAS
         t2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380194; x=1794984994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slgCBSKFKl7Q/LA8mzeyeTKZo/SbrLrfaAT37+Tkw8w=;
        b=jROz/cSMgc1etW/C0xj90pC0xEUg4uWEt0TCBD03jzIGTREaYSkU4tVMfLUitNKj+E
         AUSPIdWp8GqKDPWSx+jk/Wxl2byECbZoePE72SHp7SprbKbokytx5S9ZLrE/v/Ui4Sxc
         opGubaNqVdEaJwBoNEIIIkznNN+Xr/GUA7YAu0Fj28hUEEsQatfIvIxGXGlcyTmBN07m
         r+l//htyo1cOvRkJcgvohvTRG20yOv17Jj0G7o2iUSg1YbGLP05ZrL4yl+TKSsVteb4D
         p0DWDG6xb0mySyUGS4N/xewD89PtAjl7MLOiHaD46zmrxq6VDtdQny26Sau3goFNVZQf
         umRw==
X-Forwarded-Encrypted: i=1; AL+hErGOvO7kWpgeHuvqTWETWsBHEFFKQdDu35CKzNSwVXLMjB33z56OGlXVRthfCuE56RElgb3uZp3+BzDKig==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HmJuLoAMgMxWv7NLgtyM+WlqDKr8WXJBBQ+q5gs4LJKJQKKd6
	5W1jPx133QI+MpDqfoMqaLbCadbzWJFB90pnoCHxvuitrLucCX8JO7ZI
X-Gm-Gg: AYBFou2gVANQ54G+cXUARVqaR4j3W1otIUhXlLbZryvuykdkh44NsenkzVRzLs7jmYI
	nDY1veFYLKopYbW7q284a1cZV0ZvNQvRs3TsEW07q4+WrTzEByYXyQ890mcI69JE4LkFw3ByX26
	7AAvHA4Wx+Ji1+XkXlNg4p0ePm3ycHqc+V2yUqopMtFIg68tpbOM43wESAyxSUPKju+gJlHvprV
	c/6gWaL7XkVPirmsQdapy1b9bXqxcioFAmsb6QJmgnK4xGoBmYzBuRNsppVAGt3/1XHmIpaqUXM
	/F8y56Ye0slj3aYiZFe+pdbAiysKKnPvyzGhxWJjdMb8XhHidLF4Gm14VYRYGAQy/rGvMykvCbS
	qrTMe9Cl+nMJbw57xKHPU5zljVANFiV1DejokVdeTXgwQWw078mf8D+r5DL5mSPo8ijcfY2MVDm
	laSwd4n/TwaqeBzU5ZaqDeRm6KCEP1uW90nJgzgO1ZbvQPvbrdxKAbUz9nN5MWk+DnVCkFl4Jfo
	/CPrBltv0D19/5xZPIpkxiyYezrqU8xA2Lqe3ReUqPms0KlQyH1DEpZ+d/Eamp4jzubZ7NTc2TX
	M5Xtsp1srG2k7AUSN4bnlmc9MgdJxQU+DQXsKrDrbfrBOxdwfeFMoWW0yRPgfS2MRm3pBfpXCSn
	21hqn0pA+dcMQ8hRyUQ==
X-Received: by 2002:a05:701b:4587:b0:1b3:b6d3:b91c with SMTP id a92af1059eb24-1b3c02ec7b3mr1467863c88.7.1794380192368;
        Tue, 10 Nov 2026 22:56:32 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:31 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:05 -0800
Subject: [PATCH v2 07/33] HID: logitech-hidpp: fix off-by-one in G920
 force-feedback slot tracking
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
Message-Id: <20261110-hid-logitech-hidpp-v2-7-30743e91d83b@gmail.com>
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

Logitech G920 firmware reports 64 total 1-based hardware effect slots,
reserving one slot for the built-in autocenter spring while allocating
the remaining 63 user effects across 1-based slots 2 through 64. Because
the driver subtracts the reserved slot count upfront before sizing and
bounds-checking its slot mapping table, the 63rd concurrent user effect
is assigned hardware slot 64 and exceeds the stored limit, so its slot
mapping is never recorded or released and remains leaked in wheel memory
across device close and reopen.

Keep the full hardware slot count for table sizing, lookups, and slot
bounds checks, and withhold the reserved slot count only when creating
the input force-feedback device.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 53c171dfcf96..0264e4541edf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2872,7 +2872,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots);
+	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
 
 	if (error) {
 		hid_err(dev, "Failed to create FF device!\n");
@@ -3486,7 +3486,7 @@ static int g920_get_config(struct hidpp_device *hidpp,
 		return -EPROTO;
 	}
 
-	data->num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+	data->num_effects = response.fap.params[0];
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,

-- 
2.56.0.542.g3ef89b7020-goog

