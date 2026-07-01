Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C134C981
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916537; cv=pass; b=Azln0eEWz65GECL0m/9TArciLfudJJdx4OYt7t71pli5JT/EUobTXN2Hj6YH5tbiGjAQIiY7fjs88Bl/APqYPwfpBXW61VtGT8ZKJZrJVDFNxVRnIOVfuCx/b0yIxnm5Hfh6ZNhnafSJ3+mngjObogbPk7pawOYw+UE2fF2+ioI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916537; c=relaxed/simple;
	bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Je0vjiTtaimQsxr75RgLzH7ygPj532PwhM4Ut1BLFBmkemYcwLeMIYH+GxB7Glj9g/zygtop/ihnYIMQK0CmK6xczcnKHp4A1XB77uvvrwLgHnjuQ2thoCE5NBjTRl0iBKCgI6kvkneEWARB2kI0xmKKvJhCpz4PPb3zSJDx7Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFlLI4iO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFlLI4iO"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6626b5ace23so1960819d50.0
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 07:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916535; cv=none;
        d=google.com; s=arc-20260327;
        b=YNf/aj64KPCT8ZTF9KEolHS+emk1m0zIaB+vmc3enXqes/3CIpt7KUIRNI1TbQ5gdU
         zkp86hQtuE8hPeRwdH1+Ga1sjPHHTD86efI3B1/wZtaeElhL7w2zTDRPO81+Uqse0jHL
         goju6AuleyJfQUtLm7LmCug+CBwbJa9datsNYW60fHNiTiVPLbyL10LBk/u3oedLB8gT
         sXRiS/eJkTni2FlJ5xD8KQwhZPUmgvNlvGQIJ/PbOUDBMrTMNtwLDvA/vLKxkSALObSK
         K8qXTf7s5HvLgm5dPmxIhJf+rPahctqTF9yThQTzlRTEI0guska9oqBgOwCMJhrc8kB2
         i5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        fh=UFszM+o6M9fHI2tgO3RQOdNeXwTG18uldsEDwGcXO0Y=;
        b=M6a/CVL6bQBHH9URlSooLQ8eyyMsgdyoTk3j6xnb2ZV98p+fqB61GFQnJpVN/olS1T
         wcY5MEXNefRI8NRPY2Ua8NyxpBfx9cGCB7GuwXmWpwQJtWkXDLgjlE4niAYb09/oVf6k
         NGqf06HaV7/GzfJyOq3lVs+o81a5S7CTblZmR5HwkaGMljK1XG0ZCz7kK2JSJjbKYxbe
         UdaDORArtRVmB3uPcBviWO4aonWaDirBmI4SyJzBOUNfksg826gqKtYdyEj82RY3KjAc
         hFmjCMoZY+fZTHEqw5WSUqGY/HK5AZBH3FIauNry41fM1JWyssADae62q6gCQG6d/tXh
         AU4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916535; x=1783521335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        b=lFlLI4iOajF57XBXumzTEoiEqzIBsfXUlXfVP0pgSh8wBV1pxiZCZF0qiTryNL77/b
         G6Qz/BN/1Asz2c5Fdmgt8oNl8WVy+j7pVEjC7FMB+44Z5tEcVMNKtuF77lM4FpMSjmgz
         +O5ycrHl0AGN4mpPc5X5c+N9KiNZzhRrPqDoUzh9PcGIR0PYCw78sK7pkL0aNoVtJQs/
         HYyJ/jR3DPitRfF9i2K2Y0M9yw/beWAIaFvaVbg24YEL6xC/BHdrcK0nVqgYpfgv/QbI
         V302APpipuDLDdp2x+S7LYjiGf7kb7pcSlHrMUSOoLpZYS/w9BoK7wKXX8/pky6L/5AI
         feEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916535; x=1783521335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        b=ZyPnZdPzxCCMlo/qHaypxjRnyet5zHVZkjYYtIQVaHQxRfOvmHPrn/CcKMeThrjZpI
         e/lH1B6lBGbS3qvgUHRNrJC0OgVj+TAnQQJqlScZlig23Lpo5fdhgqhOEpQWVoJ4RHp3
         BTNvq/0yP1S6Pkga1d9/tAPSUH+q/n7PIVSF1hNSmJtsHAoT9PQwgLwrylfKGROzxmzg
         EUgW6pN6phMPRq+nRZYdsXSLHQZ7JCMlWPAsAeiDsSK5URhWTj/I7YvDaUAeSqHH6FvB
         T3O9YJi5WFcPN9s4kB+R/tQX0RuiSH4IAR3jSOZFegD5wWNeIZHHuTfmFm50fH7zeZcR
         ETGQ==
X-Forwarded-Encrypted: i=1; AHgh+RojfAmHWqbmr8EVNfilBc6UXw9lj6f5XPlSudXB509e+xAbRXJqvCZQcci+mF6l/tl+PdeSclj5QQ++gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZ1AlBlO9TPhPqBZLNSeKomTQ6BV5UpXpeV7dSyfTCMgejif9
	uF81Tv/RPwYFmLYGAEElmP/886DjIoF9irIEc3DNQauboF7pKZOeQoAHU/rCsfcw0w+oqmKKXYI
	r3g5Emn0CvYzv+jzWig7AAP/Z8KA7VRg=
X-Gm-Gg: AfdE7cl9G2qTYWLoo45dgbkTWjV4q2GRYSjjlqrq3IV9f32VeGqLU0Oa0bANxx796Pr
	kEaPQAQ1gxRiq2aN/v5RmDlOFIwQjq8D+83AHsJZfUrNi7QsBoKjog0G3YTyDpr8k2WpvMV9E6S
	t0Dw3azEirZq5KDaLlyyJxfmjt/etXoQez0bMpwJI/GyUeU9+Wt0cqfpfHB8yy6sknSSx4Y4UOl
	oFz1A48EZR2QYleaoYvWVB/ebeK1dDZUlKt3H9itDytSuNN5fvMaAndSgYIiHr49/1PTFHR8pN4
	UCtP2M/T9xgQZsHKPRobhPBDVZ1/VfvwDbZPYeqERqCL/s+npl43L8y3mKE6Dg==
X-Received: by 2002:a05:690e:400a:b0:664:d5ff:2845 with SMTP id
 956f58d0204a3-66507a15364mr5289486d50.19.1782916535159; Wed, 01 Jul 2026
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-2-506d936a1707@gmail.com> <20260630-tattling-pacify-3b990261b8b5@spud>
In-Reply-To: <20260630-tattling-pacify-3b990261b8b5@spud>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:35:23 +1000
X-Gm-Features: AVVi8Cfa1dzp-N-jQ1tztDZshofJ1mjnAsJpK28Uy4QoNy9Qd76BAukQRwwA8nI
Message-ID: <CANpmGNtq96uJzbPRLyDG9Qq3hPVGA3yspk0-ezAdD9PUzj0gMA@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: mailbox: apple: Add DockChannel mailbox
To: Conor Dooley <conor@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:07=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
[...]
> > +++ b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
>
> Please name this file matching the t8112 compatible (since that's your
> fallback).
> Otherwise, this looks good.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> pw-bot: changes-requested
Thank you, will change the name in v2.
