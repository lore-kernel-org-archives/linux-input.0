Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51944384CC8;
	Wed, 24 Jun 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283911; cv=none; b=baYogcdoNXqOqZsx6mWb3qL024v4v0WrVTdT5LH/gVxXFIbcCZE30iiLxtcfvB9NJcaEkBM2uFxAWdvbCTtBNGufeX+mTt22Doa6gmdKVOLNXZRA1CC2GGebDzYcBAqoAQMP+w799SVZGOx7jyFYO23SxcoJSsSEx9BSHX6HXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283911; c=relaxed/simple;
	bh=eWPAhm2DcuU/AGCNUbxhMgdHaJXylETkg/nkqUZxQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBJqtEJxWPvKcpIlU5JHEPFyW0tUfi6gAjbhPs8pfvjivH3ZYzgwtxibi4pfGcZmddrWAzkhILhWZ9/Bbmxb4/qLLAPjjZPh1FdKQ11PTiAv8wnHAQNVp0oQ4D3R8q+sUlnv4TONaQsnnhM6wVmTa30nIm4pAfFpmMrN7zAXrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d89k0TKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d89k0TKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AAA1F000E9;
	Wed, 24 Jun 2026 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782283910;
	bh=jrd+LkEfv5MAEbwJjh86ojQMQ5+oIm/B8nP9VkcnUTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d89k0TKgopbxJmvGycsqeVSY+xGJGzRzXaVBcfXFoJy+9paWh0L8ej6bqzVeeOZGo
	 MP7yuIprkO+o39oCTqarri6+Re+E1mR9p/qurHPz5oYCknyQf74R5/Senf3gDf6QhN
	 kZyCSuczjYORClqNgzcMYAIagaSswByNH3mvXclH5rffyDJb6570+hiclLbENVXEuY
	 yosaRTwrRS/4lGLZVlX4V1TAd+r9T7Afbf/8AjxVmodMOCMZaly76opo0DlzkwIFx2
	 eDONYgujK7SDbl/jPw+ywTG4k+EPfNtMzj5tQJIKly17fm3YGcsM1/hQFqhZfSBVvJ
	 g7M1upLooy84g==
Date: Wed, 24 Jun 2026 08:51:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Hans de Goede <hansg@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>, 
	Lukas Schmid <lukas.schmid@netcube.li>, =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: input: sun4i-lradc-keys: Add
 A100/A133 compatible
Message-ID: <20260624-awesome-demonic-guppy-d494a7@quoll>
References: <20260623204824.691832-1-alexander.sverdlin@gmail.com>
 <20260623204824.691832-5-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623204824.691832-5-alexander.sverdlin@gmail.com>

On Tue, Jun 23, 2026 at 10:48:16PM +0200, Alexander Sverdlin wrote:
> The Allwinner A100/A133 SoCs have an LRADC which is compatible with the
> versions in existing SoCs. Add a compatible string for A100, with the R329
> fallback.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

