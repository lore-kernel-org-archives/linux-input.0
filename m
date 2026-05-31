Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE433F5A4;
	Sun, 31 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218645; cv=none; b=qa1DCA2Uq5RJCKZX3qpRUhPxVDdUHzFCfN/k1hOdKii4TEh8CqD1lfCB7a+xDukavd8pOnuxN7+Sxk3Yztil3wBN28z3Wp0QjlO98ycdWozQebzw53i+VthL4pHmpLQspnJS/koD9yeSIxlpd7E+038rowkTH3FTCRiMAmtA8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218645; c=relaxed/simple;
	bh=qCSXdL7UxE/qWT/uKT+Nivjqkn1rjsbMggSsnxkbbJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QLQQfsyYRQ7Q7JxihrpAMtwEo5RYv/jI9a7hs52n+EOus7I6tRe1s1FmdFjaTq27a8Zndth3CiNlbbqZ+/cOhDot6rfvkZsmB0GY7rOVikGTQycYy0u47yfnhM3uf2zt9ZPV6OfIxstaBH/qp2Ocozc9gEGPtIlgp+AVH1oQ4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTqJSVjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTqJSVjS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8EEBC2BCB4;
	Sun, 31 May 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780218645;
	bh=qCSXdL7UxE/qWT/uKT+Nivjqkn1rjsbMggSsnxkbbJI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gTqJSVjSjM5A+hwjg7JIeP3wUZpV4HIWu5hG8dpr+utVxFdhR47xSrlsttfxPTSn6
	 U+CZ1vTIpqgJBQ8Scb7Ln03KiJlryej2wgPH0j026aYWBG8ZuQU07ZQONauQdLMadC
	 DMDxmJYc568/C9tv77+LOZUUupOqfvG8uz4Zzl5ov6X98Y6LvmRCfy217f1B31+fzP
	 wBCwEINrzhmqyU8Yy09dM2RbuPR47BWwK40lRZPa9K76RACJ+BBRE5sekYhDlWQxJe
	 NDkxiIXQajig8si1MriGTohuedMlgb3SiFALbyZK5FTyQY08/ljXkhCtz3AvXlN5s8
	 vG/kT5ore9Mew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE901CD6E55;
	Sun, 31 May 2026 09:10:44 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Subject: [PATCH v2 0/4] MediaTek MT6735+MT6328 SoC/PMIC pair base support
Date: Sun, 31 May 2026 11:10:41 +0200
Message-Id: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBBA0auYWTuJQlHqVUwXFkYdEy0BrCbGu
 xfr8i3+PyCQZwrQZAd4+nLgz5Ig8gzM2C0DIdtkEIWoCiVLnGNVS4Vu8527IIVGN7NBSw9dWmU
 U6Sek3Hnqef+v29ftsL4nMvH6wXn+ACxelj58AAAA
X-Change-ID: 20260531-mt6735-pwrap-mt6328-pmic-de481d5c5e89
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780218643; l=1752;
 i=y.oudjana@protonmail.com; s=20260531; h=from:subject:message-id;
 bh=qCSXdL7UxE/qWT/uKT+Nivjqkn1rjsbMggSsnxkbbJI=;
 b=BErCPRXo/UmHpL4V4wTM++8swxKEM9ihvG6lllxqkHzSSemqvXk3gF3LIB3ZuJUlbddkmnxdG
 LzTHPsEoeuCA68WBkRzcvpASMMtAFSnN9O0TMQ330sRYmlETgOTzC57
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=sr7uwnyVqGKAIhvwnIwormkDM3d2VNc3VOTEU1GmsEM=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20260531 with
 auth_id=802
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds base support for the MediaTek MT6735 SoC and MT6328 PMIC pair.
This includes PMIC wrapper support on the SoC side and regulators and keys on
the PMIC side. The PMIC has other blocks such as an audio codec and battery
charger which can be supported in the future.

Changes since v1:
- Fit regulator definitions in 2 lines and 100 characters whenever possible.
- Remove get_mode and set_mode ops for regulators that don't support them.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Yassine Oudjana (4):
      dt-bindings: mediatek: pwrap: Add MT6735 compatible
      soc: mediatek: pwrap: Add support for MT6735 and MT6328 SoC/PMIC pair
      regulator: Add driver for MediaTek MT6328 PMIC regulators
      Input: mtk-pmic-keys - Add support for MT6328

 .../bindings/soc/mediatek/mediatek,pwrap.yaml      |   1 +
 drivers/input/keyboard/mtk-pmic-keys.c             |  15 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6328-regulator.c               | 500 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 177 +++++++-
 include/linux/regulator/mt6328-regulator.h         |  49 ++
 7 files changed, 749 insertions(+), 3 deletions(-)
---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260531-mt6735-pwrap-mt6328-pmic-de481d5c5e89

Best regards,
--  
Yassine Oudjana <y.oudjana@protonmail.com>


