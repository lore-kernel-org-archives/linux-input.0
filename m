Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DE1A9FBA
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782611817; cv=none; b=SU1w+szNMmP3crwI2VhNNkl4z0vrbnZw28U+BLjxq0wPbBsXztBat88vo/YmkpMdglHrrfpR2MOsEA1Q8K7zsFvANFTvBRq1GrjJto2DaDK1FjLa8K5N8w6mbU9cDPRXkUlmLEIzyahXaQOplDRZBvD9XbzK0PyxcONWC6rdWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782611817; c=relaxed/simple;
	bh=yrPUxcjyMWlLemYbEMKUtlhtm4EF8mKdvdXz6PSkDks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PO9E9hlIsXBoxtCnuGi9lDzH09u56Y/VElcTjzHR+K5enwPwWMyrLGiUGPS2mdFnvLVRtqYic0v1YT9QVUncmN1iw0qiJxBts3dJ/+z9MuO0P1pbPSbwosNeVT0yKw5v35a33bsy6YWQLJ1xkG/h89yJYWEUC1OTNlM9UoMjn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lStEDmRl; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lStEDmRl"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c965eab27so3268849eec.0
        for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782611814; x=1783216614; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtgt4cBVZP4S3GI2wSPE27UHqX8cHkmhMCtj1VlEfus=;
        b=lStEDmRl8BIP+oUMq2mihNQa00kp8eXIk1rlG8BFTs3sZwOaKIV50FfkCSmjeylM9S
         rUXOjLiaA5a6++v+Fomv3/RBCRlqTbG7X2hxn/mP886NsGvGkRRHuJN4Y9IX//UkiaLc
         5NnTHanO+OsX+89wp4a+hXcAz1jhBgCiTJ/pfo2BzinMFvXbcWIWzdglFRJqZxMXzo0g
         wpxdJP/QTCnuV9Y9M0ua38J9Z+inwU2/jYAY3ZpRa8dp4GAIItrrcmQ8md0jpOw53LGD
         /7rcsDe9UnkKktZDS9NuitY7Y3sigTthIINJcE6Kf5DW7JIB2nn+IhZID7XTEFRv1Sfs
         A7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782611814; x=1783216614;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtgt4cBVZP4S3GI2wSPE27UHqX8cHkmhMCtj1VlEfus=;
        b=N7NnXsUFfXwMoLf45Dqrq3aEmSTD6AJbtEiwhnlJ0HVnCZDESRXcOLyyulFgpx4Q1t
         bzc3SlwCsA+0lV7d/hOLn6Nn/hFAOxg06YINzz9U1h8oIWvwbDJnni3KH12j5FTQfwWI
         7WX6AwoBLQlfx7dPVtxgBekitvdPJ9zwJSk2rp1+MSc2mAHErb2VVNIhRMO+OuawTmdp
         b19hAQwRc4MZIw6l05sIZDzk05WM3WT0z2X4LwWMISc+Q9SZOF4/nbVQZidYW3BymcD+
         p/qQTTgj0CuOgdprT6MQr/IjvOD7JDIK+fygWs556/us6Q5aLxTJ62Fws3+MkSkHG2LG
         h4ag==
X-Gm-Message-State: AOJu0YzIkW51t4r3MyCU3YCSWid9t1+g/VCMYt8WgJ19GGHP8JVCJHia
	eBcX20keb7MV+rGMDxnGnb+tTXPy4G7g/aYTvJDqHyYW0AJpT/zbu8zIr8qjSpYS
X-Gm-Gg: AfdE7cnNkX2/RlcNU26/DzsFS3tbr6nFZMBdgQ9LayYyms6HyahuJ9HSXSlOo0lOEyX
	cpEWAztaOgJe6s3Vc94QVsXyuk96bPlvT8FltprOhuyzvXMNjwDvEzFEJWqYYWXWFGK82gSHJmL
	3VE3UrT9cZg5oNbNzY5aZenRerpHsc1m6ssKMjNvbF6jkpKfRh2/WLp07YvcThRWnOBh6jFvHPM
	eEcaefHq3hRNpl5ZUrxv/a98ujDbCHlebrP2DY/UYDL1F4hcadccTXKTEy83fGP/XxvFEoNLxEU
	8M952dd9laXXcyeJwEqXcWYiARO+mfOhSxqOYKoQ0SUTjy21wTM4llPTYjWiRGdHcMyYD98ZH/i
	bpbSrxUJxi6dwnrXpO72JnuytsymTFpxY3IqpE3+3USFod8L8fgeZ5kGDIvOonNNGvXInU1qZGE
	jYuMj4
X-Received: by 2002:a05:7300:547:b0:30c:38ed:46b5 with SMTP id 5a478bee46e88-30c84c0506amr12835245eec.12.1782611813903;
        Sat, 27 Jun 2026 18:56:53 -0700 (PDT)
Received: from [192.168.0.77] ([2804:14c:ca27:80b5::13c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm35230883eec.30.2026.06.27.18.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 18:56:53 -0700 (PDT)
From: Rodnei Cilto <rodnei.cilto@gmail.com>
Subject: [PATCH 0/2] Add keyboard LED support for Lenovo IdeaPad 83RR/83SR
Date: Sun, 28 Jun 2026 22:57:02 -0300
Message-Id: <20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7QQWoC/yXMSwqDMBRG4a3IHRvQgFG7leIgj1+9bbGSqyKIe
 ze2w29wzkGCyBB6ZAdFbCz8nRLKPCM/2mmA4pBMutCmMLpJhJ1tUG8X1AdBVGn6qqnRWtfWlLI
 5ouf9t3x2f8vqXvDL/aHzvABPWkZqdAAAAA==
X-Change-ID: 20260628-ideapad-kbd-leds-16f587e9ab97
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Ike Panhc <ikepanhc@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Rodnei Cilto <rodnei.cilto@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=rodnei.cilto@gmail.com; h=from:subject:message-id;
 bh=yrPUxcjyMWlLemYbEMKUtlhtm4EF8mKdvdXz6PSkDks=;
 b=owEBbQKS/ZANAwAKAXzcyu9sg3HEAcsmYgBqQdD+YhbFJyKIi9WTs1hAHsmryBpUxphZChiYn
 YXqxkQBvraJAjMEAAEKAB0WIQR5JbhU2RB8Rp1i2ol83MrvbINxxAUCakHQ/gAKCRB83MrvbINx
 xHpsD/43MOgSSLMJGvmZ43GdfRmyGEJqq/r7aGCz5KlrqaBkbI/pidaIGGxet8zkZFcfHEzbYsc
 5o9qAdGDQheF5eor92K7w3cf94AQfecuZUpxbJpYRUlPyQnDjB0E95loxo+XnwpmTcHphFLfF0z
 T8DB/P8ikxyDkUD+eBZEGwgyRhSWoY5WeR0RLWtlDZyOKcbbmNe1T0JI/e23tphK8dVC/I2+gok
 ClX7W1cS/4FhwSbXTsLrfKhsD75w0FioUoBertrt785L59EtSJYS6+N7Ab0zNF6xXe2ypUa24y9
 4Xe1Lm1NUHH1fqiDyWNHu/aQHplZenjBfTIJJfDTDGoDMKpLf5DBW+lIq4l8U2ZQy2Wd8mc6+AX
 0TpjrfViodWChmzjxfFU7tjwqYvm6GphkgPcKjscCc5gvFNblAtYxSJtdTVUrG8bpWwpqnI4hSX
 x4YeAllfR4DpjgGtLFGRRmYbkmMhBahc630Q6Q4Y+nt7ZXHNbrfRj5t+geFpr10PTiaDIfvd90A
 ANDfzmqo9DP8wadOh577Hrvch7NSQ1g+iCIMXj66ZVu8rbCbfmeY5XkjJI4d84/TKDNBYAHxwY7
 qp3t3N6mRUI0eGQ1Fp0X8n1lrII/9yLRcx/FOat5Te7gIqwY/TBoyxYK/RMqhuZ/QopD6nRHBJ0
 tGO6dlMnu4DmhuQ==
X-Developer-Key: i=rodnei.cilto@gmail.com; a=openpgp;
 fpr=7925B854D9107C469D62DA897CDCCAEF6C8371C4

This series adds support for the internal keyboard of Lenovo IdeaPad
laptops based on Wildcat Lake SoC (models 83RR worldwide and 83SR
Brazil regional variant).

The EC PS/2 emulation on these models does not fully support the AT
protocol. Sending the SETLEDS command (0xED) after initialization
causes the EC to return corrupted scancodes ('**' in i8042.debug),
rendering the keyboard non-functional.

Patch 1 adds a softleds DMI quirk to atkbd that suppresses 0xED
while keeping EV_LED capabilities visible to userspace.

Patch 2 adds physical CapsLock/NumLock LED control in ideapad-laptop
via direct EC register access (offset 0xA1) and ACPI _QDF method,
discovered via DSDT analysis.

Rodnei Cilto (2):
  input: atkbd: add softleds quirk for broken EC PS/2 emulation
  platform/x86: ideapad-laptop: add CapsLock/NumLock LED via EC

Signed-off-by: Rodnei Cilto <rodnei.cilto@gmail.com>
---
Rodnei Cilto (2):
      input: atkbd: add softleds quirk for broken EC PS/2 emulation
      platform/x86: ideapad-laptop: add CapsLock/NumLock LED via EC

 drivers/input/keyboard/atkbd.c               |  46 ++++++++-
 drivers/input/serio/i8042-acpipnpio.h        |   3 +
 drivers/platform/x86/lenovo/ideapad-laptop.c | 143 +++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 1 deletion(-)
---
base-commit: 03e2778d1f11de9260543f969e9e888a1c2bf830
change-id: 20260628-ideapad-kbd-leds-16f587e9ab97

Best regards,
--  
Rodnei Cilto <rodnei.cilto@gmail.com>

