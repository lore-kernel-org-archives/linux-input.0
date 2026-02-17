Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45037AA7D;
	Tue, 17 Feb 2026 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372287; cv=none; b=OyHS1VIWUrHCPQZ4pRzYbS5kR+v+I2nHhjePEHgHGCv43OBW4a2CW52GO/opxmhjkR1jOVr7/y+GbcV5kj0VxvtzuCTZQKS3hIReCWY5uof0ERpQcBSJrLqnoweSeOxvoTFAdtZJyAtvUkxB1Ajm76X/cwjcJ5c8x5K0hY7XeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372287; c=relaxed/simple;
	bh=V4lYhvGez5NstvE3sO//SCiK7cfXd/7zxDapXm2/kO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1jWM2uCKN9069JkwEAPlUqKV0f6sD/3h3S9kHVD9Vx+x7Vbi06l5ckql3k6NA81LlF8nKO4G2OKmlPw8MxYWE0j3bGWUfvOymvUKeOFWWehHn02nuxYdy620Ck06IVTsd1ApQbBBtn85bJrho5vYqGJ0fJP4Q3vrO4ZZ2v6Iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eslt17Z4; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=d5+j2TIv; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eslt17Z4";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="d5+j2TIv"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1771372264; bh=U2oC9fJRrr6fCBnB7lOeT1V
	vVvgBUC1uE8T8CLh6uKc=; b=eslt17Z4+WbB296LOt0I4uwFnhZEWAlUQidlnXh0rYfQkLXx7F
	KarLrz+tjeQqIQyxJAosyLkzdxSOdxCcP3yq+8fLwL/AlZjsEFkV4qEv07AlutagZnzKBowUhEf
	TsT7Fse1lLIU10u4eo6Cn/Z2WEDJ8lgp39g1fWiGxVkw0LTNzdJ10IV+axNI4Za0QsEbdy62dNJ
	3daQ6ndkDZlwcQ4/U75iB777XVmkmfnT3Tx+djR21EFaMc17ebvaOkq/kxxbNfqJDbsM9HzXQab
	G0WTkUaFjtoRTVBXjAgzKNnf1Gci+T/20legxw69XaXsbIxfulGj3mQPKP+3lvOF3uw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1771372264; bh=U2oC9fJRrr6fCBnB7lOeT1V
	vVvgBUC1uE8T8CLh6uKc=; b=d5+j2TIv4rVzv/SU2XF1A+fVPhBoe//3iZy3KEKkhMRioIDif0
	XBwozHraQ8FpnjDGjleor8ECLeYITjQtTnDw==;
From: Aelin Reidel <aelin@mainlining.org>
Subject: [PATCH 0/3] Input: add initial support for Goodix GTX8 touchscreen
 ICs
Date: Wed, 18 Feb 2026 00:50:46 +0100
Message-Id: <20260218-gtx8-v1-0-0d575b3dedc5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQrDIBCF4auEWdeiIYPaVe8RsrDGmoFWiwZJC
 d49Nssu/8fj2yG7RC7DrdshuUKZYmghLh3YxQTvGM2toec9ci0U8+umGGqD3NpZKoPQrp/knrS
 dzDi1XiivMX1PtYjf+gcUwTizD6OktmqQEu9vQ+FFgYK/xuRhqrUeALTn750AAAA=
X-Change-ID: 20250918-gtx8-59a50ccd78a5
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@mainlining.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Aelin Reidel <aelin@mainlining.org>, 
 Piyush Raj Chouhan <pc1598@mainlining.org>
X-Mailer: b4 0.14.2

These ICs support SPI and I2C interfaces, up to 10 finger touch, stylus
and gesture events.

This driver is derived from the Goodix gtx8_driver_linux available at
[1] and only supports the GT9886 and GT9896 ICs present in the Xiaomi
Mi 9T and Xiaomi Redmi Note 10 Pro smartphones.

The current implementation only supports Normandy and Yellowstone type
ICs, aka only GT9886 and GT9896. It is also limited to I2C only, since I
don't have a device with GTX8 over SPI at hand. Adding support for SPI
should be fairly easy in the future, since the code uses a regmap.

Support for advanced features like:
- Firmware updates
- Stylus events
- Gesture events
- Nanjing IC support
is not included in current version.

The current support requires a previously flashed firmware to be
present.

As I did not have access to datasheets for these ICs, I extracted the
addresses from a couple of config files using a small tool [2]. The
addresses are identical for the same IC families in all configs I
observed, however not all of them make sense and I stubbed out firmware
request support due to this.

I've taken a lot of inspiration from the goodix_berlin driver, but the 
Berlin and GTX8 series of touchscreen ICs differ quite a bit. The driver 
architecture is the same overall, i.e. the power-up sequence and general 
concepts are the mostly same, but it is very clear that they are 
different generations when looking at it in more detail.

Some of the differences:
- There is no equivalent to the bootoption reg that I can find in the 
public GTX8 drivers
- Firmware version struct layout is different yet again
- GTX8 does not expose IC information at runtime as far as I can tell
- The checksum method differs yet again
- The vendor driver reads only 1 touch upfront rather than 2
- Register addresses are 16-bit on GTX8 and 32-bit on Berlin
- Firmware requests don't appear to really exist on GTX8

From what I can tell, the evolution seems to be:
Normandy -> Yellowstone -> Berlin
since Normandy and Yellowstone are already quite different (especially 
with the way checksums work) and Yellowstone has a couple of things 
(checksum, fw_version) that appear similar to Berlin series ICs.

I've tried to make the Berlin driver work for GTX8 ICs before, but 
they're so different (and I lack documentation for registers to perhaps 
make some parts work on GTX8) that I'd rather support these ICs in a new 
and tiny driver. I hope that makes sense. I took heavy inspiration from 
the Berlin driver, but the only parts that are really common between 
them are very trivial things like e.g. the input dev config or power on, 
which I don't think are worth putting in a separate header.

[1] https://github.com/goodix/gtx8_driver_linux
[2] https://github.com/sm7150-mainline/goodix-cfg-bin

Signed-off-by: Aelin Reidel <aelin@mainlining.org>
---
Changes in v1 (post-RFC):
- Drop RFC prefix, the series has been tested enough and works well
  as-is
- Update my name and email address
- Add some reasoning for a new driver to the cover letter
- Add Rob's R-b on the dt-bindings patch
- Add Piyush's T-b to the driver patch
- Link to RFC: https://lore.kernel.org/r/20250918-gtx8-v1-0-cba879c84775@mainlining.org

---
Aelin Reidel (3):
      dt-bindings: input: document Goodix GTX8 Touchscreen ICs
      Input: add support for Goodix GTX8 Touchscreen ICs
      MAINTAINERS: add an entry for Goodix GTX8 Touchscreen driver

 .../bindings/input/touchscreen/goodix,gt9886.yaml  |  71 +++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  15 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/goodix_gtx8.c            | 562 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_gtx8.h            | 137 +++++
 6 files changed, 793 insertions(+)
---
base-commit: fe9e3edb6a215515d1148d32a5c445c5bdd7916f
change-id: 20250918-gtx8-59a50ccd78a5

Best regards,
-- 
Aelin Reidel <aelin@mainlining.org>

