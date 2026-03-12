Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1B38B142;
	Thu, 12 Mar 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327768; cv=none; b=fwSraq4Z7jCnK99lcjp5tbjqe2dZn3bch9jpE59CXuW9CLmKXzqG0N2P34U/4CWuIl6lHAoGlOlzLI/9SRSJfsZX/drVcGVEDB9G1accS9J42BinyI98U0PnZDo0fBPpRl7ZhlPiTCoc+d64eLnKSlrXRxIALagOiSKPZuqItnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327768; c=relaxed/simple;
	bh=TpkPTB7QLdvbC4dHR6TujTwcsq+UZavtyYNcVQaIn8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5zMYs7NjNIW6U2lafhjXVVpDaoR+dXb2llfgK6cE75HYuPLCwVC12+G9FkBI9WhFpKhgwCv0WflIhaXedwgyMHr68OrzjWJPGivK9iGotzpSZ6V8rQM8f33HRfoQQyoDL/eLA12SNZ+m87PoluNWfeb1KLoz40e1LCl5fDVZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL8L4A2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL8L4A2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FC2C4CEF7;
	Thu, 12 Mar 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327768;
	bh=TpkPTB7QLdvbC4dHR6TujTwcsq+UZavtyYNcVQaIn8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TL8L4A2J+OVcHSsW+sFEF8DX+wdUdayeayT2LpXXU/x3QX/5AbQZxSOTO9XFc7CW7
	 nDBsbE9oPxei35cVaz+0I2D/f7j+WlxQLJpEM13wAgzSSil+rJ8TPWzmwozp1WucMD
	 47NMaLwv/Sr+2TYoGCxEef/JWKlKXPvor4Vm+VzlmG9kf3bJONL5Ta4x1WXm/KhMXV
	 CMQlvBeLQyZyLQm7BU4J45zdullwA9qAtUpHbOkAdRc54N7vYsSLCGEfTe25/CdnfM
	 gzXUHulqafOUEPo2po8tFnnskkAWDpthmtT2zfyv4JC3ICEoWCq0FxbEICRJkZm2fB
	 h78LjOdVZ6pTw==
Date: Thu, 12 Mar 2026 10:02:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: akurz@blala.de, linux-mediatek@lists.infradead.org,
	mkorpershoek@kernel.org, andy@kernel.org,
	devicetree@vger.kernel.org, alexander.sverdlin@gmail.com,
	dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	matthias.bgg@gmail.com, lee@kernel.org, robin@protonic.nl,
	linux-input@vger.kernel.org, conor+dt@kernel.org,
	marek.vasut@gmail.com, hvilleneuve@dimonoff.com,
	geert@linux-m68k.org, angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 3/4] dt-bindings: input: add GPIO charlieplex keypad
Message-ID: <177332776621.3126889.16026156130288096432.robh@kernel.org>
References: <20260305192101.2125660-1-hugo@hugovil.com>
 <20260305192101.2125660-4-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305192101.2125660-4-hugo@hugovil.com>


On Thu, 05 Mar 2026 14:20:49 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add DT bindings for GPIO charlieplex keypad.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../input/gpio-charlieplex-keypad.yaml        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

