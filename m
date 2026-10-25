Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896531;
	b=G7QV2WzkXDBAxhJQCsnPpRE1wa4KDK2mIIg3QzvPjh+9PPXriVlhB3wBIwtkV8CjOEnE
	 HFfKFiwDtE1m7aqmnjTbgx8ERw/SPbOh2ARzQ21Hpn2JeX9C4PZ7EWYS5vif3Wxg1RZTJ
	 gr8Kovb3wMpG2D8VAngYclX3NHSKlALoPAdohX37765VHLjAXbmYuMrFGWp/pGTXNSDab
	 neTfKj6FjhZulodPgxyjpTEl8fDJlou16PGZ1vsA0TjbWTv+xtlU8SOB6AKOOkICbgiFV
	 3o4CiOsOvyTqov2hrs7xJerGDlH1b/SQk+x5QhVBOdP/xzqeUUKLeiGE9YRvxGCru0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
	b=nCflkx9SZUQRCBWMuVsGIDRnX+KT7aomc2IP8dEAygdmjB6YFLZ6V9LSv2yDL1hUAZJB
	 g6vjpig8GTybQm1IuCp4eaolmNNqwGi+oGgQ3xserCx+QIGBLahnDuqmzPrbBtvMQBlgX
	 lKC5pzwXrzvQxt28dKTbBq0OljFkonkI+tr8HYlhFahCLE5QKcq7Bse1j4b917qU6lfv2
	 ++cIxdMWkLXLTuy7uX3zIYqVZteENke6Kop/AsgvR61gQBp3oev1+Nrl54bZUpwtmKPlK
	 CCETmhvQmJ6bR5/mhnQ6FMXTFfmMd68fBaUBkxq9O6cLGPGSZj2QDGPapQQutJrNBww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8D60A2609
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B8D60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3281703eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896530; x=1793501330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=D13wWGtzDrlBw9Im7u0R1IdFHg4wNG1163II6ub/nPI2fH0oV74hQzstoAqgvSxI+0
         myknq9Ug9x38jjUUZwY/vyXKIDGMNo3ZKXP0bAWsSPufchByNmfUqbjLR9h5DiQc64wx
         b41VuTc+OHb/42Uk60MIIq5H5njnW+qeWoLqYxKwISqmgf8YvNXxGq+BL+Qjc6HvXh7N
         0UFuKY7bms75KP1rs6qbQXAEM6K6vURDSsJu7wqzwbTz0/lIFC+uDNdCBWcUI60PHNnA
         Gm3DGTK35BKOy4/WnhcBiampzvbAyAb4nyB/WhiSNzemLHUAH++XTonf9uwlP/Mvv71a
         ZGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896530; x=1793501330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=upa5Jh1H4O5+cK2s4JMoKPczn94N8no+Zv3F+GfHuWvMRe9m0m7NlttmIbq79vx2GI
         iHFt9C4anCwt/2BW0FgLd2O1j4rF4os1e+QwZaYcrEJR9txL2O/BAOAnFA+Cl3XyJg2L
         I6IEY4OF508GnpQFrDZO03aKIbM/0j8SrzFEHzGts+GEFGz0tCUGFKIYfXHBprBEnx4k
         jGortPZZt23j9Iu2wbC9u6Rhgjja1V6gW34m0JghL1qbyiROzxPJwvPOO9oj4yD5DWAQ
         nArJCwdueskOKVmt5H3WBvZFfy/+bT12rPDWQTCMWGEDiiZ5BumY1a99lvtMPmiPi3AU
         dmDg==
X-Forwarded-Encrypted: i=1; AKwUvBzW90DdS7R44BnnfvvyLbZP3gQwU79goOK30MZ3iviZaWyp3o6xfd78+cOu3RINBNDWJhUPeoY2Ym9wdQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHVA0DqyT9FjhPrVAAwa4cFacUMWpYgV3NSDaJJjACmlbeB54n
	QUkh2+lflBhjAJ2zF3IyKC6f/IIkWZkKQ5aLWzRW9927cCWpqVeC4arz
X-Gm-Gg: AYBFou1E20h8GEu59D6BYTlQxrI3Bv+W1V8+tSEAFBROLzAR5tUeKmHbj49wcQfRAqF
	TKIiJK+cpDzrTMDbEopTrIym6zCEB5DMKJJQ4Rpz5I/Z5E0Hel7e9z1H+NJRSeh1ISVbpPlFzuv
	f83x9nlS34m/8RQSyE1Pe2WEwE93a0z7OpE0iYkjnwPUQEWgE4/t9eApKTnEE4sIcsbZeG/Uxmg
	xZj8yyKgl2LB/MehT/Lfr406DvO2b2qQRZIVaIcCZ8x8+E5nADdgPFgm1ahME/mkxTY/uPUGPS1
	gNv76I3W9ggTbSCJmEcXGSeWFXU3rNkfsumNfBydlLxXoAy8tLWv8cVmRBhRN45Daz2JNqDy4Je
	qPdv6Xy5gE/CQT6nWgyBb6W1bHHPTvnGIrqcqa1Pg3buKNF5HZJ3Pc8oo99dWnyFx/3RAkjZlZk
	UJ+0eNL4UoS3Dka5fmY4K4S/39rzBWwFtD/4E9Qvqao0I/zFMLMfgrQbDEUfBjGc81d/AnxeVZx
	ubHY/FmgCUgtiJxx4n1+B2s1AuBG2LBYkMA1MU64nJDfboKYjp6HtPWRFHSapIHFp4LxsKBXLSA
	0rnrzQk/pCzqRo3jvRGLFeCN/zbUevh871luX5RRgRQ=
X-Received: by 2002:a05:7022:7f0f:b0:187:c940:21b7 with SMTP id a92af1059eb24-19934e71e37mr4620736c88.9.1792896530109;
        Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:42 -0700
Subject: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Update the prototype of i2c_smbus_read_block_data() in the SMBus
protocol function table to include the length parameter.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/i2c/writing-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index 8bab8b16ca8a..896bf79ea564 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -366,7 +366,7 @@ in terms of it. Never use this function directly!
 	s32 i2c_smbus_write_word_data(struct i2c_client *client,
 				      u8 command, u16 value);
 	s32 i2c_smbus_read_block_data(struct i2c_client *client,
-				      u8 command, u8 *values);
+				      u8 command, u8 length, u8 *values);
 	s32 i2c_smbus_write_block_data(struct i2c_client *client,
 				       u8 command, u8 length, const u8 *values);
 	s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,

-- 
2.56.0.257.gf7497c7d27-goog

