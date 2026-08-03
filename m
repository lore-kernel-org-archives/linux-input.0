Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4E433E82
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782798; cv=none; b=bZvsxWgpUFPItpskAFEFl52c/rjYLCDQkFyHCRoa/+JU3yEZRilkrO44oTJ2sMSs07CgUgC0k1/OUjEN6VXjmZnGiEk04v60S7IndWHD1agPDNe6xfQp54yTRbi4q6Wb52Jlxzy/JEy7ZpJ0ZsuJmXC43XofXhyEQWWaPng74WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782798; c=relaxed/simple;
	bh=0sp+LL+IGp3ZeyY6XJr568Go26r/gnOE6u+jQgckNpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gpe4sr1trYJOQLzw3cwwq+thCcVWsfO3QFnibajfYlOvcrMJ1hNvM1Qnlz9+8iXnaKd6TUIMneBbjv9F8mbDM0/dk+ARSMWOdpmx7TOKi3FIcJcGW8fvqVa21YPhV9SC7MxL+70CCeausYDW0+A6i+TVPB0L5cpGccBScRoCH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtiWCcJ1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtiWCcJ1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso2051402a12.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782794; x=1786387594; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ZonO5ix010aZzRGfU9+z17NRtx4Moy27jaGI8Gtqd4=;
        b=WtiWCcJ1dMGefiHkoGPJxGnoo2rL2L+r9eQtl4b/pLivlw3//HDY5stvljTTRo4q1+
         JIKFG3lpKnIBI7Yf1E/K5IV90D/L6/DB068cnzDkjuDrg5Gdej8Upq4ai2K+wc13qqP0
         DupWL4Hwa48gw1gLAmfA2uB32aISp+bFR9rSNCFG+RfuWaZTPx5bEXtGzsEtwzUfm6E7
         704JPJ/LxzHhOWB/0TEvzNzaS7+fdMm3c5w3J7EE4RH52ukbx/fvJjSPRXghZZCPil26
         kWAGJ+anRGjbHi73d6KPPGEtsvyeRtdtRsnPZ/NB+OAIJRNu+GHVfEZgrEVJTkMOlpqw
         LcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782794; x=1786387594;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ZonO5ix010aZzRGfU9+z17NRtx4Moy27jaGI8Gtqd4=;
        b=mqGiSX0ZYRM1C6dunVKaJhuM7gXLZnW9OjBjzevnw2uZt4oa+PRAq+lIvPlgpqfAMj
         kMB4strYHqIHCLy+aI44oGZko8leDyQWA7qA7xaiwZp8b6ZHihjsMIk/yjzlwpEn11dK
         X6AKRuhAZc40iFOGHDWVs74p7OgvunoKu2Xw8mAE7UXE/+G/pLQBiLpMK+/TqT59pXLY
         0ry37WyDYcC84/dx6b9WhPdOfzVUMHz0QKteFldBWXH9CJokwi3b6qk5t8/1bZnxFCPX
         9CscwoWVnz0vk7KCiS++iTQvD51G9lzh+pnyimqwMpeSDc3gcNy+6QHqdx6U4K1SY6Xt
         +E1Q==
X-Gm-Message-State: AOJu0YxMiNSL2Mk4X+Qs6DT5cIFoOx61j/qFp5HX6H8ibgQyaFPto1wo
	C5V1yMdQt8avCvAmBIsE5+55kWB+5ExPnAvmpAhBQ4a98YDCeN3omG5mdKcLsQ==
X-Gm-Gg: AR+sD12PQpc6UimmWHpZ2GkkM1E22vjEom6nEar+kDuZhUoCCfwq39NJLpe1OFeobIJ
	ShbToB0k8fq1iX1TSvccqpOAao+xsCBmzXKOgPE/jaf63qs6fFdNCNuTDBKN4QCT81aL3gKpfdf
	no1U08Cebc2zB6Vq7R1jzCXQd7sNAAY6DFn75CxYjAq+oGb5Y+RemY9CfkxUh5eDgTrv33Y2Hwk
	dVunCnMTuu0hOXwPaKNknGOVovdMgAp3OumG7KRFY52U91t1yjcryy6Q/nQ5y4C9vkzT0Fv3rU0
	ZFCaF5hBkyfIeoJII13/W1yi64yI7h13hjPTSs7Sxv/et+hXiSFgnYHTpbdYc90BOR5mR0V77Sp
	bRIh9Wl1dvDRfeVoDf64nK3Hhd+9p+AZOm/mjjMXAJjZNySPYRznwhNtN1+T2IUuuulApxC3afA
	cvZVyS+YG+2c1z2cmrptMHd1DzShouownPkpKXxJxjVErUVXnWUViCWLxO3IpSVmPXsKxYnzwql
	d7dlgBg3NNxE+7AW7QdyJ14PgusGTs87+rn8z/A5qfG4/8iWRBEJZynRCt8Ub8A
X-Received: by 2002:a05:6a20:e18b:b0:3c3:8d4c:6679 with SMTP id adf61e73a8af0-3c92a73a4f1mr11458073637.20.1785782794211;
        Mon, 03 Aug 2026 11:46:34 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/21] HID: fix racy force feedback initialization via
 .input_configured()
Date: Mon, 03 Aug 2026 11:46:25 -0700
Message-Id: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHicGoC/yXMTQ5AMBBA4avIrE1SFb9XEQvaKWNR0qpIxN0Vy
 2/x3gWeHJOHNrnA0cGeVxuRpQmoebATIetokEKWohYSZ9ZoDLLdwo5qtYan4Ehj3lSjygqRy6K
 EWG+ODJ/fuet/+zAupPZ3B/f9ANT678B7AAAA
X-Change-ID: 20260802-hid-ff-input-configured-397bc1503256
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

When a HID driver calls hid_hw_start() with the HID_CONNECT_HIDINPUT
flag (included in HID_CONNECT_DEFAULT), the HID core immediately registers
the input device with the input subsystem, making it live and accessible to
userspace.

Historically, many HID drivers initialized force-feedback capabilities (via
input_ff_create_memless() or custom workqueues) in their probe() callback
after calling hid_hw_start(). This introduces a window where userspace can
open the input node and trigger force-feedback ioctls before the driver has
finished preparing its private structures or workqueues, leading to potential
NULL pointer dereferences and race conditions.

To eliminate this anti-pattern across the subsystem, this series:
- Enhances the HID core to automatically handle driver force-feedback
  initialization during input device registration.
- Refactors individual HID drivers to perform all force-feedback setup
  inside the .input_configured() callback, ensuring the input device is
  fully prepared before it is exposed to userspace.
- Adds documentation and a Coccinelle script to prevent future regressions.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (21):
      HID: core: automatically initialize generic FF if no other FF is present
      HID: add documentation and Coccinelle script for FF registration race
      HID: axff: move FF initialization to .input_configured()
      HID: betop: move FF initialization to .input_configured()
      HID: bigben: move FF initialization to .input_configured()
      HID: dragonrise: move FF initialization to .input_configured()
      HID: emsff: move FF initialization to .input_configured()
      HID: gaff: move FF initialization to .input_configured()
      HID: stadia: use open/close to manage workqueue lifecycle
      HID: stadia: move FF initialization to .input_configured()
      HID: holtek: move FF initialization to .input_configured()
      HID: move generic FF initialization into hidinput_connect()
      HID: microsoft: move FF initialization to .input_configured()
      HID: pantherlord: move FF initialization to .input_configured()
      HID: thrustmaster: move FF initialization to .input_configured()
      HID: zeroplus: move FF initialization to .input_configured()
      HID: mayflash: move FF initialization to .input_configured()
      HID: smartjoyplus: move FF initialization to .input_configured()
      HID: megaworld: move FF initialization to .input_configured()
      HID: logitech-hidpp: move FF initialization to .input_configured()
      HID: haptic: move FF initialization into .input_configured()

 Documentation/hid/hidintro.rst       |  50 ++++++++++++
 drivers/hid/hid-axff.c               |  40 +++-------
 drivers/hid/hid-betopff.c            |  33 +++-----
 drivers/hid/hid-bigbenff.c           |  89 ++++++++++-----------
 drivers/hid/hid-core.c               |   8 +-
 drivers/hid/hid-dr.c                 |  66 ++++-----------
 drivers/hid/hid-emsff.c              |  50 ++----------
 drivers/hid/hid-gaff.c               |  53 +++----------
 drivers/hid/hid-google-stadiaff.c    | 112 ++++++++++----------------
 drivers/hid/hid-haptic.c             |  45 ++++-------
 drivers/hid/hid-haptic.h             |   6 +-
 drivers/hid/hid-holtekff.c           |  46 +++--------
 drivers/hid/hid-input.c              |  21 ++++-
 drivers/hid/hid-logitech-hidpp.c     |  36 +++++----
 drivers/hid/hid-megaworld.c          |  51 +++---------
 drivers/hid/hid-mf.c                 |  77 +++++++-----------
 drivers/hid/hid-microsoft.c          |  38 ++-------
 drivers/hid/hid-multitouch.c         |  10 +--
 drivers/hid/hid-pl.c                 | 150 +++++++++++++++--------------------
 drivers/hid/hid-sjoy.c               |  83 ++++++++-----------
 drivers/hid/hid-tmff.c               |  47 ++++-------
 drivers/hid/hid-zpff.c               |  43 ++--------
 include/linux/hid.h                  |   2 +-
 scripts/coccinelle/hid/ff_race.cocci |  34 ++++++++
 24 files changed, 465 insertions(+), 725 deletions(-)
---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260802-hid-ff-input-configured-397bc1503256

Thanks.

-- 
Dmitry

