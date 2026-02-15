Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796786331
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164881; cv=none; b=gYXf9DC6YHlw3BotjdlErr69r30t8W4iRc7NPtCMxjtR2gsU3JZ5b1vv9ph/4ABzQauJGhrlw7dsP+2nNzQXe0OyZASD71THizbsRgjKqkZsAetUMEbo8KUo24LyZpJcJSbCtqStD6iTndnnyFhEI3otxTc8PTCMcxgxHl2886c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164881; c=relaxed/simple;
	bh=6A2r0b8fW5xHTnnM0C6ApRyYCtMM9I2FxzQRNN2fBTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBLRN0f6ZDnj2BJ6MbaJrT3LX9uM2z/2iyOTd0xv+28Maes7sw0z1ZiJJWBalhB+OLdYKcxu9RPK8YqyDnry8Sx3WHXSO2lWUuwhiTwAmJwdfSBbGawc+CTvCm6iZ6fF1zXgTZ47kd4m03goLDSrJe3cNik7ASN5Qidw6xtnlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFGndHhp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFGndHhp"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so4154292a12.0
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164877; x=1771769677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWoDfTNPPzv0jncjGgAIqMNjO08bMdQvfqMXxIjt7AI=;
        b=cFGndHhpbKr6zFtOH7ebO5arkOJQ4cNuEckGfcfFL4itgLh8kyixws0zvhiSzqj/f5
         RcJ6OFovJpeSbthT1FbimLv8iAIf9g+N6453P+E2+IsnYEX8orHynEIxN0bwRR7l+2i5
         5UsFB0hfw703y1t/ReEcARwdQxkMkC2rjkYl+9q+yIEpHUqJAm2ssTUuh2jizc1lXlvk
         iuXvzJNdTt1b8ahD7NVkHZIK9+EWCcvUQ0f8lVlf7JddRXUcYrYX4nlSYqdklzrSeRy5
         1wgxqcwroAyfFJ0/zqghKkPOoVXujBYoB7zwXL4QtHRJqFiiRVrkM6v0RB3G2j16cVj+
         oLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164877; x=1771769677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWoDfTNPPzv0jncjGgAIqMNjO08bMdQvfqMXxIjt7AI=;
        b=FEguoAe9JYto53VhLPwYiXFHOwF2moo4n2qmzBfOSWgpA6Kxyfw56vqBixKNNHLV1f
         pn6JKXsAjefFwZusawxB4sKiz1ZuNiBMKWA7PtffbSegDe1OHhiZgWSTsv/zvRgO90Hb
         IDOH8ALzrwYTFiycBvjwjMkYU779MYyev2YFu1AWS3m/3fO3gtR0n59zmsvG9H4woaGD
         WhNbjfJShvpqEWygFgVcuOhHF5PTRsJWTo91agM1npnlD060vD7280hNYsbZIsCKqrS1
         VWa/5w/26dwtIqPfN0gDmXAWL/JTXRKpR5VCUYJjRbrMzSElPuI2RM8Q8pGYmnStvKhA
         MJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWnN4dVCM0TEBxf8M3Q8od7fIL6Yrcgn6zAa0ApOTFyEtikxX91daQ3Bwe03031BwDwQADOOZ93rrRVSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF7sKSOa0ztUqKAfOtZdoId5qmG+h2eF0rnoqbYQUrjv/dWnL
	7ftlfEYPmc5KFLeFCQOYq355uXaTrmaIEBt3hO0X7GfaFJwcfhLIGzq+
X-Gm-Gg: AZuq6aI7FTMVCxMmwXjhpg4a9uWhHa4JdFOwr7/kjkxG/6supICfXh6MqcNwBcM/uvE
	F7X9upIDaMtrW82cs0A0kaIgr7X4YImrd5p+rza55KjO4+gBtgzqOCIsPnJDgkeQU35zDgl9dog
	Id0YVoI3j7YtAeKktxuN+Wy6jAIU+sOx28DvbIrG2ZQVuJJMrYaYBnx71yuz55u7oezHO5gCDAD
	KxgRum5XZKvFrdk535y3a8RGYIsX1Oi3qAD0x2yMUxPCOhcsB4ii1CYpVdOg3GcA7lUr21ixR/q
	w9JAGN5FquKie/1lhEKtBBHhy3qXmYUUu+0icNX8StksJamrPEKlCyQF/R0spkv3qCZsw3RR5ra
	vUPfqJmYf/w8IaAqJlgEp0AGbjX62ZfFt6jIKcQyKD83Wmm0bb/U67aZJXFftCavi35TML1qAva
	jSSEQcR0L5l3Sbw7NnBgVw16hO
X-Received: by 2002:aa7:c40c:0:b0:65a:4207:fbf0 with SMTP id 4fb4d7f45d1cf-65bc4298147mr2068381a12.15.1771164877003;
        Sun, 15 Feb 2026 06:14:37 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:36 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 0/5] DRV260x: Support ACPI-enumerated devices
Date: Sun, 15 Feb 2026 16:14:30 +0200
Message-ID: <20260215141435.727872-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo Yoga Book YB1-X90 and YB1-X91 tablets use haptics controllers
DRV2604L. The X91 (Windows tablet) uses ACPI to define its configuration,
such as I2C address and GPIO connections. The X90 (Android tablet)
doesn't have it in the ACPI, but the device may be defined as an
i2c_board in the x86-android-tablets driver.

To support these variants, add an ACPI matching table and add additional
I2C IDs to the I2C matching table (the driver supports DRV2604(L),
DRV2605(L) devices).

Also, implement a timeout for waiting for calibration,
and fix the non-working suspend due to unbalanced regulator_disable() call.

Changes in v2:
- Header includes have been sorted alphabetically;
- ACPI GPIO mapping has been removed (supposed to be in the
  device-specific driver like x86-android-tablets);
- Old debug session artifacts removed;
- Checking of device ID has been removed; the driver uses the same logic
  for all drv260x(L) variants;
- Timeout during calibration reports an error; we don't expect that
  the chip will work properly in such a case;
- Patch regarding the regulator has been reworked; now it just adds
  regulator_enable()/regulator_disable() during device probing and removal.

Discussion of v1 is here:
Link: https://lore.kernel.org/all/20260211235902.4156624-1-jekhor@gmail.com/

Yauhen Kharuzhy (5):
  input: drv260x: Add I2C IDs for all device variants
  input: drv260x: Sort all #include alphabetically
  input: drv260x: Add support for ACPI-enumerated devices
  input: drv260x: Fix unbalanced regulator_disable() call
  input: drv260x: Handle calibration timeout

 drivers/input/misc/drv260x.c | 55 ++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)


base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921

-- 
2.51.0

