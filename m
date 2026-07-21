Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491136A379;
	Tue, 21 Jul 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642062; cv=none; b=nwMiWPqS4rU4B6gUyc8eQ5Pvk2tEkP4H5aUITqbsKwnHlfVsCoMm6Yx6LsJVdV7lVcqw/DA4tXGRNVMWll+KHhA5UAZOqV7WU37X9qeDJ0exmL8CJ6O4dmPktIkFT/SLAw5dWuyKiz6I0j6oK0xj7CsSF64LwcYOwT7PgtGSAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642062; c=relaxed/simple;
	bh=DjUODwckORUXkSDn54EUQ72mXVHEhRJY9IXzbxmIrn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPBzu6q4dIL7yBU550ArvBd7mJsqVG2NjGmB45p5k/gs55MOirKLPas18pidTQGd2Ldjhr//vQECxb01t+Hr/KtGx29bHs93kqBEjdQBi1+BXykwJ6zCdOc1+xJdUiE0qKd+KRG7OfAD4m2RD8L64vL3no6tCsJPrvedVKBVqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEYUDazT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEYUDazT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9D41F00ACA;
	Tue, 21 Jul 2026 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642061;
	bh=qYyiAGUbxXDG78LaLLdHLze2qNl8P4U573ch+SMJd7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TEYUDazTZRztUuTTbi9dm/TyP4U2m5HKFy2IRkK7Kmez9ByIyS2CBpUxsbqlbcAPR
	 47b1hJbEVwMZkSAkueJf9OFOms3wzm/tS0xcBznNFcmyThFOou68WdM3gk1xQO7924
	 6e7n2RDwmUCt1XxmjSUnYdkVxQ7mJkY0J0Rvmno8iqzOSw7FQ05mY2CUn056KPzGGt
	 CPoOcUQJZxcSqWBTJerTREefdxVRmWy3o5LAaqUZUrzvG0CjF4ZcAR98eUNhHS9kJA
	 zknbDi9xCec402kcsCFaMZiBbhCuQ4zoUj6fsYKCyGVCh+CpcB6Fn44HYu+19UKBMs
	 M21GCsn//x6ig==
Date: Tue, 21 Jul 2026 08:54:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, simona.toaca@nxp.com,
	goledhruva@gmail.com, daniel.baluta@nxp.com,
	linux-input@vger.kernel.org, m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: input: Convert TI Palmas Power Button to DT
 schema
Message-ID: <178464205888.3484512.3164835125318035810.robh@kernel.org>
References: <20260719141701.3565277-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719141701.3565277-1-egbostina@gmail.com>


On Sun, 19 Jul 2026 14:17:01 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments Palmas power button bindings
> to DT schema.
> 
> During the conversion, 'wakeup-source' was added.
> It was missing from the original text binding but is actively
> used by in-tree boards.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/input/ti,palmas-pwrbutton.txt    | 35 -----------
>  .../bindings/input/ti,palmas-pwrbutton.yaml   | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

