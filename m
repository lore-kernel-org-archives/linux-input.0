Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385418C02E
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249170; cv=pass; b=Sa12f/RBJhyEagvcaWOQDXjaRv+4EwxQfbthrXnDf6LxHDgJZIY2v41t9I7q0o5dva12sio9twjpThbIUJZP1kT0XDgS4DFJvRx+gIR7WArt/PcTdgzTB7Un7KtONJSMbO9XaKY7FZ2bD+WKb8IxQooAj9aJE44PsBMbasZqdhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249170; c=relaxed/simple;
	bh=ugOVfCCiJp+93ixYgWWnYCXqvdHveCQmPGZim7XNpME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko39+7c85WhTvvI9hWPdspawFvKfOz3fhgQz3p8hSwUolttxAFSG74licV9t5gVHPlM/L6/3dXOTb6ycNRQIZq4RhD7h8Le6kmW/5oklZMEkhjgayq/uebjFMqVHQiDLxz4BCy1ZmcAeNJPbvT0BwjfJA11ZotHIm+bZ1YcDJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co9Xs1UR; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co9Xs1UR"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso7336662a91.1
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 17:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777249169; cv=none;
        d=google.com; s=arc-20240605;
        b=HMlt6P4UpSRGcgeKvW+fNp+GJ5ZuyKqVjeRXTXLn1cb68JPGedhVBTOV3KF16NUiPB
         Eiirmb+6OSoqirvfNoCxMRaDfGEuRtkqQdBXnGdIacSlUiDEmz4wiFIuX2tAgX2SMtbz
         YzrQfvDqncdqRJlWEBZBe44RTXB2KtkmMfaNScalJZamDVdlTNAapFFw8KEoCXRNqa3/
         A8IpvTetqL1dKBcawf/4J4OU0pOI1SJDkRpnuPJWO4D51b+du+XLTgn8pgkI4vNebwkK
         tlXSB5Oy1BBxsLVR82tlY2uwnraemuVem3iG92amfI6i2YCnZVWi6CdK4pa2QiBEsezX
         sljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ugOVfCCiJp+93ixYgWWnYCXqvdHveCQmPGZim7XNpME=;
        fh=+G94DfA4B2iUXSH7qEM/PlgnqZVM0a6iyLpm0VgS+V0=;
        b=jq+lW6LkGSX5yt/3yFK0XEptj31x2GA6W+w90q6T4AYTOwMAcnmE+FikQPEnTQhs37
         31RLcyb6323VHPfcq7fBUvPJIWueSt+HRIzoop5id+SULKLx6vkKCUH4RNjcllw+Rn1c
         IRbnMwX8huWMJZGH+T9Me7JFXF02xzyMcG6C1Mk+XaqXLw8SNPpmnAoZENIg2aIXBeO9
         dUuXRGXpSWT/KPUbUtt09lwCiOYqXOwR5eSjtVp0oRsq/S3rbEP7ktWl7EioF1NWcrgU
         yQxtrbN5x5l/t5UuKRV5hzgy7L11Nm9423BXl98oH6ty3PPNC8Z6aBkNoU3u04mQWhW0
         +PgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777249169; x=1777853969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugOVfCCiJp+93ixYgWWnYCXqvdHveCQmPGZim7XNpME=;
        b=Co9Xs1UR/5GhVp/Mg8sBa3+wMayef/UGATUJ7MRs67G8STwVmPgA+6PkXYCciMICP4
         i/Qza1CJGAjizMKd9JLnz3pJY3CU71o9uRGE9+acb9RBSyVsIdNoTlSGpifhOqnnjWto
         Rb/tUCtdcua6+8VL3TrrPLjaNU9XJ2+6Wn4MCHbXXAanr+8magUJCH8cGzFn1l8HPjmj
         kuxIJ9i5xQ5/kkH1Kh52hWJTxRYBhzAf0cJHB5hE5Mm/hWLbh2YKUMXaQspcP1FCHKN8
         qWXgWJXHNliqbIk83Ca0EcutmocwBhKfRVDD18qsgbuk/S2dVBmrro9gHudHbm5g9YSD
         Pc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777249169; x=1777853969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugOVfCCiJp+93ixYgWWnYCXqvdHveCQmPGZim7XNpME=;
        b=MCc25PVhwwzhoxeQgM5LS02Wp1cGlSd/QueY9o1Saiepo6ruv67oAyoRnkSvNA9nMx
         m0Ee+hh9JxTJo7RA48e7/fl9fWy3z7D6e1Fcetwx8zdmBTL/5SOnrmcb2N17BStd8mTy
         Ks6+23Am215LHXeOFAQvJ6QB5LkX79SQs8VJAT4WnuqEXFj4lcX+3AVqrkgZq7z4P9fP
         SHvzoSwmTMWMhWr3RpQ/rFh8GckLXbgghPH0mtKIiV2rGuy2OarNrGTLdQmPXtXNTW9X
         OKZgI8/yF1Q1/5E1L1pNIhQLm/+q/aChxs3JDsFN2hxpmA+JhhnUW5J5+/d0RDdk/eVe
         K0xg==
X-Forwarded-Encrypted: i=1; AFNElJ+iQa0sBYQsZ36vChrJxul208or27+acxFqEXxp3cq1LbNcBOVZ5MuYgcoUE211oBBth9H+EaT5+QfHgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqaotFpv0hbhW0s/I3jjbtL6QjwgqfWeTBE1EbCw84/upxNBA
	IDP0zMFbvDAGewuAGtYINwFfjrv78puQTh9cEibkbkb4cf8L76IF8uAU+tbP5Nz76TBHYOqLUMv
	enKZGrptsA1uNIL2vbSC+sgTKheKq8hY=
X-Gm-Gg: AeBDieuBxZ+b4t/BcepLuVfIk5TdeHbbTiSqU5ZH18VW7MVkF1FKwm0b0F5ZxzlJBiJ
	J0KiqDqpZDFc3S7qbJaoAffqElKD2J+TrVWsaCpFYvoVFrhDCjQ1CXo6iPv00Lc61HsmS44lLJ7
	59vl23eACpdzEU+Rb/3Z5RkNsnDYamnrrsC6NkOBy160bpzdCzLRiN5S7PLf3p6P59dsY6mhoyB
	m40kwPorV8SKHSnjH6Qw9dY+zjZslI/EWZfHs17FnDqv3nSHcvmPeRNc2G4PH/ef5Tt5uG78HOB
	D53J4EgPap0vlPgLqyMJrojwwtbXeAN+uY5A7icWtN2XOH8=
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id
 98e67ed59e1d1-361403d61camr40703643a91.3.1777249168661; Sun, 26 Apr 2026
 17:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417021858.6582-1-phucduc.bui@gmail.com> <a145db93-a8ad-4bee-8404-21f356d7d4ab@kernel.org>
In-Reply-To: <a145db93-a8ad-4bee-8404-21f356d7d4ab@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 27 Apr 2026 07:19:13 +0700
X-Gm-Features: AQROBzDh5S1ZBzuVxFYQ8RBWiB9vcWv-M3KhV5VA_7nj_DMjt8E8DfNhVOVUkdY
Message-ID: <CAABR9nE_vwzWwZ=2bbwTYgEtp=SGDnzVUA5Y8jp7gp-Ky8MN-Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove the redundant 'type: boolean'
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nick@shmanahar.org, dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, lee@kernel.org, 
	heiko@sntech.de, gregkh@linuxfoundation.org, linusw@kernel.org, 
	zyw@rock-chips.com, zhangqing@rock-chips.com, gene_chen@richtek.com, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> Why did you change one file and ignore the rest?

I'm processing the remaining files with caution. Files without
significant descriptions or context will be updated in the upcoming
patches.
Those with specific descriptions require deeper review and will be
handled in separate patch series later.

> Why did you not mention previous feedback I gave you on your patches

> (some time ago), that there are TWO TYPES defined for wakeup-source.

Thanks for mentioning this.
In v2 of the patch, I reviewed the previous discussion between you and
Connor regarding the two types for wakeup-source.
https://lore.kernel.org/all/20260316034606.11304-1-phucduc.bui@gmail.com/

When moving to v3, I followed Rob=E2=80=99s suggestion to use true. I also
sent a follow-up email to confirm this approach,
and since I did not receive further comments, I assumed this direction
was acceptable.

https://lore.kernel.org/all/CAABR9nH3hr+Y5ksD0cn3Gd9XUvmb07X7zJw0b4k_yVbnAu=
z9=3Dw@mail.gmail.com/


Best Regards,
Phuc
