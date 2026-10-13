Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920051DDE5;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902566; cv=none; b=dpoveZxGlO2mg6XBzYEs1pL4r4iKn3KnRqGvuim8sBf9Q+CXY6scO0MN8QtoB2X8b1ieVubgsDxpJqaFyRTf1RE2QUflfhCLHGPdoL1au7D7gtZkH4i9zaVf3kjBAqk1ElOM4V1WQUF7+cMugJ/QpRufxQx5Uz6G/RMfy+0XCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902566; c=relaxed/simple;
	bh=csndEIJALGjmkNsNoRfoNPp6dxs2xMbpUWFP/TJNYmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nk9tgpVZ4OzqFRwBBVausTXk7BcHFy+XPQ60gNothYYdmDm9pocr9/VoAXcV7RHsiLscAxJG6Hu7EvaN3G3YFZwL7Oqhp3YLquaInZc4JmV6PQeg2uXZ6mtRZ5KiOJmLnyRacOu8VawRD795Pm9h+bFqcOdkZEa4f6QRdcVgJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCtjWbmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCtjWbmA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DA0AC2BCFA;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791902566;
	bh=csndEIJALGjmkNsNoRfoNPp6dxs2xMbpUWFP/TJNYmw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dCtjWbmANFBcUzBtxp6wSderFJt/36c2iNBQe6qxQlQeCFCPZpmIs43V0zcSj3SOJ
	 5DDKiPuZoLsqjyF5xs8PRu3H1XYR7YWg/6Ood3y46QgwMXyFOSLL8ohkjX8RlkzQeQ
	 Nf5J5JNNy9XDm02QfT/ZrBCKfT0kbn4jUy7VCvhwFTors+ACSCyo+9yQvr5I8qT7QS
	 lv77h8hpCn0uRrYiOwKdl4sAkmvkG08dTriUSrQwTPCnvw/4tIHigxrSCdk2WR4V4c
	 9PJFibiMx4JLAtikSTKchOuxg2gUuM2N8363KiX7zwfsCxRCPvlXDf8IWg6jOaJzPh
	 j/OMpAxVMWAcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C9CC6B0F;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Subject: [PATCH v3 0/2] Input: Add Awinic AW8697 haptics driver
Date: Tue, 13 Oct 2026 16:42:44 +0200
Message-Id: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBAFf6XhLGYLVVtP/ofx0AVs11hooBJN0
 38X6sWDHid5M29mwXgygR2LmXkTKZCzCeSmYKpvbWc46cRMgNhDI4EPLdk7WbIdB9Q1HnCn2r1
 iSRi9udJzjZ0vHw4PvBk15UJe9BQm51/rWyzz7mc4lhy4kiAVagRQ9Wn0bnJ2OxiWw1H8V0VSK
 0AsUTaV1PitLsvyBsHJ11LxAAAA
X-Change-ID: 20260930-mainlining-0bd8b7b5ca6c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791902565; l=2577;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=csndEIJALGjmkNsNoRfoNPp6dxs2xMbpUWFP/TJNYmw=;
 b=SUygf2am8eMZuDRJdhM45GRb/k61pT9uA9j+5GI0oW6Nk6B1Cx3kzn+BQfu0Jq40HZdsHth4t
 7deTL2JCcqYAGoKlKJH9UhxMtr7xlzcQnHjdSSQgNrWnAeJaNQwtuAE
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
Changes in v3:
- Drop <linux/mod_devicetable.h>. <linux/i2c.h> provides
  i2c_device_id and of_device_id. (Uwe)
- Use a named initializer in the i2c_device_id table. (Uwe)
- Add Acked-by from Krzysztof to the binding.
- Link to v2: https://patch.msgid.link/20260930-mainlining-v2-0-40bb1b3943db@proton.me

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

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
To: Armandas Kvietkus <armandas.kvietkus@proton.me>
Cc: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Armandas Kvietkus (2):
      dt-bindings: input: awinic,aw86927: Add Awinic AW8697
      Input: aw8697 - Add Awinic AW8697 haptics driver

 .../devicetree/bindings/input/awinic,aw86927.yaml  |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/input/misc/Kconfig                         |  14 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw8697.c                        | 760 +++++++++++++++++++++
 5 files changed, 784 insertions(+), 1 deletion(-)
---
base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
change-id: 20260930-mainlining-0bd8b7b5ca6c

Best regards,
--  
Armandas Kvietkus <armandas.kvietkus@proton.me>


