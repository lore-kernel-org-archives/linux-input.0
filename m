Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877706;
	b=lJ975fGEbJHQCQ0+Ad4o/asix81C/0Wji4fAP95rTaFF8GmAtiiuE++i3g3slZ4PABg+
	 A3yalkp45JX+Q3KBWg1ZsJBxF5SDr12rElZ/ILY7G/x4uqRXAaoi8gIyIYpvmZMwLq6JB
	 JnaO9v4CRXM3neZ+/4sJPy/Ua0R1Dih+BvC4cajI1lzKGN0QnB0bBy8/BaZhDf0RwBFJw
	 apTFJe2nawfw/CK6xJFiJgQCjq+VmlEvI77tLo6jdhCyECqC4nhD9JtAXUeGEGli810R9
	 /sKEqUF4ll74sor+Z4be1N5y9l5iuMQlzem3S0zlWsIDCAs1yfmSb0hA3zm7MGHmGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877706;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MHdqHAA/2dqHJJZoi1LltUcmTq5osveA5RSMvjFd9mQ=;
	b=Mbb9vvle4GgiYkqho3q4jRvT7JCQrp7lWMrhxdTM/j8FRXOCYFZmjqAdx3/aE2RN22SA
	 Jtqx1vsRQfIMDqZwN5iNpIkqSPiMHfIvsHelgLG4EN/DmG1got7Y2PkTr/IWVBKTQSTJl
	 Va9GTHniCkl0hppE5OoYO91qicgTk+skbMaOgRLT3nv5f777rB7L1tn4NIDnBcXa6jRoL
	 q5u5KL5wdho2OFqcfYY5ZvcRla8Vu7cZ3s+aL23yBs25wyWqK3Zv77WNUo97KJtLnHXCi
	 NKgBqUzMZFcXexLZ7Lyts1qnwrIHLZVnpB5B5abcsgZTOL9NPHlh8ZXformzQ0c43hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSfMXnBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98521606A31B;
	Thu,  5 Nov 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSfMXnBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AED81F000C1;
	Thu,  5 Nov 2026 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877706;
	bh=MHdqHAA/2dqHJJZoi1LltUcmTq5osveA5RSMvjFd9mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DSfMXnBZN6Z/mUHNWRm07w3iIh9jIOOmyNwdh7U2xlDX+dxtSg7Sh4IY4u5bMiOEU
	 5YoSuShqYC/UqrdrgHY3r77kJIlx38ZhFWBjPFxZCdPyY7xzwN9OckNGv+BicYTGUh
	 lkzxC41HtPbpUyGkLjf0yXpD7ObWI9V2USOSRsFfA3bOJ63XCiePk5tnGC83cjF+3h
	 9cZa2va5GUTkcONiExKfUHdC5JyKuFkLEotkaukgGmhhZ/lWNJ8l3LK/W1hYZMYnbs
	 4WNbbVzHCyn941YKKZsuQWbCeXzwOs5odV64Lum/Z5IAIlbe1aYZpzQMhPpxy0CC3x
	 IrJLhhcxto5sg==
Date: Thu, 5 Nov 2026 11:21:40 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 0/7] mfd: Add support for Asus Transformer embedded
 controller
Message-ID: <20261105112140.GI1650678@google.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
 <179387759097.2453405.11589718445889906023.b4-ty@b4>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179387759097.2453405.11589718445889906023.b4-ty@b4>

On Thu, 05 Nov 2026, Lee Jones wrote:

> On Wed, 04 Nov 2026 14:25:59 +0200, Svyatoslav Ryhel wrote:
> > Add support for embedded controller used in Asus Transformers for
> > managing power and input functions.
> 
> Applied, thanks!
> 
> [1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
>       commit: 2880926d48fe884042a1b7b64b431f9ee9531806
> [2/7] mfd: Add driver for ASUS Transformer embedded controller
>       commit: ccb21236e307ff60ce6b96d2f9925abf0274ce8e
> [3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
>       commit: 3fefdd9a8931eb3b8cade87193c81293256031f0
> [4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
>       commit: 4ace8a63a1612f8142cfdf5d6d4b8e1be37cce3b
> [5/7] leds: Add driver for ASUS Transformer LEDs
>       commit: 04819cdb3912f31586516ef6fc007daa3d976234
> [6/7] power: supply: Add driver for ASUS Transformer battery
>       commit: cd72536270e725b4f1d56df6287c4c34efe953a8
> [7/7] power: supply: Add charger driver for Asus Transformers
>       commit: db6674a08304d03a194f5e09b7543323462b3516

Now in soak.  If successful, I'll follow-up with a PR shortly.

Note to self: ib-mfd-input-leds-power-7.5

-- 
Lee Jones
