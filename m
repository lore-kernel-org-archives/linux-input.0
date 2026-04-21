Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A9383C8C;
	Tue, 21 Apr 2026 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756016; cv=none; b=qzLBqQetvGOUc5ZOsiHqzmbBu8zK4rYSnM1I9/STTVpddOwQBqRWws5hBNQmmLMshuWHUP7+TRVQ2deRMlJ2cpPJhmqhuKTrkRZkpJjkMZ1FPf8TQmvit+9TXLtSNNojQS7RrA+P86uLoSYWhWN5aeYzKslRsT+NgWI7cgd5fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756016; c=relaxed/simple;
	bh=4CM6UPuaNoZSd+OGNTnNr4h5+W05l6C2SEGYATwSoG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1UWEyzDCp8izoJfc5RFKy2PB+6vi3k+C180AHrh7hzGwSS29kjlx8lBYcNAkpsTzQaB3XVNOzu+q+EIhmxfZOw9cTVDmrvzo4lmxrlVBCzZsT5l38FTLPbjwIFNRL6lS03XMJJ2kay9n0thoKg7oXbKQoIpGNYaf1NrkjNRsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2qMNAfQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2qMNAfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFC8C2BCB0;
	Tue, 21 Apr 2026 07:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756016;
	bh=4CM6UPuaNoZSd+OGNTnNr4h5+W05l6C2SEGYATwSoG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2qMNAfQMXow9w+qwEcVAyAFEVkgXFtqx7zqjw+WL0VXiE4MNuhuSC49dTSvagt++
	 tr9oNailz6/qXr1+q/Cav3uMjz4b6RlJnb+5K3U+FQuyHXX3ol6dMDJrZh1FObiNg4
	 PAI4lTF+3zw6i/6fojjo58tahwkgg4RQyPq4D6bz60lWW0ZQn5q+1OhXRYqQBFDTK6
	 Qf1ZHH8svhKLA3xi1hB+91EkNzK5nrHCs+9h67sFaZZMVrv1BDRnysEqPMs2mS0IpS
	 Z6e2u+EEU6mTD1cu2YY44HbKGh6XxLvnRIq7hyXrtjnq7EMlm3/Q/GTAHozWWC/R2B
	 qhzQUBiTB0XfQ==
Date: Tue, 21 Apr 2026 09:20:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Marek Vasut <marex@nabladev.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kael D'Alcamo <dev@kael-k.io>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture
 sensor
Message-ID: <20260421-enthusiastic-venomous-elk-0dbaef@quoll>
References: <20260421041505.4548-1-sainiharpreet29@yahoo.com>
 <20260421041505.4548-2-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421041505.4548-2-sainiharpreet29@yahoo.com>

On Tue, Apr 21, 2026 at 12:12:39AM -0400, Harpreet Saini wrote:
> Add Device Tree bindings for Pixart PAJ7620 gesture sensor.
> The sensor supports 9 hand gestures via I2C interface.
> 
> The GPIO controller properties are included to describe the
> hardware's ability to repurpose SPI pins as GPIOs when the
> sensor is used in I2C mode.
> 
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---

Heh? No changelog, no improvements? No cover letter?

Please start using b4.  You would solve yourself trouble and reduce our
review cycles.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof

