Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366144CAD7;
	Wed, 17 Jun 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692932; cv=none; b=PJr/4l3qP2uEL1V8491vbA3/EEUEar2NDl2Y65carVe1PQ0zP0JN/IBEJmzELYHy7/2Wbq2qoV3x6fb5Ik4guPuS8xBOpAk341ECo4njAHapvGevkZi4rD1RPPKz0La5pRTcD+aIJY7vz89QmE/ORJYqfvHpDw0DCoV8tl4Amwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692932; c=relaxed/simple;
	bh=3j4Ddmpk2Y3mpdMh0Vvt0Q2N/5GHVxDYEc93JmmAEWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFPX5ZIRHkbqe+k2GRC2Vo57WHNKPgaLaBycrv8FUQxDV2pk7AaPHA79aMbuF6yfYxPFxAwEQrfsHAKqWivBSEqb4eXvv4ilQWxcVq79QcXAE88Z4+Vkq30GH0aUlrcLRPIctqdJM0V8M8nwhR/NJ4fdREaloGkXxh5ZS0bfXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTIaCHQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTIaCHQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353071F000E9;
	Wed, 17 Jun 2026 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781692931;
	bh=kNpvWWe3NboELGU3sRektR2EFcy1XBeF7KI2atOq6cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oTIaCHQU+h5t/gGIHQbDvhVAHD6Yncbm/htV8cDtYhMdlEeL435pevXvFUr3+9FjO
	 SQb23mGapx4NrOSEKmFT16xswuTOsboYX27DJSTBuhfm6fuVau0C7lycVCEfFE8MIA
	 vVj2mdeHGJnDOTVorEAjcwVRBzpe/30ObHYdY5t/a+RJleUlHW2UFiJuoE2C+rvzNP
	 oxJefuZIXYOSMam+uitKQ62iR8hIw8Z/TC2IK0ZkYyV5LjFzZKApEOy8T6avuC6M+6
	 siPWhu02TRJP5C+nCT+MQNXTBrXALWqiTevzlb5PX8DoeH55mP9N65Szvx2ihkqPJ/
	 zPG1Mf+sDKn8w==
Date: Wed, 17 Jun 2026 12:42:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	kernel@oss.qualcomm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
Message-ID: <20260617-spry-greedy-chital-1276e0@quoll>
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>

On Tue, Jun 16, 2026 at 03:08:23AM -0700, Fenglin Wu wrote:

Here - the first sentence - is where you mention merging
constraints/strategy/dependencies. Your MFD patch depends on ealier
ones.


> Qualcomm PMIH010x PMIC has a haptics module inside and it could drive
> a LRA actuator with several play modes, including: DIRECT_PLAY, FIFO,
> PAT_MEM, SWR, etc. Add an initial driver to support two of the play
> modes using the input force-feedback framework:
> 

Best regards,
Krzysztof

