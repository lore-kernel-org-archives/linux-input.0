Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A74E7802;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788731; cv=none; b=bYaKASPyZde9WnB7MK2TFv7Qeq6mW8w5/3fX3Yb8mzCmDl97WrVpScYhA4Fo468n7+fcyIKa7qwgDvTUL9NxTnVrpLfZFckUhUu0tqviahURX4W2nUX4WDZ1qdgvBM0Te2jNx4RENOBxRBa0ns8CKUEFJ4JLyKrT9uQo/3LTK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788731; c=relaxed/simple;
	bh=njD6TWFbmDyEqVQkX6D84VkhL9/hfU5DCVnSetZmtHo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OaJQ1l0CsMVU9NhAK/dxJ/TcF59QG/YHKZ44VmUUexuN4sxpMA9WXKYw8ektdrpE4RUT9S9sU3zM0D9sZEoQPq1qIH9QA5fnOPDTRq/D+tQYTdukz49sJ0DQCy/+66Bd5q+Te04TlqpmIzdBVm7VSDt+Z/r9S6swGdCpMKh/KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZe6W08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZe6W08"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E5FCC4AF0B;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790788731;
	bh=njD6TWFbmDyEqVQkX6D84VkhL9/hfU5DCVnSetZmtHo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DWZe6W08WmJczsxerpqcGDdSkKYgRv88qvzinXJkXI315B5pY4URFYJUxiJQ2AMhi
	 Brj/U/X2+/t7VjGWSpwKuQsZLR+XPyZix6DGn//Y/0knsphM4+Rh6XtOvKJDsdgUXF
	 5BV9HKYYnr85nDhUZkkPfIIZbgiYAs3NAFC6pgOHh8zCBRa0KNpb+Q+3m3kV3rtjO+
	 sVfaZbKVHGk9A5zM5ETIt+VSjCIzSwAz2zylK/01TPSjkZ4Ba3izLiKMO6lO9mTHQd
	 AfOawU3QOmRBeIexjsYkqk4hY30aF5jha6YjM2muGvFowaaa5Rgopc9pE1+9bguMzs
	 dr66oljw2ZO+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29601CA5FC5;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Subject: [PATCH v2 0/2] Input: Add Awinic AW8697 haptics driver
Date: Wed, 30 Sep 2026 19:18:49 +0200
Message-Id: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jmbc1AI6Ir7mFY0GGEMdKSthIN6
 d0F3Lp8yfvvLxDYCwe4Zgt4niWIsysUhwxoaG3PSrqVocCixItGNbZin2LF9gpNV5mzOVFbEqy
 DyfNd3nvs1vw4vMyDKW6FzRgkROc/+9ucb97f8JwrVKRRk+kMIlX15F109jgyNCmlL0eT6YG2A
 AAA
X-Change-ID: 20260930-mainlining-0bd8b7b5ca6c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790788729; l=1883;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=njD6TWFbmDyEqVQkX6D84VkhL9/hfU5DCVnSetZmtHo=;
 b=hNhixIMuEaFVSuf7swosAAzCQhMtz+NyT6WKNzDpjg+JkYq6udb7iFAZXRloQQ9nYUDODBmyT
 3bl1YB7Fo7eAI+vPSHScOZdRlXIx13KoCqB9oDMDEyT0QSVc6L0mQbz
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

This series adds a driver for the Awinic AW8697 LRA haptic driver IC.
It is the vibrator in the Xiaomi POCO F3.

The AW8697 is an older generation than the AW86927. The register map
is different, so it gets its own driver. The binding reuses
awinic,aw86927.yaml.

Tested on the phone: rumble at several strengths, 72 effects in a row,
stop on close, driver rebind and module reload.

Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
---
Changes in v2:
- Do not queue I2C work from the ff-memless timer during system
  suspend. A suspended flag is set and cleared under the input event
  lock, as in da7280. Tested with delayed effects across suspend.
- Use explicit error checks instead of returning the last regmap call.
- The NULL IRQ name finding is not changed. devm_request_threaded_irq()
  uses dev_name() when the name is NULL. /proc/interrupts shows 11-005a.
- Link to v1: https://patch.msgid.link/20260930-mainlining-v1-0-c303cbdb00c8@proton.me

v2 only fixes findings from the automated AI review. I will not send
another revision for automated review findings alone, because that
can go on forever. I will wait for human review.

---
Armandas Kvietkus (2):
      dt-bindings: input: awinic,aw86927: Add Awinic AW8697
      Input: aw8697 - Add Awinic AW8697 haptics driver

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/input/misc/Kconfig                         |  14 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8697.c                        | 761 +++++++++++++++++++++
 5 files changed, 785 insertions(+), 1 deletion(-)
---
base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
change-id: 20260930-mainlining-0bd8b7b5ca6c

Best regards,
--  
Armandas Kvietkus <armandas.kvietkus@proton.me>


