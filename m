Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E162339870;
	Fri, 17 Apr 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418500; cv=none; b=cB8GZxLhDsDLYNWVOWoxgsYT8RQi1YjD0mGXI6KfpaJ2ERQfp5ZFl74+LbGo7WgHQJHVxL2WqXaZ0FXtD3QNHh4MuI7WPopRIHkjRw6zHDLZGa0oxVjviHCTR16vLHohg/5mHNiIEaOLhOP9mMNlsjU4x86FNfMbBZUybXeRWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418500; c=relaxed/simple;
	bh=CiICIPaQkVU+7oY+tYHdDg4ZGOkotaeNHwMDysE51rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwqwtGjqBL71OyGdgiTtPJnyDE7RPq6NDOi+JBTANRgoYjv99TgpsW3VO9FWd/zQdXAIWUzdqGCGLUqVHS6fC9m0++U1RCXZY9LgZNeXrTEKyc6d0mJa6EP98z00V1eQeZ8dV3CzI3rZyCWkmb+gyPGY8tln1k4byUMOO+jJhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNSUxjUB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNSUxjUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8B7C19425;
	Fri, 17 Apr 2026 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776418500;
	bh=CiICIPaQkVU+7oY+tYHdDg4ZGOkotaeNHwMDysE51rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNSUxjUBCUWujUex2wdDVw9ACcYal2ZL0DRKKASNk+0ePLcvLQIfIcsRmZDUZeBQN
	 oX9ovkI3NajERsDJGeokPNRfbn9KTvKgJv18sk8g0izbiPZiHATiNJzvq6Qaqh3OLH
	 1Kj5m1a6wlR1NVo2PiHqm4FGOBtqfLYu2IQ8O/E2oI51UWQtYM95mH5YuaKFO29Fw7
	 EKdFHS5BilEX2Ni9pqRlV+2SQ1W9+aTgyMmNaD2SUNELbwwrTQO6ScY/3nXw1lhv/h
	 LcuxhW4Vg91dyuPW+MSgCouPhsrC713pLb6vKQvTzGCaCaXanJEK49HxOzrDzPwK+i
	 B1Vgo/flnVqVg==
Date: Fri, 17 Apr 2026 11:34:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture
 sensor
Message-ID: <20260417-mustard-nuthatch-of-vastness-3fbf4a@quoll>
References: <20260417052527.62535-1-sainiharpreet29@yahoo.com>
 <20260417052527.62535-2-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417052527.62535-2-sainiharpreet29@yahoo.com>

On Fri, Apr 17, 2026 at 01:25:26AM -0400, Harpreet Saini wrote:
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---
>  .../bindings/input/pixart,paj7620.yaml        | 70 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> 

Comments from v1 apply. Respond to the instead of ignoring.

> diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> new file mode 100644
> index 000000000000..d4f58b712810
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org
> +$schema: http://devicetree.org

There is no such syntax. Don't invent own coding style.

Best regards,
Krzysztof

