Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA14459AE9;
	Mon, 19 Oct 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396641; cv=none; b=sFOGsKvQtAbMchF2iH/hPmux+UleGm0lHgU4aTyvJ+dk4AF/0gjcQOE//a+D0PLN0EAX1YWHkxiWc1CHLAdplmGT8mk0V0YX+0djsI3NuYty8qY9U8Cc4Y86zU6xXRGHLLyUrOiSrutkVzHjUzK/lS4FE5Zsx82SjlPO4llUHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396641; c=relaxed/simple;
	bh=39EHTBpofCeM+Zru0UR773ziVnE3Mq4Q5P816BwJeVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikYNj8Lbl2hRd1fvCv8TAeW0BiNooKMXXXP0AmOCdinuKrwGo9DwEyTp/sYgZEY021/ut9vvO2UY9TGu50yXuR4GJ5kbrnXjALrvY95y2CtAU4gZ6lzxZeWAOJST/Y/ikv2BC4tyoWcdOsvj1UcpS/S+BD0ZL3ovkPrsgq9zHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofg5SDk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofg5SDk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA601F000C4;
	Mon, 19 Oct 2026 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792396639;
	bh=lxCrtttuaTH95qfBBM+pqBIe6QEQV9wb0eaFJI/X8WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ofg5SDk8rSv+3FegWzG8WSKwQtVDgBD1QY1SF1lrIzVGhzO1Dm2DNIoW2fBKw28pe
	 eC7BCPDYpUV7SwX2/xysXKLYRu7/3HphUWwwbr6MHQBOxHBh7aFve/cwYH+sOWA02Q
	 IotdR958Tc30SAfylzKkFdHKrMv0Gf1WPqE/pOHFHpE0fyr/CTxiNOXUjeMhWhtV9y
	 egNCniwyMEH5dkmdzkqlYSCFc5c8wFZL6eZeSns5qXYLUne02OfoA6DYm2WHiIXpl3
	 AMOKE/5DJZOAB0Qa8PZ8u4SqrFuj0m8a9j3+1c/VbkWBC09PnWNxw4pWW6eLvXiVx0
	 acatG7F9YGMDg==
Date: Mon, 19 Oct 2026 09:57:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luka Panio <lukapanio@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT8722
Message-ID: <20261019-free-groovy-grebe-7e50d3@quoll>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-6-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017140827.290666-6-lukapanio@gmail.com>

On Sat, Oct 17, 2026 at 04:07:53PM +0200, Luka Panio wrote:
> The FT8722 is a touch and display driver (TDDI) whose touch controller
> is connected over SPI and runs its firmware from RAM. Document its
> compatible, allow the SPI peripheral properties and add a
> firmware-name property for the firmware to download at power up.
> 
> The "-ts" suffix keeps the compatible distinct from the one of the

Same devices do not have multiple compatibles, so I don't really get the
intention here. What is documented already in the binding? If not touch
then what?

I also do not get why all of the properties are applicable for the
missing 'ts' part.

Best regards,
Krzysztof

