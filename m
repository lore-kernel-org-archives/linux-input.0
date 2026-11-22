Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324435;
	b=s2cBr491+qY2fRwjyYAh/+QiVeATz2k6VYdRKE+tjqlRlDM+GdtSJ6zgws6ZaxR4tEHP
	 friBEbcfFvZmdHI3AHiV7/Crrvuuheyc+OslWzK75ofFzaRVmfJgoYZvUS8wQpNqytDbn
	 YkjEYCEnPW2JuhfgM6ygBW8dqBSRlM2g2gHk+UuinnPr42D+7Kp2t8QkD6IHuaWXEA0bb
	 akSdlTSMsDyY17PtcoQog/W+V7djSbmq1zscEMuMllf68Io/UbX8POSfloj6OFvfcXido
	 aJyXkiY5PeEsjIND5UQY8IekTSfTzvzbIa0SO5fGG85z6uU+Sc/q30D8MUHrtWHiJeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324435;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=edfAV7sjiyxrEsTsjRbWE2ESXJEHHcgg3MhsTRg16rI=;
	b=e1onEU99tsDQiq/yOmxJLVaqzwhftiMqiXpEitOvy9V4YTlOR77mkzcx7jhJzmvGmGaP
	 YXEzwIz4XT1K6V80foPTDNvAs7pLsjI5+jEu5wgfyDK8fv2a8ylb0yVUykieVo1NCmzfS
	 FZ2dM/jR/8/cQZzbFj/JI3v+t/fntTH3beG2wjani+vrFb8nUM5B9KLvdLWeYKpG5Ng9f
	 7p+0RgdaZ4CQiejznmAlij2O7qB9eW+zt/zaWG4TxiE/+Z8bd4Wzr2orktC5t+dCKTBgB
	 Dgp6EP3WcHx4yZ56dxoBgiLjchcnXp6lrvHGXqv593SzjUVTri2S2MZMGnOGfvYtAfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEbPrjn2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B23606A330;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEbPrjn2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324434;
	b=YEYsk3D9fA7YgpeNohOAjJRs+NtiLRIGQkAl8U1zrdbVe0W5wURBsBbQBUr1c6qU5kwu
	 Nivd2t44DuEvf1DK19b4G+Rreyf1PPnWFz0asaAg5x1d3Gyk5FgoEZAKod2kvOy+idaKR
	 dqEmKR9NPHNXYPBMo2fAlZWLsE2as0S3mjyaOEHhuVFC70J7YKD/hMutprfrb/JCOUZpU
	 gE8gJjl5lM1hNhT6mQcaaLQkifmipNiwt49mc24T8wdAG20DlRWl5It/Z9+uIFkDVQvNQ
	 6Rkjm0ht5dglHo1tyZHoJ37EP65aPAdcG+D5YO+/dvNVnSPzv7Qzn/xXt75hCvu8Iug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324434;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=edfAV7sjiyxrEsTsjRbWE2ESXJEHHcgg3MhsTRg16rI=;
	b=Ay/7dDZuQVoTdeZty0qCFizyHF7mUlXYjyv9NtjqfM5VhDtd//+ers14V20JpjRNTsQe
	 Ym1SZIs6mgNvy2qEDK0vaTv0tqUDZRZlqVtRK/PvGSLcTfZow4i+mCQnEw7p31wLTpc4e
	 3ukY1eOUSVjIvw5r2k1oEyMMoKOpEQ5tjcFm6llTUuXvC3Wm9S0vzYoivNKqqeWPWkH1d
	 nZFb00d2E0KGaa/XPvl2hJiEyD6nvkdmCzH/EC65GxgQVMUiiJLcmVROGHbcjW33xHuHM
	 nb1Oj0T2BSEx9lgTOvVHMNuEwHjhn5plLm9FWSexek/c+AX4CFZ7kdjWb4aLaoa50sQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 510FE1F000D2;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324434;
	bh=edfAV7sjiyxrEsTsjRbWE2ESXJEHHcgg3MhsTRg16rI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lEbPrjn2tdIwhP60mY03l8d+TXqX76lKXUJsgXIJwtM8cEh7S4zi1Q//AdDSjNxcM
	 Tbpx4wlQ4SG1wPUqDM0Uek8Ak2xkj3Kq5Aaayu0iSr9prB/9X6DdIutnQzG8u9gZ/U
	 Of0loellYfLu3Zv0xklTiC32DU+5IEJqtHw7/hQpd5gXH4gNAewMhyKu9hAZVrNU7S
	 VC3ywJzyUK7h83lRbM/wgzHVu1aWG+BIDpU/RMgqTNqoQK0aFvCfd4qLb4/5yE50un
	 jp2d98eShRTPMeX6TW2Dzs9YFImj3reQJDeLulrPL6PXy/sR1XGSbeddRsuuf5WnAW
	 tYXsaJq5lLeuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D5CA84BF4B;
	Sun, 22 Nov 2026 05:13:53 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Subject: [PATCH 0/3] Touchscreen wakeup for the OnePlus 6 and 6T
Date: Sun, 22 Nov 2026 05:13:49 +0000
Message-Id: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
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
X-B4-Tracking: v=1; b=H4sIAA16AmsC/yXM0Q6CMAyF4Vchvbbq5hTwVYwX3ahSjZOsgiaEd
 3fTy6/p+WdQTsIKx2qGxJOoPGOGWVUQeopXRumywW7twRhr0TtMD3H4pjuPA+5b17impl3LHeT
 RkPgin1/wdP5bR3/j8CqV8uFJGX2iGPpyKtxM9Tpng4Vl+QInVbR7kgAAAA==
X-Change-ID: 20261122-b4-rmi4-wakeup-5948487a39ed
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Abel Vesa <abelvesa@kernel.org>, Casey Connolly <casey.connolly@linaro.org>, 
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324430; l=2234;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=QsipX2VlKzNSrE69Li9weyplTtRqzi4er6aXQmYWKZU=;
 b=Ujgb/6+o4SSZEZGHqa6k3zVuHNJ3GGH5slwBQhXUXAED0jiFfNVOj9jWe9PMmkOvOat5tntXw
 RUsFCVng9YYBOz2bw0tTuDNeyk/bFb2F4BoTXQs17VohXNLhIqsxsOK
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io

The Synaptics touchscreen on the OnePlus 6 and 6T is meant to wake the
SoC from s2idle. The I2C core and the rmi4 driver already handle
"wakeup-source", but rmi_i2c cuts the controller's supplies in system
suspend right after it arms the wake interrupt. Unpowered, the
controller cannot report a touch, and on these phones cutting the
supplies also raises the attention interrupt, which ends every s2idle
within a few seconds.

Patch 1 lets the rmi4 binding accept "wakeup-source". Patch 2 keeps an
rmi4 I2C device that may wake the system powered in system suspend, as
edt-ft5x06 does. Patch 3 sets the property in
sdm845-oneplus-common.dtsi.

Patches 1 and 2 are for the input tree and patch 3 for the Qualcomm
tree. Patch 3 needs patch 1 for dtbs_check, and should not land before
patch 2: without it, every s2idle on these phones ends at once.

Tested on a OnePlus 6T on v7.4-rc3 with all three patches, rmi_core and
rmi_i2c built as modules from patch 2's commit. With nobody touching the
phone, "rtcwake -m freeze -s 30" slept the full 30 seconds with no
attention interrupt (2 of 2); without patch 2 it came back after 3 to 4
seconds, one attention interrupt each time (3 of 3). A double-tap on the
dark phone woke it from "rtcwake -m freeze -s 120" after 3 and 7
seconds, one attention interrupt burst each. With wakeup disabled the
supplies are cut as before and it slept the full 30 seconds (2 of 2).

On v7.4-rc2, dt_binding_check is clean, dtbs_check reports nothing new
for fajita or enchilada, and rmi_i2c.c builds cleanly with W=1.

---
EMCP333 (3):
      dt-bindings: input: syna,rmi4: Document wakeup-source
      Input: synaptics-rmi4 - keep an I2C device that may wake the system powered
      arm64: dts: qcom: sdm845-oneplus: Mark the touchscreen as a wakeup source

 .../devicetree/bindings/input/syna,rmi4.yaml       |  2 ++
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |  1 +
 drivers/input/rmi4/rmi_i2c.c                       | 22 +++++++++++++++-------
 3 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-rmi4-wakeup-5948487a39ed

Best regards,
--  
EMCP333 <emcp@enser.io>


