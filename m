Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0E4718C7;
	Fri, 11 Sep 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132738; cv=none; b=q7bJOGIagSsr68OCFN+KiM1NvjqrG9yBgkbbx8tKJyKyPyhQbvaKULUDCzhWloDOWIoDd+/EeveMB1Puu8ihev1RxLVHV2V7dh36CQrWxNzbueLMfJAl9dCr4mGYu1hti1NimeSPQkjS782rtQ5CUMNjRZDgQlcpPDHGelpuTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132738; c=relaxed/simple;
	bh=ORjLkEMAmq6RUQNyxk7AlOhfj9MJ7dSVXcsdNHwE9HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5FxSE/IVc1IZJfxU9CBzFcZXCTkD+7WO9x6qsf4BJdxXuTIjvr2M7Sc+ydBcwROzVvegZnpQt3DRMWgWwBGBn1kkEQTTsg26HBg7dkFcifI6d5BKmsVBfUmx2UpmwiV5WX3X6gNjQr+ZU9Ajb0Kodezv4SjzhNXae5IkptJFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b04UNup/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b04UNup/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6621F000FF;
	Fri, 11 Sep 2026 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132737;
	bh=dZdRu2CSEZY9QFD3HDV8mXzCwNFi5Z7CBlM1UouuH1s=;
	h=From:Subject:Date:To:Cc;
	b=b04UNup/sPk0TL2fbzX5FSk2tWWaaJDbetaZciK78BsdY/hYMYz4A9t8D+rD58TaZ
	 HBTd4j0PThSvJHXjzCuc3XFWu/VtvoiRgsXzuy1HP7epbrspNSA+BtdhsKsgfhGhYO
	 Z2h369yIpVRIWEG5wXZFhhSHEnvlmlWRmKJpHOVvntDVzpLn7NZG63hCVvN9+N2SRT
	 zPgzQvgqoqJgu82LUW7TZy37LCPMfOrf53bQ1qL5TfvbXEUH8HBk04k1EkAyThCfrv
	 duu0z2ErojJelp+td+WQ4SsUq35I32gQrceRNVPbbjD3R2qgQkONvr/14MN1m5c0UA
	 PUX5rJ/5cnklA==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/3] drm_panel_follower support for RMI4
Date: Fri, 11 Sep 2026 15:18:26 +0200
Message-Id: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWRuY1BKsVxEpaZzUkZiESdVC6
 d0bdfkW/69QSJgKnJsVhN5cOMUKfWjA3W2cSPGtGlpsDfZaqzlldkqe3A3ZRgqDTyGkD4ky9nT
 0IyL21kDts5Dn5fe+XP8ur/FBbv4OYdt2+lfZHX0AAAA=
X-Change-ID: 20260911-topic-rmi4_panel_follower-6a83fb0009a6
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132733; l=1109;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=ORjLkEMAmq6RUQNyxk7AlOhfj9MJ7dSVXcsdNHwE9HA=;
 b=p8Lfsk7mdNyRCao62okwtmKiaKw+3fIT6aniIHe6aPlBhSLDIuBxFKuXrgtPEIyA0XZLtjzcL
 p8IhPe0XKHcACy7Zo3A9tegsCsyi7l78bPYUWzX1AScwyBOgz3gF/Kz
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

RMI4 is often implemented on in-cell panels which require tight power
seqeuncing. The kernel way to approach that is the panel_follower API.

This series adds that in the RMI4 driver and wires it up on a
Snapdragon 845-based Sony Xperia XZ2, also resolving the DT warnings
stemming from the current hack.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (3):
      dt-bindings: input: syna,rmi4: Allow 'panel' property
      Input: synaptics-rmi4: Support drm_panel_follower
      arm64: dts: qcom: sdm845-tama: Declare touchscreen as a panel follower

 .../devicetree/bindings/input/syna,rmi4.yaml       |   4 +
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |   8 +-
 drivers/input/rmi4/Kconfig                         |   1 +
 drivers/input/rmi4/rmi_i2c.c                       | 170 ++++++++++++++++++---
 4 files changed, 153 insertions(+), 30 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260911-topic-rmi4_panel_follower-6a83fb0009a6

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

