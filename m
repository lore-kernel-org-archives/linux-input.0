Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48730485CCB;
	Fri, 11 Sep 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132756; cv=none; b=lR+vrEiX11duQNOBtDrjHiYhY67nUhUvw7411QGnodoneA5tgAn65lqrlm2IETFHziWgfJnVgFaRXpk5+FsFImkvrT7qBwT7/IMX2UNjmGPApAas/nFk9FOd1HY5+yb4WJOqJkRIxiizQwgUEDre0dtc/vXWonWZzo0RbQxBPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132756; c=relaxed/simple;
	bh=CLNjwsXZVxITkz+SiucWcnfbFwvKd7RH2N2OvQYnRhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrHd9jzmOYF+CsWPdl0SkPkhqKp8UoVsFSjfphXhjVeoaP5C+lToTKgohRAKe5JMLncBjYTzqPY2KA22uCR4gsNsg4VD2FLG5KnmMecZ7MFVM9XFIamfcIhU34oQMmJ5tjKSeMysXBSB5hzN/40sWsnfzordGR9d1iYozjzqccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0pNEfR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0pNEfR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20E01F00893;
	Fri, 11 Sep 2026 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132750;
	bh=tcu9ZHPkGXuh/+Ox7bKSy5Ld8LEcCHXrUb8X71cpZco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n0pNEfR+K+y0r40r4H5jX4Ltrz+vE2O9mnMFuYVXGdFXoSMfKcghpvVHs3L7+2cVj
	 QKYX1SSkb0Mz5yl76oftgAcYpYrqr58FWDursKeyGaHbGAZhVUj3/MyjZT6DQRpVHH
	 B1mnBZQllItMrpEjm3R9Qs5b2zsjk5JxTL5lJ+x3EyitmRnUo0FBXw0iYa7hbvldiB
	 Sq8veHcNdbBb+VqX5Q2RjJaV+9cXNRzzHi/Y+8oBHDLp/t2c9EvnWT3afMS5PNt9nY
	 8huIXe9n577R0LuIizbH7a5pwBUO9vgKCyNnC1yYv8TwyYIfQDL8j3p4X5BXzu6Qe2
	 xalAJne/9y02w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 11 Sep 2026 15:18:29 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-tama: Declare touchscreen as
 a panel follower
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-topic-rmi4_panel_follower-v1-3-c1b2cf1cdb62@oss.qualcomm.com>
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132733; l=1382;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Hh9ZkdX9yN5IRtxnY/CEiEcxcLPV9GWCd3MW3KHCpfY=;
 b=P0eY+ypE03Ann8gS45al/N1HhVqc2lP7qNzeO5aWceBpN7tZxVG8p+KYTohmAdHfvgz4q26hm
 eWDxumvy9+FAPe8eHeXAOGdvmpNsv/rYEk260GYi4pL2joFJA6/OC46
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Currently, the touchscreen relies on the idiosyncracies of Linux and
fw_devlink, wired up via a totally fake supply reference to keep the
driver probe order in check.

Resolve that properly by declaring the touchscreen as a panel follower
of the in-cell display panel.

Assisted-by: LLM
Fixes: 3ab8216de2fa ("arm64: dts: qcom: sdm845-tama: Add Synaptics Touchscreen")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 05e5a3674e5f..dd79b93befb4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -442,12 +442,8 @@ touchscreen: touchscreen@2c {
 
 		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
 		vdd-supply = <&vreg_l14a_1p8>;
-		/*
-		 * This is a blatant abuse of OF, but the panel driver *needs*
-		 * to probe first, as the power/gpio switching needs to be precisely
-		 * timed in order for both the display and touch panel to function properly.
-		 */
-		incell-supply = <&panel>;
+
+		panel = <&panel>;
 
 		syna,reset-delay-ms = <220>;
 		syna,startup-delay-ms = <1000>;

-- 
2.55.0

