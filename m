Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303527;
	b=BkxVUVb3dROHe7w+tkzB2RHmMUGYWHYleWpoEJEp4pJvtBu2rUBoFV5BiR3bRCGRhRYJ
	 efL+CDuf/kNpARpV3DdRU4KJuwOB9HbixBBegAoUhIt3HFtgpdhfRF5/eCiILFJy0xmty
	 +Sl0Akb2MpUMeitXnoCMEjzbENYHJrdFc5UGnyTJdE7RiTXiHuzszU1LGu5hzHseDUU38
	 5OiQXWuVSEgRtTDamPzlAAJi7ODrxaG0VsfuqdeLfgUbQfofTFyDkfiO7X3S7tzovRjxU
	 ORAfSE6y0tSczAAj3YBq/mwrc6wEB9rtoFnxG/jjmC6p/bq2SyPt2u648PbuQz6Tf1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZjGSr7WT63fg5HnrEeUqlZGAY0d28TuMJr4V0Fm2ZBs=;
	b=OrAsoEJ/U6RzaYQKls0LIo33WpryP4V3lWumfltlQ+PHRKfIW9aA9GNEMvhC5ru7jabw
	 cqEhjVQnn7g54IskQlwuHrW/7fV+GNWhZU8eR0eFyOZJU9Zy0w3GqLgDe7gJUX56nOs+p
	 XftPGq62xL9m35QEs/sq+M4xLZ4CPinT1jHkmlqdr0X+NrGh29rJYI05q2rjnqYjQVKQz
	 v0vSpf1gg5AaFjZ7qt8ID6I6WS8NMEuDSTrfZsWj76NJmWSCPFQCrlDH0AM6cU+KNTzFc
	 WZK/D5Nfk4r7YweBSajPjy7ZYHpf3uwZQaaWOM7/Syxqu9vDmwZS0ZWAAN2DsY0anbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXIrnswZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE5606A320;
	Sat, 21 Nov 2026 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXIrnswZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998BE1F000C6;
	Sat, 21 Nov 2026 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303526;
	bh=ZjGSr7WT63fg5HnrEeUqlZGAY0d28TuMJr4V0Fm2ZBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NXIrnswZF9zMMdi2n0M9x2aLz1efFjGQlzmbSDlOz5Y4yn8MD2Z7Bf7EzP3Qw5iXu
	 As5M/XzhZN9bR/SC4QRjz/IpMXkFQQuTKiUSMI4ZOWi/YzubfW2dbsjfuGSAjMUYXr
	 pOWoHJWG2eE3hpLGPGv5Pf9hbuMHYyfgLemv19F2j6pXe9FdsK/sOuDMCFM8kHS8X8
	 ixy9xxN89kA2iNOtWf+okT2t+v9pHUmDUiEQ1vslyCc4k9hezPKqgcUWFKUoXxOFm3
	 koB3W6zx64Uxpvtc5l6VymfVm888/4RkUfu3ly9bZJQCiQECUQhYES9kHhPclPaSfO
	 S76gKzdqTmkpQ==
Date: Sat, 21 Nov 2026 23:25:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, Fabio Estevam <festevam@gmail.com>,
 lee@kernel.org, maz@kernel.org, andy@kernel.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, mfd@lists.linux.dev,
 linux-iio@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, crofts@kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/4] mfd: mxs-lradc: Convert to
 devm_clk_get_enabled()
Message-ID: <20261121232522.6e8a631b@jic23-hlaptop>
In-Reply-To: <av9h2jvAwBPXdNmX@ashevche-desk.local>
References: <20261119134041.16611-1-festevam@gmail.com>
	<20261119134041.16611-4-festevam@gmail.com>
	<av8gvfhOJ_2PdEMr@SMW015318>
	<av9h2jvAwBPXdNmX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 22:53:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Nov 19, 2026 at 10:15:57AM -0600, Frank Li wrote:
> > On Thu, Nov 19, 2026 at 10:40:41AM -0300, Fabio Estevam wrote:  
> 
> ...
> 
> > >  			dev_err(&pdev->dev,
> > >  				"Unsupported number of touchscreen wires (%d)\n"
> > >  				, ts_wires);
> > > -			ret = -EINVAL;
> > > -			goto err_clk;
> > > +			return -EINVAL;  
> 
> ^^^
> 
> > >  	if (ret) {
> > >  		dev_err(dev, "Failed to add subdevices\n");
> > > -		goto err_clk;
> > > +		return ret;  
> > 
> > If need respin, return dev_err_probe()  
> 
> And above and who knows how many more. That's why I haven't commented on this,
> if ever we do this, it most likely should be a separate change for the whole
> driver.

I agreed there are more but give the code is being touched, if there
is a new version I agree with Frank that cleaning the specific cases
up here is a nice to have (all of them though, not just the one!)

The whole
return dev_err_probe() pattern is only possible because of changes here
so feels like it fits in this patch even if a following one is needed
for any other cases.

Jonathan


> 

