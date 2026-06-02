Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BF376A07
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388859; cv=pass; b=EXZCmNg7voXlylPos7EcQP6BpZkSqxtAd7KjnJ4X5I1Kdk7menN4G/MaDoy7I7poT2kyUs7PKyGPH9JpnnL2bxkEdzGzwI7QG9sHHi6aUu6RjRRvCeSX8HBsdO63sXzAfuY3sajOl+LIH1qFMW2CS+LR5sGmCSkl1Iciu6qG1uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388859; c=relaxed/simple;
	bh=YevHtGTq/kdgx7nQHMRcSZgzrC2XRHHxw6wlUJR8jHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd9F1EHX6j76uK3wHFy8kcAWF/5AAqEhJqvSd43K9ffe9N+R+14xg4LEB0+fCpdnemiMAQtlHBKXMzPVeHJJElAElBfddZnpbpJedc50N1iIU0OvwLgvqkoP5RcXz0eRtQvxovL86l9xyudgik2S2ide+I91Psqpry0b+NM3dpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tluh82Nf; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tluh82Nf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so8044452a12.0
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 01:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780388857; cv=none;
        d=google.com; s=arc-20240605;
        b=OMwwGBnvMtXAVZE+4JlOOnJ3X3mAlfQO6JG3nh9Bz4Z9lfuBZm1GpJfcLlWA0891oJ
         0aYBj2TvMteaVGJ8VgsteNk5vXu9lVqDLhvmFb7Y74XvpZirRdZ9G251jLfn8UOWtJ4N
         1CCfE+lwvaVM9Wt0NhGHLrooRp7LjtSJtgA7g5xtv7dqXsCkHBfcnLLQbLzxsOV7qk7n
         0QDgRwiLMYP1kX50EOoBqB9zW0RNoqShnyl/3Kq0zKF9wEVifpDMJW1leSvnkwtIvUBK
         6M97vsBLeyvyHdaVLymPA3SBj/EzZTz+AydYe2CeZDkbawvb+DJUGwPmfOnKMpUrpo9d
         iPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6x+9n59m+G4YPMddG96e0z0WQ0oCZ9YtThTaG56Vp+c=;
        fh=uV14yPWZraFmmPFozNzeOiE8/6cGW0ct30ZOgA540AQ=;
        b=QtdY7WYKX1nZrrMxbd9Ge/N0DOOBPEOF+tmGkcI0SpGq7tBjCPNWACdf3DLKhqXqqw
         mbmSwDqp8jvElL7pcJzmxVyQ5Q19lvNwVTXqpmBA3VABHzmMxmPGB90ZKD6+Syhykuiz
         DyisDPRU0+BuzOAw0LRoL6oZjGGYpGkFZ445v3r6TO8Km7ZefgnQDt2FPZyVMyMJAkrQ
         FGYCipdNhHuzozK7+NhaoA9B4dLFYeDgN7GgxlcLNeQN/2dlcyTmLOiOMgVXANW8hRIY
         ZniE7y+U6Gqbm9WkaXaLYiUS7gddKngwCFQhywcmu/Pa34aJswuQ/goJbIslv8mNTDxi
         BTNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780388857; x=1780993657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6x+9n59m+G4YPMddG96e0z0WQ0oCZ9YtThTaG56Vp+c=;
        b=Tluh82Nfwg2dmcJX7gSuI4D9DLtFKFbeeiOD8+Vn75DTVFZTOVe+Ql1SiIuhTdbvL+
         fVG7uQZgCBIiHz5mKbnyE/yeHFRpUd+nV6fv9WRwtBW5por2ERTC94gCJmt/2Y2QSIe8
         T/r7eMA2OCsCiDnKXLijUtUFn74Q+HrGN/gzerL1YaOuPTP0lorgIFwK4loV6a5Mg4GP
         zJvPnL3GZinssJw/lM39hhNeaRW/fVCcLEL13KP6jZ2TkrhcN1vZc2y/IwOLaCuThoyM
         oFiJa1RWKWxzUSzWAHh5j3PZ0mcZ48CrzzBdi/e5RsS1K3Y5XkdNrAMMV9xATm6p11WZ
         uwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780388857; x=1780993657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6x+9n59m+G4YPMddG96e0z0WQ0oCZ9YtThTaG56Vp+c=;
        b=B4cBtGHY9WwP1zSkC+OzyuP0xm1RR0asKPeyQ/hCmfFcgNHeH1rWa1mCzoO66U5iv+
         2sAp7JzA6cKCx9k+VFAGcZLFHOV8EqKcq4D5YVPV8OAy1szSRi+CKvH9H2uatrnU5WsK
         yligAyD56z49uH2stoQ8980IZPGOnarDfR5yOwVWfx6kcsn2MlbZMGAYBqRN9a2ei/wa
         9iJNvykYeDrvhdo/KfENoSMEvCtZ7RCn2BGcQcDCpR/Yg+ytlSpzewuJaBfxqxVNVv7E
         biwRUxLaShIKLLJedmbux0WaUMQ76u8FP8WU9PGIs5Sgoybwpfl0YqBNV15vFrZ7wGSg
         cE5A==
X-Gm-Message-State: AOJu0YwWXCWBm6ehpxZQlngtsvyJGyE8XNayAXRNVHmnx3NYSoQGNayK
	sOexTLPiBFIbfV21NBM86mtK6pFdwA/xiPh6gnleye569EXgqgXyvRybfEjPzbutz/niBtOVfBh
	rA9bB7ULA7R0SjJjwhYOpaJsNDXJv1eaN5A==
X-Gm-Gg: Acq92OFCsylNJAeLWE+NKs0jhswUfol9JSj3knvtn50naJ5WWQn46PDvZq2vmq4JzRh
	XWC52LlWmhUfYwl1VvnXIsndHFUWDG11zEx8ofxUTbgIUOsOpeVR8JdBPi01IkCxuWuoEAZBnPV
	1EydxoCm0uGw6zY421r4qs6VPrSVXLM1XvVl9QS+XFbr8phQEB38DSnWhgKaET78ev7+06cLS5a
	OBgw2vtwRsl7YwNpXBO06Y84pZFS417kke4gW5TEN184vXY3Sroz2TIVM/d1BOiNm7cTEKesDFr
	aZJQbftkJOkF1ZF0wZfvz+1T52NSa1ZUa2+ZrcfD6NWjGOjkGgYr0e2/IwrpcnbuoRqzzjYjWeA
	MKda/PC7cf9fP1qXTtfuqCRjVbq5QUUT03Pc4SBEPOOztm+rF2wDCbOUu46oXx7KlfFSk
X-Received: by 2002:a05:6402:28c7:b0:678:a507:e837 with SMTP id
 4fb4d7f45d1cf-68c8a3722damr7179822a12.1.1780388856851; Tue, 02 Jun 2026
 01:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602035907.623599-1-rosenp@gmail.com> <79ccbd62-9aa3-41a6-a8db-1737672a8aab@amd.com>
In-Reply-To: <79ccbd62-9aa3-41a6-a8db-1737672a8aab@amd.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 01:27:25 -0700
X-Gm-Features: AVHnY4KsYOwyoqvI0RLAKZY3JiYBVorSJpxycwWf95nSCviCf0BvSwu_qC1NswQ
Message-ID: <CAKxU2N-M+vDeDKtYa6=M-4kazOUrGTrwJfHoF6Z+od1OZ-VBpw@mail.gmail.com>
Subject: Re: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with ioread32be/iowrite32be
To: Michal Simek <michal.simek@amd.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	chleroy@kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:23=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 6/2/26 05:59, Rosen Penev wrote:
> > Mechanical conversion of the ppc4xx-specific accessors to the generic
> > portable helpers.
> >
> > Allows enabling COMPILE_TEST for extra compile coverage.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/input/serio/Kconfig      |  2 +-
> >   drivers/input/serio/xilinx_ps2.c | 24 ++++++++++++------------
>
> I don't think that anybody is really using this driver and would be bette=
r to
> just remove it.
> If not, no issue with that changes.
I have no problem with removing.
>
> Thanks,
> Michal
