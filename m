Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067B389108;
	Fri, 12 Jun 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302043; cv=none; b=Pr9TfUSfV4wvyzjHmOJHm4DQLqXlaKwlGQXRvZG2cXF4v3LhNjYlHcTmvpZ8XHUc9FZiMbgzu7XffKwoNREtUtsb9fwg5Syv0ifIPHacnT6pPbFQnjKVD252O8nbAIxV9CndDtXSmogrQ5m0avRFOcyy2dQZDlly2qub7S3NCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302043; c=relaxed/simple;
	bh=kal8MWWC+s3/wQwF8S90+qoOyh5nANqkBNfU/7+MzhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqCRd+gSN7EJkO1nNK/06IqwQe+Pf4EJu0oMzk3R1C2avPvRA/+IcYeASissnIs/19KWog2jeQGcVNY0R1BPxYzCQDSip33xcMwBvMhCj6sk7su2NlWY0iq8f+YDzRnKYl4SNK4/lsFPZCpDpuTYlBq3HB+lmru5aCsDcODOFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSeH4214; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSeH4214"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1701F000E9;
	Fri, 12 Jun 2026 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302042;
	bh=IN3NFdrc14uXt12CxYGdLvKSeFnCWmr06lwae8sC5PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eSeH42147TIqEamoqMGijR7mxIS4V3VFsHwhimWdPwNNtSUKeyvlWgLd8MS9WZAAH
	 /GU8SoIi0KbUr1+vjmG1SphztmEQwL75hCu2Eb399lVwUaPOSj6IsrDX6RzaSPlAGw
	 iRNDVY7mR1Mo2yjBAnV5aaLOKMG5zP4KLHJHO9qjPDk/pX4dmWhfSuqLiR+mOf/lt/
	 zg31BRI2ixfhkVcxPOECcak+LgDtoHUlyWQVCfU5gtiGa/9ickcR4bJ+TjD1nwN9ax
	 kklPeAovejBrzj7S0qSalz76zg10S42g4ZHMnqqXLeIXn9gOTWLo3xoLozQQHA4ice
	 rwcQE8V7io5dw==
Date: Fri, 12 Jun 2026 17:07:21 -0500
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: hwmon: Add Apple System Management
 Controller hwmon schema
Message-ID: <20260612220721.GA1901304-robh@kernel.org>
References: <20251215-macsmc-subdevs-v6-0-0518cb5f28ae@gmail.com>
 <20251215-macsmc-subdevs-v6-1-0518cb5f28ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-macsmc-subdevs-v6-1-0518cb5f28ae@gmail.com>

On Mon, Dec 15, 2025 at 07:37:45PM +1000, James Calligeros wrote:
> Apple Silicon devices integrate a vast array of sensors, monitoring
> current, power, temperature, and voltage across almost every part of
> the system. The sensors themselves are all connected to the System
> Management Controller (SMC). The SMC firmware exposes the data
> reported by these sensors via its standard FourCC-based key-value
> API. The SMC is also responsible for monitoring and controlling any
> fans connected to the system, exposing them in the same way.
> 
> For reasons known only to Apple, each device exposes its sensors with
> an almost totally unique set of keys. This is true even for devices
> which share an SoC. An M1 Mac mini, for example, will report its core
> temperatures on different keys to an M1 MacBook Pro. Worse still, the
> SMC does not provide a way to enumerate the available keys at runtime,
> nor do the keys follow any sort of reasonable or consistent naming
> rules that could be used to deduce their purpose. We must therefore
> know which keys are present on any given device, and which function
> they serve, ahead of time.
> 
> Add a schema so that we can describe the available sensors for a given
> Apple Silicon device in the Devicetree.
> 
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  .../bindings/hwmon/apple,smc-hwmon.yaml  | 86 +++++++++++++++++++++++++
>  .../bindings/mfd/apple,smc.yaml          | 36 +++++++++++
>  MAINTAINERS                              |  1 +
>  3 files changed, 123 insertions(+)

I fixed up the error and applied. Please ensure all your patches get 
applied.

Rob
