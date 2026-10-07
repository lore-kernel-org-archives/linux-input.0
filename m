Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DA49B47F
	for <linux-input@vger.kernel.org>; Wed,  7 Oct 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363936; cv=pass; b=F/KUVdwgnw7AVThe0nds9S932iwRom5dJf7PYm500XWMN4bYmn8AH5s8HXAvwUV3IzT+5DpxibD8qx4mdedxh3uxWSE6pF1NPNA+8xEdSr61kXWRSwfFOMJxOf6tLTBwrwiXBRD/OFe9LpnspWYgsxv+HIZbf+uMypnw831x19A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363936; c=relaxed/simple;
	bh=LJK4k9+FK6S0VP6imYj2QsZHzrZYFltqhgqnT9sHTTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRvRhgIdREDBKsIxXpygAoOmXbMmDrDN+r/DnPpKoLQC4kqyaJRnmH5eWzlcfhBhSr/3vQbDkD8FsWLPGMT+6Z9KeBAI7kMx3LpEYX7mKUCxsohbx9Ho2mIR1CTzR6n/dzdEI7u5YBOdfsel55TV5hpGj8etJOCO2RkoOVvcw4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg4nyiH9; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg4nyiH9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48af27fe287so1182844f8f.0
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 02:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791363898; cv=none;
        d=google.com; s=arc-20260327;
        b=VZvvbRyHXocjDFBhtI5q9FqUbPejFOSVb5jc5NvUP9V5HsaqdtIbuiILWMyijmrH+i
         SBUSqru0OxXUlA6/nNpaT61712kuduSBohj2UVE8Rk1j8nNeUIF/OwgcZJEfBAks8Wc7
         3WUQWeRf+SgAWlpFsD6hzhvGetlc5KLtgzGNc2QwIu/SzI03qTilObj1LmLHo4UWT4gU
         +fcXwdNzXelkDiP4PPlMrdHIa8r0w4rghMb4uzcBsCJZRoMerWGvKrKZb/Qr3SD2lFnc
         s6iINLTPUYlR2veIbi30la+0gsr7Mz5ivtPNfXqgb59J9OPAHTVrlbrf4GyzYP6n+DkA
         EjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E36HoO2bl1lQRnp5YJO39xoegHQevQRhaq8fZKyuhuc=;
        fh=WkWxYlu1QyijHZ6vPtNOGpU6cC9cvMw6QQgJI0U9gwM=;
        b=XIV1hLCtXm9y+9rdO4QNh37OeiNCbzQmmIImp9Xi2jDNsKB82aT1hytAHfNd82U45Z
         au2vBmpMUSNzudEj4T4YbTSjhhM6c85IKe/kmD87YSdK6frSpzEqVs3DpyEIipknGUju
         dIqQ9sMDSp0pcTm8yVpOyUvDDJz+rVwAm6NWOJP+AJUQGCT5HXxm+Gc0mRWTcWm0km7H
         ULesAjmk1uCYnFH1K5vpg9S3/n16WNrlo+1GFumwdEbqZWOCY36UwLItRs2GowA5+1n0
         qHlv052tRkXqYDN1kg/b0G0ycIDUTrbIhHef8Gy/eacr8sLUTiicS2fIPvNBX44QG7M7
         5q9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791363898; x=1791968698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E36HoO2bl1lQRnp5YJO39xoegHQevQRhaq8fZKyuhuc=;
        b=hg4nyiH9/g2Oz4ambYX+iij2CVMo0lI+tx5CvP9BRFvPRLtZC3HK6fstw4VTNM7GQN
         xOB7mU1tpeZrlJ5a/H4lJ22ITcy4YJo9lt5XcaquaLioy8K6cP6V1WBvG1FQv7XDyP82
         LFdCV20phJ4B+alYJ93HmJyysenFSJ5yNyPB7aYnZ9kRjTEg19WZt4S90o3Hw20xRJ+y
         siYnxqH2uVTMoNtRq3aK0bjLiszWKbd7THVP1yC2rnvrqtli7HWPHfWwMgWw7sY/yRb4
         ZUOARInYc8l/4SY9mxH1FSI8d2CkGI1CgC/dGmzl1DlxJTd8vHeYvPBMIdaEBkV9E2//
         QvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363898; x=1791968698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E36HoO2bl1lQRnp5YJO39xoegHQevQRhaq8fZKyuhuc=;
        b=c9d37N9SysQN05Q8zQpi55qwyd29WKzc2eEz826TUTtkAoYZKfYDNRF+q/WK9KLfsw
         37OVnxLDlcYP5Z2+V/4uXp1rLIxA9P08QmI4EuNujS3KMy/lmtowYUADYS4pUHz27yfL
         6Cm8W90zxbFZy6G5L4BaJ9UBXMk455/fRbahII0EEw4BPMmeZvatCJJ0/zUIgC5WIWFB
         MADXqNYJbJ0RokldPPCxVuMXWo8Gt8CJwIf8liSisXsU+GbR0LDjp8sutTVjhc+alGt3
         3RelwQJ3YTmuybB8jG18ybDOov74blxXLS2XDw1/TRU3x/Xs8YUNh7610/OlRShyMS5e
         4k2A==
X-Forwarded-Encrypted: i=1; AKwUvBx0eyJKeNIVemBXOyZ4uauHJM+9INWQn17De8wpdBSLq4yPRJJetaujdGcVxeyZGT51NUiE9kreMNrU2Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYK42ccuBxSxu1v27XO0CpSKpsX9A+/gvREDuWJR7Ri6tChrsUes
	diTBzzJltMJJDKcCbhOC1QMHS5r+9pZx86plGt8HUWA3DideRSo70T+XhvxmSwMdtrxquLdEq8Z
	dt/cSNbO3hJuwKNwZNDNwCNXqkqJHIec=
X-Gm-Gg: AYBFou2J0f8q7KvnfkHPd/61l8aaWYixR5ODEmArnQwpdl30SLILk5tgqY9SI8Ovsgm
	LhFO2IPwQT7wuta4rRDcXxYofepmzqjwJUEARqcjDXaachtGyBjOzeaCWHfpxyNE+HZdZ21yMb3
	SeZDjGp955hCt7SGrUTjOQVfzEDh3P2YRKzodoL1RH958QqZQAXRNj9BCwmwdZuk3E4Xk2IMBqi
	b1UKubM8EsZxTLu+6xb8D99Bjq51aknneUJstuZZwn8aiJgfof3PvBoCFMxSPs8hD21njf2FsHk
	JkuMTaird4WyG5yplVFjy1xHuzrXtsSFteff7+qbIBbOijOAJ52jYWM3Mvw0A2thZbvgLibrRa6
	8a8qSU3S4uZ8lcywUti6lan4YNZz6j3r66We83Y239Hfa
X-Received: by 2002:a5d:5f84:0:b0:48c:571a:a1aa with SMTP id
 ffacd0b85a97d-48c72779abcmr3033081f8f.19.1791363898205; Wed, 07 Oct 2026
 02:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927114425.442803-1-pooyan.azadparvar@gmail.com> <cover.1790612085.git.pooyan.azadparvar@gmail.com>
In-Reply-To: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Wed, 7 Oct 2026 11:04:46 +0200
X-Gm-Features: AclHuK8xJQ6Fne9ZpkS7d6oSSqfAzB9NOx42HiHkCjgoiIsL7KKjyXseT1JY3aI
Message-ID: <CANC3H+Lc3GCuWpqr2ydCkYmRxTu4em+vM9R4gd-vEn_kzu-gyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Input: raydium_i2c_ts report handling fixes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Muhammad Bilal <meatuni001@gmail.com>, Herlangga Maulani <w1zardsec@proton.me>, 
	Rob Herring <robh@kernel.org>, Jeffrey Lin <jeffrey.lin@rad-ic.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

A gentle ping on this v2 series. Please let me know if there is
anything else I should address.
Thanks,
Pooyan

On Mon, Sep 28, 2026 at 6:26=E2=80=AFPM Pooyan Azad <pooyan.azadparvar@gmai=
l.com> wrote:
>
> Hi Dmitry,
>
> This is v2 of the Raydium report parameter patch, split as requested.
>
> Patch 1 validates the packet and contact sizes supplied by the controller=
.
> It also propagates main firmware query errors because otherwise a validat=
ion
> failure would be ignored by initialization. This is the only patch marked
> for stable.
>
> Patch 2 resizes an existing report buffer when a firmware update changes =
the
> packet size. Patch 3 moves the initial allocation to the main firmware qu=
ery
> so devices can remain usable for recovery when they probe in bootloader m=
ode.
>
> Changes in v2:
> - Split validation, buffer resizing, and bootloader-mode allocation handl=
ing
>   into separate patches.
> - Mark only the validation fix for stable.
> - Rebase onto v7.3-rc5.
>
> The series was compile-tested with:
>
>   make O=3D/tmp/raydium-build W=3D1 -j$(nproc) \
>        drivers/input/touchscreen/raydium_i2c_ts.o
>
> No runtime testing with a Raydium controller was performed.
>
> Thanks,
> Pooyan
>
> Pooyan Azad (3):
>   Input: raydium_i2c_ts - validate report parameters
>   Input: raydium_i2c_ts - resize report buffer after firmware update
>   Input: raydium_i2c_ts - defer report buffer allocation
>
>  drivers/input/touchscreen/raydium_i2c_ts.c | 64 +++++++++++++---------
>  1 file changed, 39 insertions(+), 25 deletions(-)
>
> --
> 2.43.0
