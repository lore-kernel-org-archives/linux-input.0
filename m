Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877595;
	b=BPyo8VRjA1XmY26lyg6W9sEW4C9Ln5970hK1YxKQ6fXYqyVOqlO2XBaQ6bVHCSO4BB55
	 dUyuT7OSubz+fXGEazO6yz3lwjlk5clPdXblrjx+QrRs2DwbCPwDv1TXtMMUJmeBQ/zQ9
	 f+T0fDfgF9JkgvWTFqlVewzL7FQETfAeEmHfTC/Ju3MbjEdiFFOcZ7EzqNWgza8hfwgkb
	 FPhbnKMVy+yZCEOp9kB29qzHikFAhSm0kHPBu1RjoNmkwSOpo2kNVm/qZI5YhY2bgPNCs
	 DlydKOvqs6+JGz0dJZuPWPFbi/9T5zsXVI5e6fZkzgeTXl8VRPI0czHJ6/MfVz1u1FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877595;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Xo2TeNYm3Y+NU4DLM/Wdmt98w6AupRWkAbW2xAINB7s=;
	b=RFQJe+PTS2e93I5484XHWxHrLmqdbN0qfLU6nEEP4wm4kCVnVYJ9oW/FgqEARQCUjRBX
	 u/3DG5CHgo4bSF8n3oJWsPVoQOTaIB1o/dt9QDD1X+RiubTL0MlCamGEjXb/jCz599+SY
	 EXrG/avDIJAPeMzARJTIz5JEgQN/feNoPR4j/IRek32aeKRyWynvh1gRP9/vcniJI97FT
	 KK+iVqmunCLMQXwYZbyzulXrVsmGwQHTvQ6cPyWaIn8Nho3U3Eyc8Bz9SPQ5rE4rKIgH4
	 aqKXFrS5x8OD5/v8c3yuwRmjiYo+wB3/MDiSJ6GYRJjupfTfnKwqi/pZ02p0aPB5sEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIz192A6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CB606A32D;
	Thu,  5 Nov 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIz192A6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5641F00919;
	Thu,  5 Nov 2026 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877594;
	bh=Xo2TeNYm3Y+NU4DLM/Wdmt98w6AupRWkAbW2xAINB7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZIz192A6fQlHC/7KKwSUPIBtzVxXwVY3LMJ8un1ogis3DOElJiYACdBDHf9e5vgQj
	 wOncDENcOuCCg1akE0rc6KI+dGG3jIM3ROAjSi4/3HzGoegq/FvSss7NyUQf2BSoQ+
	 qoqDgEVNdNrvBi4Zje/2MhcOg1s38afsfDgsihl2vRV9o+n1s3jb2ApKpBQ8L9/M+U
	 FiTzZYMrk+2zfColytZVPcmFrg20eLxDD1+2lXBSMW1zed9uZbaS9COEFayf2HFYmC
	 kEpey+4bBY7onGEbYYRvYlBL6EgcwyBxSncPDimAFCM0npsM7+9Yv4OApS1LFTm/MC
	 2mw32+ceHeVkQ==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>, 
 Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Florian Krischer <florian.krischer@fkr.dev>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, mfd@lists.linux.dev, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
Subject: Re: [PATCH v13 0/7] mfd: Add support for Asus Transformer embedded
 controller
Message-Id: <179387759097.2453405.11589718445889906023.b4-ty@b4>
Date: Thu, 05 Nov 2026 11:19:50 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 04 Nov 2026 14:25:59 +0200, Svyatoslav Ryhel wrote:
> Add support for embedded controller used in Asus Transformers for
> managing power and input functions.

Applied, thanks!

[1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
      commit: 2880926d48fe884042a1b7b64b431f9ee9531806
[2/7] mfd: Add driver for ASUS Transformer embedded controller
      commit: ccb21236e307ff60ce6b96d2f9925abf0274ce8e
[3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
      commit: 3fefdd9a8931eb3b8cade87193c81293256031f0
[4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
      commit: 4ace8a63a1612f8142cfdf5d6d4b8e1be37cce3b
[5/7] leds: Add driver for ASUS Transformer LEDs
      commit: 04819cdb3912f31586516ef6fc007daa3d976234
[6/7] power: supply: Add driver for ASUS Transformer battery
      commit: cd72536270e725b4f1d56df6287c4c34efe953a8
[7/7] power: supply: Add charger driver for Asus Transformers
      commit: db6674a08304d03a194f5e09b7543323462b3516

--
Lee Jones [李琼斯]

