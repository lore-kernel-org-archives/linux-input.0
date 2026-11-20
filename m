Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164069;
	b=JwWQlsWeM31Ik047b8kVmoHFAWV8TASim9mMMzT1vguYuMG1J4HgOptaFko2YqYh3NX+
	 gi2ArzFwqLOx9Oq7oSyDIENhnIdg5+AFeml8B44qFxNuxRoae/GtTsa+n9DdCzD8FhT/j
	 v3bZ2Hax647lkCHN/qFkYHAxH+pf/Bjhk+Hc8wxobaWXdV4L6pTJjdQQ8ayBxakiv/qa3
	 Bp9vgyNicu3+/nw7s0PEI2R8mPBI10VPrkZFTXRNE4Rf3GVpxSf48JLENI4yqQTRJTfYp
	 d2DRRtDXhC50YehKXZ/F+6ujnodg94RMthIa/3q5OmR89jz5v6Ifydyg6uar+usD+aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
	b=TbqeLax8sL9SgWKq4I/Z5q8C/nSIrFVVpR+rq9JWlKz3SLQ/+bwhxqpDfbawDn+xKgGS
	 JObzS1sNYVmEQ94Hn+LI2lbB1C8VDAZyNqPSBu542LaxzjzDTyd2CL97vvpvPm7N9z1P5
	 EXWN/rlgXF3a8VC0tLcrO8Jsuz61W77INv3lz4cYasY0SJixHW+h5p16S0rF9KZkybx+y
	 cizQmks9/hqDzXzec+a4ak0pYNPuTFOgKx9qBmUL66yuQid/EyTzQfFRpIPpVjb1uc2mG
	 he1qH+Rsxh2+DF4j9INoQ3qAbNxJ5dpZzqFPslYvZXRO/mbJ8twMTD1sMt7G2SMCnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDbf0pDW;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D760A2611
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16D760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDbf0pDW
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-372bdb942dbso825139eec.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164068; x=1795768868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
        b=HDbf0pDW6HRvSYER+4Zy6Bhgv8bbnW5DHw3wmlOWnnSjh28UrnreoWPPR3KIK3CTp+
         tOFtoFVqPoG7g5v481mOcCqC/RJwSYvrTzR0kO9ANWnLqXpe9wo5cAAxq3l00SER5FGf
         ApeFM2fuPH4cBLyU6pMq15YCCweyfo0fN7u+tjGMNu3tO+8tyJaCHKHbLsnEv0S9NHm1
         oqWvmQ73wt04VjtGP1Y7659yFGbSdOeauRpgPGQ2Niazh1k5rv3cuijUtexEEaiHTC/i
         o8LKwNde3yrv7D9Lved+AP5Bj2sb6UZdpTjmGMK85y8GOnQBsU55IpLos075iVRbyNIl
         JC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164068; x=1795768868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkzLSGS2/EtfF3lDjWx5RTNsXPS6BLA3nJkka+odvM8=;
        b=2p32XdAi59HEkSfcvAUxgV3YtKogNSgL7EUuCBhtNeLGhPAky6dh9TmJ7+r4F74jBS
         GOR9yq4ZJNNz+zpyeUiH5q0EtKrdLesNSDKo3woq330aOvvVc+d0o5Q3i25Jsp0QJMwj
         W8X3wnmFjpr1SJLKqqqPEtS44aHpg27wrdx6Zb5wRVbJWDEotJzjz/KrsWgbxJhrGe6o
         uhdvrYZFh1r0DvtTiXLDvKiaRh+J0p7JgphfnpDMxEQhpoHl94UehqmHlcrj23/8IuJm
         m8J1Ns0UDd01RhJFIah7VquSW6KM4HNWqINzfm+0N+MAc49ucAmN+vRgbfFSF+CzIS95
         likw==
X-Forwarded-Encrypted: i=1; AL+hErESkSDv4/dVBwtUXGuqy1Q4J/TG7WX/Bq8Iy0ytyBjZYO4yeoM2XBHpn/wYcXeDiI8JS11pRBhpTMeB0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+X7fChxIARiNHZluT069jtZ14D3OPTbN67+bkoMtuyhRP/AvTD
	eCM/TQqwXDCYoIiw9aiO++5Xe0+jcejUXwkd1muQBMdvjzZmbSEXvQMZ
X-Gm-Gg: AZFdTZfv9rKgSX0Shl4N6ocaqLOn2GcLlPNa70KZVRlKmVwtVkPDnGn2y0DPqY1f0la
	SymKMm+4yntCFodTsDg4snw0gW/P7Oof3soZTqMBo2av42nyNbSFLpuVPRNK9UPF272bfm8H2rG
	PW1yyok8kXjXZX28tHJ23C8NQB99wGtuP18GsSJ0ixYZfdv2H6HSmb/6v9t2if6nS5JaHyVUuMJ
	k/CWZfgAgWXbAZhCz3lIbP7rkT0Tk6m1af2hwJJvZwrA7pDisNuErwxuSOsmfjvpxxht667vqiA
	f2f06DIZ5cmGQGPNpj64KgmUnHOGqrllna0bGVIkUqO7WALDrS06e66Vnt6UuiNDtvh4ZojaELz
	aIEfhpAaD22y76ZgEcABrKELgKXKMWV3ViI7cR1dB8apiyxqi1tNM61ylUV0AMaLlDemZKLzcUm
	SnoGltGi7xDi7LXWwFUtPFb4BbkKCC9c2vLAC9+pDQVrkq8YMzga0vswBTWK8nfipCIPKuvwYWK
	SBcv4NSLPP68lyqMYEUxYHNx13B/ANLz7oPBOj+E/yuGWvsVJMKGu6JiRovasW4Rlu+JRC1Eflk
	w3VQj9vq+cHlhtuOkEk6gwztRF5Yz5FyBUkfX6MgjimGGIGPpqHfv+X4ueDIfvOnj8r8SbvxOUo
	Q8di0xQa6ELye9DyKyA==
X-Received: by 2002:a05:7301:18aa:b0:384:eec:aba0 with SMTP id 5a478bee46e88-3857073eebamr1937266eec.36.1795164068086;
        Fri, 20 Nov 2026 00:41:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:07 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:55 -0800
Subject: [PATCH v3 07/14] HID: logitech-hidpp: fix off-by-one in G920
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
Message-Id: <20261120-hid-logitech-hidpp-v3-7-cfe2caa1d0eb@gmail.com>
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
2.56.1.750.gf70dc682cf-goog

