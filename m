Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA136B061;
	Thu, 12 Mar 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327816; cv=none; b=ZC4Z2OInRXkBv0uje7WeRExbKETzIQXD+Ps8wKLR+Cr6wPsgEJ9puAC1GDGoKU8ESykYxfltXrerfE74/VjSS/GjoinZyC1G2cByjwukedlW0GjHM6b7h9MgbRUW7aZJfv30qTdH0+0f/iExBHhvKWQBRVp0LTspu7OOCMt+5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327816; c=relaxed/simple;
	bh=GEXo/a8VwauPBc+5TYF8XHAHuKgUh3BlIdVX1JobXj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGbRF9FNCuGZmXGM0pDtv+UEyHC8OA+jwLpkJ1HAJioMZC2n7IwLur68dSnL/hvPlzR4m+IQ1CWqwELoshBRdUUZdHCAjJYSFi88zDGuG2CwWoPhM5OiR414U5tdHl09AUnFDyEabnq/XX6xmXNjHDhtpasB4UXdSClzPveB/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcIjGkrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcIjGkrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C83DC4CEF7;
	Thu, 12 Mar 2026 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327815;
	bh=GEXo/a8VwauPBc+5TYF8XHAHuKgUh3BlIdVX1JobXj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcIjGkrC7M7ZBopqyOoijpIoboeP1DH8ortMPA3WkMM2isO/EYn8K6TJ7dctpXrSn
	 a+leYTWNIEeztAr26C6uFQ+yBlRmIFEaT6Fg87RqRn9IoIxw2K07Gjd2KUxczorVea
	 fZSZ33BFqK7MdMRN9VloNCJD/Jnnyx9zye7RbWqRj+IU8sfc5XT8MOOwVZQVl+Hu/W
	 Rnlu21CQMx6Np2MAJ5lG1cUv144eodxoHnzwlM9dYjD1PCKghZj/cJKYeXQalKFTvc
	 Yhlwf2KtwpNJzvGgYs9gEOE6CbUFPcfGmkmwygSc8xtW+9NJ8gPh2Gf8HKwtGGB7xn
	 L4B+udfRJv28g==
Date: Thu, 12 Mar 2026 10:03:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, akurz@blala.de,
	linux-mediatek@lists.infradead.org, geert@linux-m68k.org,
	lee@kernel.org, hvilleneuve@dimonoff.com, conor+dt@kernel.org,
	linux-input@vger.kernel.org,
	angelogioacchino.delregno@collabora.com, andy@kernel.org,
	robin@protonic.nl, mkorpershoek@kernel.org, krzk+dt@kernel.org,
	alexander.sverdlin@gmail.com, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, marek.vasut@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: input: add debounce-delay-ms common
 property
Message-ID: <177332781406.3127906.8010880733088237830.robh@kernel.org>
References: <20260305192101.2125660-1-hugo@hugovil.com>
 <20260305192101.2125660-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305192101.2125660-2-hugo@hugovil.com>


On Thu, 05 Mar 2026 14:20:47 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> A few bindings are already defining a debounce-delay-ms property, so
> add it to the input binding to reduce redundant redefines.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml    | 5 ++---
>  .../devicetree/bindings/input/cirrus,ep9307-keypad.yaml   | 7 +++----
>  .../devicetree/bindings/input/gpio-matrix-keypad.yaml     | 5 ++---
>  Documentation/devicetree/bindings/input/input.yaml        | 8 ++++++++
>  .../devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
>  Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml    | 2 --
>  6 files changed, 16 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

