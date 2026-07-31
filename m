Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED60361978;
	Fri, 31 Jul 2026 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468299; cv=none; b=aL8E/AGI4OVe7lP+JyV3zTsm4ObL1lxBJ0sBenAfpYry7kYaSXciXISGDEImHZbnyESdnjZ/F4/5EvVMCAB3W4WMEj/UKqx1aN8JyS5Vo5hCqIEufPRE77V5gAH6warHdZSAGambh0PIdl7s1saA2bn3Y5Gn7wGEUUljqBtcekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468299; c=relaxed/simple;
	bh=lNlvU6ztE6YFlJDEHlrEIuCGg79pKzfTIQ0/MMFlSYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZDjfYZG3w2s/rFoj2lqYJOYSCHY8/fYm87UH6isCKG0dTDlx5Q5aL1YgtuU5Hxq8IPudh4L/VZ5GRFE5bHZflfqFWBTMXjcCrMFvXCqBO2ITfbuY34ejFK77urswB/LNgx4zo468EvqIdEX/e2dEOWVGOqwmvg+Sg3p38VZiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNldfFsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNldfFsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE631F00A3F;
	Fri, 31 Jul 2026 03:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785468297;
	bh=ArK4s1aYAov6otqzHhwmPPSHKabKjz434s4d7zcYZUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNldfFsL6YK36eEk8xjAguQmAdTLO+o7fprMzD7EdvbQ7DZOeE27LZpTdghNkqqUr
	 LhnV+ThLWUsJt0WBomEEjGprge5lrhVVKOr4JN75xZ/VAjv3+KXNzj80o4bMN/rIf8
	 nSwxh2mKlN97DbiwLGSAASjGCJvK4HZS4zQ0tZPHkkP+lUlOeWPnzMs9IDvDKvRmrd
	 HqtAQCgRhGvF8kn8t71GYsGxwTKap/hqQ5cqm1o2eYCYfP3kRKWMuYQ714hs57x2mG
	 +2O2elfC0u5sxgWfaA0IkHuIbvg0uFoIyWsKRCQJiJZFwswrCcfxZeH6+/pG2aN94d
	 2reHzgIJ7Unnw==
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/2] cover: arm64: dts: qcom: glymur-crd: Add touchscreen node for ft3d81
Date: Thu, 30 Jul 2026 22:24:30 -0500
Message-ID: <178546826815.316815.6995438849092393170.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-0-5dd091e25801@oss.qualcomm.com>
References: <20260717-add_focaltech_ft3d81_touchscreen_support-v4-0-5dd091e25801@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Jul 2026 17:28:33 +0530, Pradyot Kumar Nayak wrote:
> The touchscreen module on Glymur/Mahua CRDs is a ft3d81 chip which, while
> hardware-compatible with the ft8112 (same I2C-HID protocol, same
> power-on/reset sequencing), requires the reset-gpios line to be
> explicitly wired up in the DT. Without it the reset line remains
> permanently asserted after a suspend/resume cycle and all subsequent
> I2C transactions fail with -ENXIO.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: glymur-crd: Add FocalTech ft3d81 touchscreen support
      commit: 67b5818ecadeb75e29c14add973b8cada2a73788

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
