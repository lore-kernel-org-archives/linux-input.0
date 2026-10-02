Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FF27FB0E
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944534; cv=pass; b=cBM1NJLU+4+Zqhl5ZiamlxOnJDKn3E9wLXKabiJHnENB72KHADkdmD2F+aLlrOAWAW4ocE8xGaZmPLDgSJ4ZlwQflqgoD0qiTrCchfFLYhSBSIfAlBpSYmykT45YRmoUVCGq3DtbWJo5xGy61sRnLg+cGLOpIUaVRchuFxJylYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944534; c=relaxed/simple;
	bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFPb5+Yl9nsHkXsldoceCw7KzyVL76F5OgvL0jZiLaFXGE3SlZt5rY228i6j/RM+tAFHUsXYO8pFs2FiPeZ7YfHV3Of4jPhkfUF9tXn93MTGaagG4wJPgDJFnVAuFdLGgW58u2GOckSPzz60nXVgBuURJReZj0s8nHlPCbAW17A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/NEsgJL; arc=pass smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/NEsgJL"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso9378544a12.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 05:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790944531; cv=none;
        d=google.com; s=arc-20260327;
        b=RWABMsYyHV20f+bszRb+PpcA2vFgCOFg7nm2bsUswZorNVUVer6DmN3NUgJaQ8uVjv
         cyZDwkv3zIduL4G5nO7SSE6tvTV+gxm/1BZTPioVoqVUrvz5BarZeAkntlvK9ZFYw6g3
         9dHTWhRX6GzCVnmI1n4el8ADgpxaXu2E1aKiirALiR+OAFk/iF1ooCM3p3V4eiR2WS5v
         KWZOkmDepLx/M0CK2Ai8If/MtHRiDjpJPiX0r9Pi8KriRKlG00o4uu3qD/lDcYCxnIX0
         5c8V9pkoF+qLGYkLkycdX06Y2Uuwg174X7wisS9SjmZxMbH7B4pv06FyJarcfdOuiDE7
         666Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        fh=qosLipdtnOuLZZUDA3tcvegKR4+x3zw+aaL91L5pmxg=;
        b=e+9xsqVKzu8Z0FUGSg89b1IEVJVA8DL2Lg8ErSvCD3gUj+3nLoyT1Ri/lVHJWrfl2o
         UK/DYaMMVZOx8TOvpMnuT92yLdlXgqdt/Yrtuu2I8TasutL/L/QQ4wIuUK/TseAfvqSb
         aEtNCGJB4dw8H+za2mYCT22OesR3Ny463dN7oEg6hPVFSV6BH9R7kQqWcybWeD0RccS8
         Vx9WZupgT3a5bs1fgehulcBz+uxbmHsfMgWAkbXRbf8CqfsSVFV5cMlgr4EwxsmCAfg6
         GHdak2pE5MpUjG2fD+/uk7Us4PbgSVdNa6Rd4L+b99gi9OM5D4r9iFmIa/6whieV0H8N
         mrOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944531; x=1791549331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        b=B/NEsgJLmQsJc4ZodJrgL5R8Pi+rrM8G4dXnN1gEqnakWp0Da44FRip5Pu9QYTz887
         oMBJ+Y9y+Ec5WRQdmBhwMhX2cuQsiRHpfraPcYKjqPF0dkqVRacbNg8nnBElkd1fiQfQ
         zhSCR+wo/1oEy5oErl+aEFFNFx6N99QMKtXxd+amrRmgRBwmp06cV1nIRARDmv+xCw4/
         olmA42Ml6GlAR/aGdbwwElMVO5igcRyaz5fk0Ww46SDEtMou8JHHQgkm2bobhCXIt+YC
         OWX0I68TDaoawIdIXijKXGg1RnzjN0Sko8arHVzaLuFJD2zVzz/jppyToMQVIuzNR7y1
         Tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944531; x=1791549331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4tRzOP5gurinKLHFfhUWYn283fXknP0F1ZZM22K23c=;
        b=kpXM4t6fsuA+/G/LZnuDnSpXIlR1P0/Y4aQeEwdGWpuW3i3cUhfYrTW4XaNURUqKJr
         JvewweeRwhlyfHzSs+IVyGRDNxb+AP6yLfePAMgm28tHZNn9fD2CcroHqzIWlrDwu/aS
         qwSK/TiOTZBzhDdPBFZf+AfI37TWcxxOwN/61js8SPmOWsTUAyT3dPOdJ8cBufj8o+CY
         JOqe9uUsl3GRd4rTunxg78Wmp/4WHzke4rgqq+OV7HjNhxcE9km1BE/C1uNFRwIe4Kpz
         qWBTzUBP0x3ryRL2zdvvs+7jDSunAr6TXr4C9d7mUw+dgVSxob33EBkk69ovatwnIlOz
         SiGg==
X-Gm-Message-State: AFuF++mqu3Zn6xwg52cMELa8dEnw6d7/2LQYQfu35lJ1EzcFQwtfm+GW
	QZrbsG6978Jslmc3U2UtjiMNMGaGm0SHvCgUPLSJzhCYtLN8FtWB4UdAb+HuFMp1CIZ4l3z+bGG
	W3jJq1b5tDKq81BBqBzFu0HO6cplFy9w=
X-Gm-Gg: AYBFou2KsWy2dWxfFMFEoC+4H/cb09Hj0E8DmvGypAxBJlVesvZuLKcOoPFO9gPEydc
	M1/Gr6S8oVDJmUMpWZ4v9S6kz4Kdx95Q5wbbshOBUQVHMX+W5qYO4MfxyGet4UGO4uu8jHpXPPf
	VfDFezGOND5B6Y4NYTh/vipLxIkGe4kdwVxySsEQSFiGVjrHmQTIHEM34w+vt2W3oHMOmBIruaP
	YF8Lq3lzkpW0oTE+BAHSuVu7rEzI42kq7Jls+/R+MFsiyZajH99Msm4pCFm7gFpA5s85EHzcvcI
	wpzFZCrx7LnJ74hfzQz0qKA+1GscRkmGGq/9yOdquPvQovk5twQ9hg==
X-Received: by 2002:a17:907:9490:b0:c29:f5d5:5a96 with SMTP id
 a640c23a62f3a-c2e4b20d9c2mr208899366b.32.1790944530536; Fri, 02 Oct 2026
 05:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002100935.449473-1-al.kochet@gmail.com>
In-Reply-To: <20261002100935.449473-1-al.kochet@gmail.com>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Fri, 2 Oct 2026 15:35:19 +0300
X-Gm-Features: AclHuK8oT17fr99ppSn_bGvjxkd_dqcCHCFbqpWJG6tCtlizdpUY_p2i8jO-OAQ
Message-ID: <CAKNVLfZG0cnu09mZ2HYRRvbSd4uLeOBXR--nUHK9YtOb+a0TTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Input: matrix_keypad - force switch rows to input mode"
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 13:09, Alex=
ander Kochetkov <al.kochet@gmail.com>:
> Siarhei, Paul: you both agreed to the revert in the thread above, please
> reply with your Acked-by/Tested-by if you would like it recorded.

Acked-by: Siarhei Volkau <lis8215@gmail.com>

Best regards,
Siarhei
