Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309271;
	b=fiydwXgxLD6EaCSLNMXttGt4IwZPsjWb4GxdsexOsO1+vouidbgpDrDdiMVufkGOI9Xa
	 jzWYkKQU4AfT6L/81Sj8xOG5EIggZVJ5w9pyPq1rcpdkyywysD7dgIc8qD8QOtYvg38yG
	 ClfA1556oIspDn8RsWYYaAFOQSB8q3EPQ4U6tiUmMLitLlRuKyVTE/Ou7jaumkpt/4OkR
	 AQEfbV/HiptX9FmJ42cL71XBsWo2pMeTtvWhKUoceHtFaflpqqwpG8lI1QK6CHO4lwVZl
	 wrkYmMDMshJf9f09cZHGKvs79D3tkicIm+RkmvMSoBNgo8KLakI5lgnYznnibPcNuhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V2d/3KN9EFLJt2CEmLoiL7C+x9p7wCoQ76zvSrcXGHA=;
	b=y1hxymF4yFY030tQABDCEWkVEMxEjrL3UC5U3AheROKjvnwGUP2hDMgwiZyap8M7M6nY
	 MKUV9b8NfUQNh1dE6YG2bxg8qxT5r1olxZ4lW80Y9nQGFJmYWvOctKtVXwQqtwHsXN0Wh
	 07OtqE1gFPMYL+FD5YPM/1/93xV3fgsJ9fhV07kBzclDFbrGBvzQ69j3uEHW8MW3qc2YI
	 2mDztkwwd8I7ufCy34etkvx2F668/+NqpbpsY5vJyCVAxd/TEuzNlYjpplx2Q1dHKwvj0
	 rOij9xR64iFVkrmZNo52qhq7uVPRYLf1S9+VZIqeMrVtZnHdzsGtKOb7YNFC/JJqpIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnQ5viNa;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07D606A339
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D07D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnQ5viNa
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b147e06befso851985a91.2
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309270; x=1794914070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2d/3KN9EFLJt2CEmLoiL7C+x9p7wCoQ76zvSrcXGHA=;
        b=cnQ5viNavJtinjD66Zek1dq5x4qv7/KFnNkmYWNlyX7UNhyA8mn8TK81Ik6mo2yu11
         ApDPAtfhCQk1UJ4xAtuRVQMA4FQyuov3uAndKeGhlHbc3jxjE3ocCJfJqBu4rsDIyfuU
         /p22qH8dByEzeD3V9QDpE34dYC9Mh41cB/Rzb0Y12zePViya3mO9/Mgc1ys7pSRMegwF
         vTOb7uhvOitYQ1iP3W9J755jcTnmuRdlv0dQXLU6KOP/+C1oqJ59SF1nmWTA3Yv70Od4
         tMs8gOdLJdDGIdyLdK4INREhRqxKKNrhAC+1ESKGlecbMDWJzfCDdNVM0tRYkUkJJzNA
         kwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309270; x=1794914070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2d/3KN9EFLJt2CEmLoiL7C+x9p7wCoQ76zvSrcXGHA=;
        b=MxUsrpHuorY9e8fg+MWi3SWf1B8psfhcO/njrTriqOJu4T3ZREdCHsnkXYc5gg5IlL
         4AgUTAGGVPp9tiq4JGO8dKJMnn5kg+0sXuNeUOGBhHH73fT0QVCG7HzkR2zxHSZMR46f
         2T/72tcxIUKpwpyMX9GXC78SmcvtHaryWZKo1SmLTIFKCCBg2SEHPHqQYRHsfgtPZDYb
         8PffrvEC6fduozXealym79LaLE42UHRlK8iuDEEfGvPdNHmwpS9CZaKzdlH5ITnWZeMA
         C4C++GwheMbdg2VxVWvZlNkfSjel68iB+x80fY4SJFtHP+d7NSgHGLpEvvqtpWeaNpMx
         hFVg==
X-Forwarded-Encrypted: i=1; AL+hErEHbnR3VQQRN2lgL3BV4aqn//9eG4A2xl9pa1674QsPnXSscHLzqA6VEhTQj+JwOs4P8xSRGF4yilP27A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/K1c9sKM/kzICEx77Xn5UE87Qj2fRo4QHwu7wgs7mDzv/ofBqg
	7g93Pe/z6ZE9iN/D9Bg5lbeAJVXjTF0Ryjok78fohGU+7M9PneA8ZZ2/
X-Gm-Gg: AYBFou2gHaQClL6kYYtNCt0oIkovaWRNjV5nSs1O2GS62DRYrnrTmnMHaPfWLKmWGQl
	g8mLlG8LC4MmfniRJQpf/PFI1Ur+W+j6u754LeeYGLcriplbxYXK+NJRqlKxhQ65WoJxVz8u7ro
	ej/tCLwmZxXjndTS1JtJf8Yr+oVIydF0FPB28Vx1TphfKLNV+Q4FlJyCFkcOGaOHQvGJ7hsRoSA
	jVjVM+ZbW/tqI0rKa+HAi8W8v53Ca4UNn5A/TtiQIhMF9dY4/KxksFYjVu+K1480MNaZzoxzx4R
	itMTFV8L1CYfcq0YbdH9GnqWg4rOBPnm0NDeEyhH8/+q5p87JVW6MZ4g7988UQnK2s3OSe5OTP8
	Vd9H1JInWqFdIwPRzwRkJSp+c+6XGSzeO66lQVnYnTHcnF07RvY3J3H8oPWzPS4dXI4X4XehRYH
	ngWqBsjO6B+oeLchG2svcbbJNeOt1TGj73Cx9xq3eLfR8MEVlpMc0plRTSPMgR8ENmfD0uwDq1C
	SPkmvqiQTMqcUIaXntylgBa2Etpc6JXY37UvHpfSRxiSUwKmTt2BIaj4pAhJ7RoBcDr34uRPRcm
	P+RKjymwE65J9/erABv85ZVwRh9BFatEFaMaiqt0BSqXRC6//t9dy4yHgWQuIEicq1tVYEYrqaI
	OgKA8XJSWMksxSUQGmSmSnZVhIw==
X-Received: by 2002:a17:90b:1fc8:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3b166ca1c22mr2280914a91.8.1794309270279;
        Tue, 10 Nov 2026 03:14:30 -0800 (PST)
Received: from fyhsueh.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1678ceda0sm3556684a91.5.2026.11.10.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:14:29 -0800 (PST)
From: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
Subject: [PATCH v1 0/2] Input: Add Nuvoton MA35D1 keypad support
Date: Tue, 10 Nov 2026 19:14:17 +0800
Message-ID: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series adds support for the Nuvoton MA35D1 hardware
matrix keypad controller.

The controller supports up to eight rows and eight columns.
It provides key press and release event registers, which
the driver handles through the Linux input subsystem.

The driver uses the common clock framework and configures
the controller's scanning and debounce parameters using
fixed register settings.

The series consists of:
- A device tree binding for the MA35D1 keypad controller.
- An input driver with Kconfig and Makefile integration.

Tested on a Nuvoton MA35D1 board with a 4x1 keypad
configuration and a 1 MHz KPI clock.

Tests performed:
- Key press and release events verified using evtest.
- Input device open and close verified using evtest.

An earlier MA35D1 keypad driver was submitted by Ming-jen Chen. This series is a separate v1 submission with a revised implementation, focusing on simpler clock management and hardware event handling

Feng-Yi Hsueh (2):
  dt-bindings: input: Add Nuvoton MA35D1 keypad controller
  Input: keyboard: Add Nuvoton MA35D1 keypad driver

 .../bindings/input/nuvoton,ma35d1-keypad.yaml |  73 ++++
 drivers/input/keyboard/Kconfig                |  11 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/ma35d1_keypad.c        | 405 ++++++++++++++++++
 4 files changed, 490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
 create mode 100644 drivers/input/keyboard/ma35d1_keypad.c

-- 
2.43.0

