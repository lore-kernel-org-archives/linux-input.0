Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209783A9D95;
	Thu,  5 Feb 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291879; cv=none; b=gnaImZ8XaIq33gA5YHPuvYf9rfmvTDaog3xlgo9vr4FimdY+n7ngCFNWPhiok4sAJFW1oEcWj/3cAgeLn4YClKaiA4wPo6lxm/ZGaJoru+x8KQPe0AqpEaNe+5MyvRpT0sULAYC1SehsFHOKoMUHrEZr7xKwcEddNYpvUk17QyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291879; c=relaxed/simple;
	bh=hAAHav3T98aKj321vhwrLR2ehXeVSbOmkejkdN37/rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRzjMfn3rDPh5N0qXAPrDcoaxCbLlIOAEI3TIbIDznk7syAvBdiDDHYZfby5XFgEFsLVtlGOjhIMgA18aiG4g1JhSJWCE+G1OzN3uuRV6ksDmtbjPIa8vJd3Y96eL5rX5XxJNkhEqSszOGdr6H2HmPIlUAWPo9u5nMC3hSAFTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXM3efcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXM3efcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F66C4CEF7;
	Thu,  5 Feb 2026 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291878;
	bh=hAAHav3T98aKj321vhwrLR2ehXeVSbOmkejkdN37/rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXM3efcnYFetp6Q+ZBeh1IqjJE3T67ivogdHO0eoMp5Pwgui8vEohgllHkt1f1iva
	 /JcSeIoZ+Lqcwh57L5XR1sC6o9tE+foxESQTZMyfi/Wuqnm/40q6jawvf+c1SYUUCV
	 MgbcdZ4GM4klYVaS7W0o6kIk9A/BFg5CHBiBkbTP04wz1wU6IgCxt7WabW8v82OTqP
	 rTbsuDgJYGTF302TjDFkhVtXpWbq2ID/nK71mFmqbeSJsjIWKo4BzlMns9u3cIinVJ
	 Qjb2jgCV4AqFMLYOkpL55ldYB549SG9SfOVNQA4Xkbfd5qG6+WzMDp36NgGMr3DrQ2
	 RmBaZU40iazOQ==
Date: Thu, 5 Feb 2026 12:44:33 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leo Huang <leohu@nvidia.com>, Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>, 
	Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v12 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Message-ID: <aYSCiHf5eFp7m5dQ@zenone.zhora.eu>
References: <20251126-cp2112-dt-v12-0-2cdba6481db3@plexus.com>
 <20251126-cp2112-dt-v12-1-2cdba6481db3@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-cp2112-dt-v12-1-2cdba6481db3@plexus.com>

Hi Danny,

On Wed, Nov 26, 2025 at 11:05:24AM -0600, Danny Kaehn wrote:
> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> 
> The binding allows describing the chip's gpio and i2c controller in DT,
> with the i2c controller being bound to a subnode named "i2c". This is
> intended to be used in configurations where the CP2112 is permanently
> connected in hardware.
> 
> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>

just this patch, merged to i2c/i2c-host-2.

Thanks,
Andi
