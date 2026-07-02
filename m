Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55B4B8DF5;
	Thu,  2 Jul 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009473; cv=none; b=Df+HPOPyzbNOWMKoxjUSud+KnpvRJ3FJNx9ZbxuIQKLp2ygXRzx+HOzXQuiemSz5cEDrdcjiCnUjpsYWkD7lanXHsEDCXr5COb+pw+yJE0vH3E007DosQGykq1UyaNGUtUjvSPe9Zb2RvtEooEQ3gLYU6Ronsei3TDISTCK8BQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009473; c=relaxed/simple;
	bh=LyELoBdYpOS52lrM65tWCHhBtYJPbctbHnjtovUWUdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L22TmLqXJGzmi0uGw0cJQvg3bmms2S9FpbBePkUDkYG4vgUesi6oU/ML39j4AcymR0pSTgMDdmsLE7hn+fj4G8/mRiIqBjwr/unLBCEJmRJzXYb7Ym4bZGp/sCnxECpScvAm0rDHbIsE6DBUjkd1j+88U9FEBYHTe79WcYbnZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrYeRCUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrYeRCUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233C81F00A3A;
	Thu,  2 Jul 2026 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783009471;
	bh=cqd+4QwoSxwHlQ2+3ip+f3FNRocLcFAUKig9cva6AE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrYeRCULMDMZneRGnsoqgqfV3S43/KxQri2F/0qp9fnc0w7RpFPdFpA9+sQuF09Jd
	 MgU8pGAZcMovKNwbh3YZczjgFfHIobsOJe9d2gKHm4XL/lOQ/nmYQvEdWC6NLlen47
	 zlpLN/Adz6HiOQWNvJaO7by7d1hH3r5uuW2V6vOlVRpgR9EoEjyInAK+2JwTRDDZML
	 nRlnPHwt1+p1LenBFB7Xzm+EPyTpDCSGVE7wBsPQDux7VofNt5FSyv9OlffWiZHwBV
	 oqFJNpIavFVSA3fPlDrWsvcRQcX3c2JBJ4mV1IKAi0rlw7VaV7hSkKckJFhX2V92aX
	 iUcemQfQQQlXg==
Date: Thu, 2 Jul 2026 17:24:25 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 0/7] mfd: Add support for Asus Transformer embedded
 controller
Message-ID: <20260702162425.GD2108533@google.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625081529.22447-1-clamor95@gmail.com>

On Thu, 25 Jun 2026, Svyatoslav Ryhel wrote:

> Add support for embedded controller used in Asus Transformers for
> managing power and input functions.
> 
> ---
> Changes in v2:
> - converted sysfs debug exports into debugfs
> - added kernel-doc comments for exposed functions
> - fixed minor typos and inconsistencies

LEDs and MFD look okay.

Let me know when you have all the other Acks and I'll merge it through MFD.

-- 
Lee Jones
