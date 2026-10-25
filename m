Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896546;
	b=2qwdbu4Dp8u3gvbA45yPqJzSZC8p7S4ZC3N5jQK9ZYSIo0/koLwD62c3QqSOGBReOoJA
	 DuaEcPFDgy0XuYg50H6BF5Y/W/lehwsn1zWXCna2zMokZMJyDyuuNVzH2TawzyZpxw7O+
	 8i2k/ypVVUfsRkOMInj4pM9vYfYcPzdU+nXW9LX1NvWjUaQ5BzmNSptqZto6+u57eNcvR
	 eR6WRAn8Pg+AY56GBKGbedcYLtyNyFmsd3eMkrdnviy1fRgWVzSDjCJQ2uv0wgLpkxw6T
	 ASaAA7BZaw+U/K5YExvKavyworiW47OZ4VC0sZc1QwxLygwSrNVtHDNUsIRt+SCSJ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
	b=ajc44pJmQDNDEU+PZbxuNsiNxH6AIQIsvgByhye0DbF2gzhEdfZYVObljOoJ/b6QOX75
	 DjDaG8vmuPyn9V/bsu8H342xX5pCt0YUHHQjpH/6bNDBoJR2CVVpE0soTmm9r8rheWwOF
	 hKwyXC6m3Ngn9NJxA2D23tNX0I14Q6Bovteq/r0H0J1BnaMGCEw1QgzfwammfNUVwtVD4
	 nc6LjnTuYvuXngMpPkV0tw2LLADY6HzOAtLqs/4HByFzXZ+mkho3C7exv+IXPu7xgHSr8
	 S0rG6te4pxfMeTEV42VXW9tdN7/sIQvalmD8U1Xe5R9HuxfaL49VqkD2fticUzDo/jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05A606A325
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB05A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRUtJt7G
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1931ff67a29so4101428c88.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896539; x=1793501339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=MRUtJt7Gkp4vafFe0rMwqOvDHoXxAMNyVJYKgIxP6STY7JiEtaQfRGX4Bfxa00RzZd
         LL9z7cyZsOY/4U6jo0Y82ZKnYeZ1xnNi4d2t5k2uSo3AfAtxKMndyfDNAgGYy05aj8O3
         +NOHRUj7mM7v7fo+STYhhLtoX7v3SUKlWkXZeFFQzfGnr+1EFv7yXE1lbrNRa/fILIlL
         PH4YGconi0OlzRG16TfoWqLahojfLcD9IiRsXiKBSsaWXiKATHLwZ+qecfhZ4HPZyt5D
         pN3gc5vWiZm5akOtpG9Dj9qY7/RqqfmML7d/xeFrZiipH2FEafl+aiMOHS0bvZbGQNJD
         kWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896539; x=1793501339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv9yLRfHeZEkf9phVasO/TM2yP5oqXz3F+WdBaktVTI=;
        b=IX7ydUOUXAD9Zkz3wPusjwoWYlqSwaUoHand2p5AwoZmnmbqcpMX8J6fFALb2ukB/p
         6++RRKjMIUpueFH0ZL3z+n9gG+xNLgaJtKwKCIZoAf009OV9IEnyorCCno9UiTWQVW1p
         JKVUj8RL3we33Hh5jzRfhIR26ADGV1wx0Is2G8dnQrr00Cehv2DQlWhCz5kckuuHe3Nj
         A8Q+6TFOOUF6IspVMPPilVkAcLLx0e85lUKqsuJAU8trMvxQ6v+c95c3EOPII0XJ6mmX
         hhiGAahpLjy01jQ+3XczcRFkqPo53+N1DohcseekMK2VzlVImnAHhzWzzBn2QesfyC0H
         MRZg==
X-Forwarded-Encrypted: i=1; AKwUvBz1nNjlsck6aDlj7zvS5z9O7zTvaEz0JL2jaIkEZ0SIbUoDcILjVusHvONZ9sQmxyZVkjHrGwmnC7gsgQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLWpQObZLdkuG19AVwzi3OJkCYSMGStzAgRWE1BpWyHwqnSizX1
	KZAATtVpWBZsVvBZLsl4NmIYQeqWZMfpR9f7TWC0ziPvip1XC/g5rHsz
X-Gm-Gg: AYBFou0pCmJaYDnPFIsvDj557j5dQfs0DjGaSjk87IwOAPP06vfVjmR+5KZh/2ZpgOz
	b8dWE6IST9kyDpMlIC2AAzY1Ucus8G3hb4v9QcvysZo9Wna31yJxQQQflDkRGQwZnJ0TWTZXhIp
	NSbamHxuZ/cYJ4kIQlTOZbTQouUCZAUE5GkVr8pbNNlCbrNuy3ht4Zby+FqJrPBG6RnpBHVKz6y
	7pdOX8rq1Jj7AhYuFBLtIriSOOYEyyet9+UuVyiXX9Ptubhj0T5Ey23/3cbIJKDe7GlPpiCIj/v
	UIubvFxL5MYgp9zn4CH+f9vlu3WH9Cjb+uItnJTOXL4xWd+un89uJ+5PpZvVb77+mhfR5EPXip3
	bo3ulMKJihoR79IK85Nj5Bo0G7pPS6mXBvRqxETTg3iWrRL9SC/VupAcU58AxgHOXEg+sO0sGTb
	WrA89A2fMfIrbPcqToabGjrCa+EFwmLfuZ/8x8hPBpKOC3UgK/NJt75vmBWZCyhBUrbkANMvaU/
	GoVco4vuWAcz8WRafhKOeOBzsaPK3BJDUUI3F4VwIKxy4K4GLhVE+DihjSbWwhOfzz/XnIAEjCv
	Cd8EzNJ5SdYVHotUMpuCNmtBdULjX7dCgrET7Pp2Zww=
X-Received: by 2002:a05:701b:21c5:b0:194:b2e5:473d with SMTP id a92af1059eb24-199298b3af6mr4872191c88.5.1792896539394;
        Sat, 24 Oct 2026 19:48:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:48 -0700
Subject: [PATCH 8/8] power: supply: sbs-battery: use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com>
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

Pass the destination buffer size to sbs_read_string_data(), and pass
the buffer capacity reserving space for a trailing NUL terminator to
i2c_smbus_read_block_data().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6714313bb3a3..f8b194c58a62 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -424,7 +424,8 @@ static int sbs_read_string_data_fallback(struct i2c_client *client, u8 address,
 	return ret;
 }
 
-static int sbs_read_string_data(struct i2c_client *client, u8 address, char *values)
+static int sbs_read_string_data(struct i2c_client *client, u8 address,
+				char *values, size_t size)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	int retries = chip->i2c_retry_count;
@@ -440,7 +441,7 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address, char *val
 	}
 
 	while (retries > 0) {
-		ret = i2c_smbus_read_block_data(client, address, values);
+		ret = i2c_smbus_read_block_data(client, address, size - 1, values);
 		if (ret >= 0)
 			break;
 		retries--;
@@ -709,7 +710,8 @@ static const char *sbs_get_constant_string(struct sbs_info *chip,
 
 		addr = sbs_data[ret].addr;
 
-		ret = sbs_read_string_data(chip->client, addr, buf);
+		ret = sbs_read_string_data(chip->client, addr, buf,
+					   sizeof(chip->strings[0]));
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}

-- 
2.56.0.257.gf7497c7d27-goog

