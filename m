Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792481250;
	b=NHFOPR337nbnznSnu+QlIJT1PAJYskiX8XWpSuAgO1xItjkszmtrQth8vPpJVEPuFmOo
	 2N86ZzF22D7pQpjyNmhbjaTBbSYAgKce9BbzQLsYUtPrdBd9efFIlGlz9vhlD6Z71jlKi
	 u6f7MDQPw+ZVwodLska1yenVhkDeJrytRzMwNIyu3PlL8yKF3jrMYTE9bp/BId8Hrag2+
	 6i9JkM5czxbEtR5rlmkCQRA1mK7Coi7mI+do/KhdWRpUF5k9lo2ZSXpx6y9/Nl1jbUrIr
	 fGYxlvOOeW0mIM7RnTulYEeQ/9M1br96BeLRh5LrchpPIslJBCBlF+bpEAXHmubpS7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
	b=ud8ZKUFW0oDsmot/OgGfNXWhacmPrBsZ57wbgZCbcEBLbOWKYXmpP6DYhtySvbtcqfO6
	 Dw8ZOniyjJJMnEvkaS3WPI6EPU41Xa4qra5kdJLkGjyF330rikHxJaEx39oviUeFG5vk8
	 sVAwvmiSOK2CgyMc9yIew2pSx2xsG7/6R2PNr93csExFjwR7zLzbJCclc0Zc+2p7m0FzL
	 n07qPYSu5kzxhZio9xc9j23UtAYdudd+v6Ua7+gk/FW76S1+pOVxfFKTadsO26zlAVXvj
	 TVWMRUx3ppMu7Bn1j7ugZiA5+g0FakEt0wT70xeEpFEyoD7q2A2MyQIYep/9RCU3t5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BSkiROCn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD469606A319
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 07:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD469606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BSkiROCn
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso5572031eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 00:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792481249; cv=none;
        d=google.com; s=arc-20260327;
        b=k5uK3Mwh8YaQpA/5yO9bUZkXFIVutwhyhTquqtRpGEmbg4AMxtXlrGbWK98bPil95s
         /GpPW9AfCU0pv/EEPQqhNQ6ePYp2j1kPqGxqzvC1wGtjwEkwwSfpj9reS1K893r4XzMe
         4SWTDLXYgDK4xHvemFHSBC3oSdCEXkFPsQ3uoFtyj1Y5+pgkNB0zOkkwgWRbriecsStK
         +tBrjgXpENVaZB3puD6VNpkObZHMM/xk1I10UyU7Ibh/FYN5mcKCtpuBaWCOQLi+Or+s
         W+5+RnDvvJlj57Y+EK025qihUU7+/vq/Zvj/DhgN/MCDqQjfIaJxl3fD9XWtsW8jUXiI
         sxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        fh=UG2pOFgrnn21kQjLB8WZ49zOE0vPaywovzI3cM3zHBc=;
        b=AZr/RFkNz/RXCQuYMXqrYaoY/fmPphfZSDUdlNVvGbY/rIYPAtqfyLXZgjfpcllsJ6
         9R1hYZkvKJoonZAfea6TMHZdCg9mTvXjm7DO/WgHYuGVaeT/JpdOxp66r6FMIRaE+aaW
         tBXz8RpGtvXWk8QHREPXW4iVNgKZy1zed+NuPvSsZdAGRscnhhrzTcahv0SNLn5SQ9c+
         xYiLBBYWtzq90jzflho1I+v7evx4LV30E54CgaqSrD+Ie1Dc/KA8XcqfCX8cTYeQoEkv
         vi117RemqUJpP3rG0E27cvZ/JOkCovWLeyUwA7jheGDXHHRuECHKTL/lBeaS5b19sWyl
         ajGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792481249; x=1793086049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        b=BSkiROCnNX58runhrTm481OeUe6TigS9vHK/+OpJrzISryqv6gzY1meZWXeXBK1TM5
         AC7OWBag1lIVxMOnonE9yViTuJFz8+NjIchY6oIM0Ms7rn26hIQRvp5350SzaxDi2Nr+
         AYxvqSFKAaVltVGTHYxUVSgKHGctsooVeSkzQUa0cEPLuxd6S8zkBcNqsYmZYludnRO7
         27/rpaV5jOvsgxXEYRNJPK06HDStg5yCj8K1nDSd7nR4jNMl2inCuFYB6qSlTIsDKgQX
         d4bolP76Dhzke2KFbwjisP6mXoxnu/0jLFvoOr3aGirCtZJLBN99e1IkjMwfT0FPYvyA
         qhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481249; x=1793086049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        b=GWouR2/EUF8eBi509XuJhHwuTF7t2UQ/DhNRtfRWV/+zIHioAlua6mA0quXujdioId
         RNZBbz7s8TQrpiEc+UFg3npmvzXlCXiULIaJUGbx6HvJ1n9S4/fRDH+AGWTMLnzZQr0C
         x5RWjmr/2wMwhlB6YprjOBCe8TTeyAUPCH91P9jUe4P0sqlvN+QWBZJMc3eZLnuB0SoC
         62+q7jvw2MhenyMiHf7HyH3Yo/RW+E/feFqfw+EupRYm1DcsxReVEv/cBrcwpFMVzced
         rE2Ds7s0QzFUKRDdeb1YrjMQDafcjqnryJGgxCwmGtuNNtsfHd6YLt/B7d3eQ5sXTYO5
         blqw==
X-Forwarded-Encrypted: i=1; AKwUvByiuPX3AXbDU3kGXFvbavnL1gD4lfYAHOUpMr2WyjNOcbxCADYFm+ASx0DrWNdIs0X+xL+JGVDAxLYteg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgv4xWtFTW99lNSRdJVcwbeHkbeXyoRrk65CmE7Xqe7R7qUT2U
	zGjqrxrS7C3j0rToY0OmlbsKRQRC3p1mj0oRKN7rivjRxzEA/6W2/f5PELNziaIJHJyZdKcEqro
	kIk3KJ0zG5In8vOUdmlCBSaFQxuRvYPs=
X-Gm-Gg: AYBFou3uUVdWo5LlVrzGsQf+S6c+7pnNXAxblzhlvWN2p6nkqOm1L9DP1RhpkOcMeoB
	wKE2t37o0L6bzpdh+Po3XrZ5p4bSHEOZxEiTbQAsYRvfN9VkZ68qTuQhL+WHVcMAbnqdo9nXb2m
	6EKrVxHt7CLKbhmsmLsRFW7xOEpwa8zulaH0BjR7coLbj1w/GDwG/pA6UIdXyWtu1OpIPGype6I
	E+fpW0C+qjz2gY1VkmDLMCOaOnRWd7eiZdOSAZvX+Dqv02jvSC7Xg3CGeFHL6EsIWroroKdRf0f
	wOpzU0vmvPrhr13a/NiPFzcx4EayIV8SS9O19HDzIrxzf9UZgZbkkByo8FQGzqcNoOAKnTtYkNB
	Le4UxO/QPEXdq
X-Received: by 2002:a05:7301:140c:b0:34e:67d0:bbb4 with SMTP id
 5a478bee46e88-361a0e85fdcmr14132186eec.10.1792481248787; Tue, 20 Oct 2026
 00:27:28 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
In-Reply-To: <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Oct 2026 10:27:16 +0300
X-Gm-Features: AclHuK9h-tQcbXrVM0viwwPsC9zuaQ4jRTMIV3P7VlE38_D0lFsuAg_ZHkgq7SA
Message-ID: <CAPVz0n0Oiok9vx1xmTPPpv8+iHCfL4XTE+D3jBMc1rUUHAftMg@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] mfd: Add support for Asus Transformer embedded controller
To: Florian Krischer <florian.krischer@fkr.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 20 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:5=
7 Florian Krischer <florian.krischer@fkr.dev> =D0=BF=D0=B8=D1=88=D0=B5:
>
> I tested the v12 series on an ASUS Eee Pad Slider SL101 running Debian 13
> with the 7.0.1 postmarketOS Grate kernel.
>
> The system booted successfully. The EC identified as ASUS-EP102-DOCK,
> firmware SL101-0202. I verified keyboard key events from the EC keyboard
> and touchscreen contact and coordinate events from the tablet's maXTouch
> device.
>
> Tested-by: Florian Krischer <florian.krischer@fkr.dev>

Thank you, Florian! Your feedback is quite valuable.
