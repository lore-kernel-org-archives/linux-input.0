Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4435AC2F
	for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137975; cv=pass; b=k3gm68vUjwgGjO++/P7EWj+hj3TpPqrrU+JajMGKD5CdoPBKEHsU9WV4URuZ69seAPmdGY8TWqwrm0npUfwuhclMFEp5TeSv7hNU5lqam6457STpPJ0XGXasrob6Vkqf4WEqBx3WX+arBToxI4+8PnshoQ4jdyo4DOfm8QqEQ6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137975; c=relaxed/simple;
	bh=RwedOSekIaf4d+x8Nq76gSwma6obCc5mF7uMaa+hf80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aypZ33RHUguAEFBn7H+zsIoanWgmH82AfrOnK5JpZbrSnCHV/TGlpDpKz4cMKfILRFOo2oLcEryN6HRYFlq84ggD+4fi2UBOdVkNgD6f/eeu209s4w8EWYXyyUaAMHdtGUk6+hqCJlMPoy80r8cA8/oJe19gFNA6DHuTMHiIn4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srLGDB8y; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srLGDB8y"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so5752576f8f.0
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 10:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777137972; cv=none;
        d=google.com; s=arc-20240605;
        b=VDbEzYfFuNLuB0U5V6upEAIcc0cQ4HkLXG4kgRLmp3ZB7s9WiJsbkN7dAk+0qbNG+G
         2WW0gV6tXWnClGRvzTKclrLzuCo8Pv/DYXzcxPEsS0Iy6vJXnxwRJ1235JSQcsYcGh+/
         FjJF240+YvZ+oSD4hdNP8rrG/Si+xGUwZBwNprFZf2z4p2koCnKkdojTnxbaCmHpNnIF
         gXgOG1/DJ4QFeo3Tk36If2GyGCE7nlkrpG5KML/XszNrFnux1ytWYWiOecmpkdG/8lkf
         hIH9whRGYDs/ZOiB8nMnwVRyWBhJp0W3PgHVeCLEYgW1dP3mOkaE7XcJ0jxh/FuE7tT2
         k1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwedOSekIaf4d+x8Nq76gSwma6obCc5mF7uMaa+hf80=;
        fh=GVZxW6p7PWpBDNtvykKDuqMndqz5qtkxrSHZ8cWsGN8=;
        b=lVSZqn5nyygysMSNtXT0D688vHgr3tngPm4rOWx14aISf9dH8VSl81wD/XfXJfxQHt
         8bH78iHro76K8uqcT4t9z3VbvpTQhmP86q9dFJcGDPfNvLFeOXeELtviXjwq+fFdgym2
         /gMsM3nqD0dlgmrxUANxJhqiQe7m20X3x6dJEzDfYU1EngFa0Thd3g/KSAxcShfxPVg/
         BaHo8VYZsK4s36egr6l2HNpuDP5wVK/zEsqxQKCuEyfzWZj5d+N7Vz5mSlilpg8kZzKs
         sdgga4pQ/dzI7LAMYl2yuQrxWSAEuDxLv5Bf9KKWKHxLN9mB1wPnU9Ru4lrsTtmAsLX5
         QjBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777137972; x=1777742772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwedOSekIaf4d+x8Nq76gSwma6obCc5mF7uMaa+hf80=;
        b=srLGDB8yCfgPpTyYiFJZJTTiDGgmDraFPEF57hHY3tfCFMbNMJotLSpMaxAPV9oykE
         u0nq3I8J7vcQ4Ahkr4GvnuQa6wJSwQsMY6jFcLBG1zwiCgnLtr6DnkHJVbYG7JVCG4GS
         B8BzJ73sRAEEHdQMhJEP4S25cbk45hOcNMRXKAZwJr0C3oSs+bo4qDUJjJ0+VaqX2/Qy
         Vfq34E0qFlJEDcoSWky3Iv6vrz8T7sItcgKgdxKciMj43quWyurrN3xAUsvKfUme9XzU
         nVZQAACl0zxJiaoVXJMRJPtdajsqDkAiI1s/QGg4eiEHzKj9cBdDQ2z0VFw6PsQrI7H3
         gRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777137972; x=1777742772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwedOSekIaf4d+x8Nq76gSwma6obCc5mF7uMaa+hf80=;
        b=oNaEjets5HkU8XHRljExene5h+VvPa61Fap9sFINB3RmLLnInIfLgLgOwvpRasnmys
         wbQLfbJmAV0Ihei+m14DcC4xo3jNjO5UsIYmWPjr4PhMg6hydU8YjPLJLvDuBnYemlzV
         wvz25b7/AHSqGPHM133r3ZoqE4PxO1g7fbDjjNJdGUXo1uFJjAw81R4XXPTAix+oT6hn
         2af0Vhxr+QrjQ9YhjGClF1khjt6ZOZPc6aHVV9vr/m5Mb8GONdb7VUZSd6xjfr4IJ66D
         joRt55LqQNyhNr4owwl6UEWFFTtRaUKTaqzvdfRPMZYZw37kMJHpqMx53nfziDyLChkU
         62FA==
X-Forwarded-Encrypted: i=1; AFNElJ9tFXDcS/6UPWh1zZVGZJm6WpkaNZUQ5SUkINNxUOjF4YY119JAZ9/K/F39oH8P6UC7fzz4FcbygCrc3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0AJnSCm4HIjbb/xCiLTOKG+ok5dDy3Se2Gye5obOhciEDKTs
	cNa+qUJG202d6UbzZug3OTUq4d+r+ZHiJFh5IQrjx6pXtbL68G5mpohxPEZ2K+rX9HvmcvRrUNc
	VMkiFMoI/m5H++RS2yTaW+HqS/FgBdYc=
X-Gm-Gg: AeBDiethOUGyECjBQriy/fL1hZhTWBGoIYKQ5Dv2fm4GP2anFwjiFlzxkreo9HPu4N0
	ro3u3Y5knsAUx9s+rCMdZmJ8uLNGB1oXyLYtLGn/sx5TYfcmQxFc0VFXENtW3sqcLgfVQYNlyFC
	kptJ7bGx6c4Qq5lohrK0aSqMLRPV86aItbzbjKY+QjpXXb9N8MNkuFIWZlLJb4lG0tF/Vlz5cX1
	5w4jrpS7Z/3JETx7/mOuQF7AkBpDNj0Gd0cmMRB1ly24gyd2PAGgGJV7tmd8RMzYmevd2AdqkDY
	uPFmZ2MogMFXEKchx388C/IaHR3ZHQ==
X-Received: by 2002:a05:6000:2008:b0:43b:4982:fc73 with SMTP id
 ffacd0b85a97d-43fe3e08fc2mr58462746f8f.25.1777137972116; Sat, 25 Apr 2026
 10:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-3-clamor95@gmail.com>
 <aeuMn2w3kSUl-wxF@google.com> <CAPVz0n1POe_YuA+RyvLLUdO2D526hb_YQUXJb72Y1h6mW8M6kQ@mail.gmail.com>
In-Reply-To: <CAPVz0n1POe_YuA+RyvLLUdO2D526hb_YQUXJb72Y1h6mW8M6kQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 25 Apr 2026 20:26:00 +0300
X-Gm-Features: AQROBzA_9iTD099b4s043poUUm1ygGLV5Gp-CHdWMZvtjYJQbgX7maV6jEZDk6Q
Message-ID: <CAPVz0n2-JE6E10O_rFZYPSET62HfAz3Zw8vyNa8xoALQQJR7Xw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:0=
1 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18=
:31 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Apr 24, 2026 at 10:13:05AM +0300, Svyatoslav Ryhel wrote:
> > > From: Linus Walleij <linusw@kernel.org>
> > >
> > > The ISA1200 is a haptic feedback unit from Imagis Technology using tw=
o
> > > motors for haptic feedback in mobile phones. Used in many mobile devi=
ces
> > > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung =
Beam
> > > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> > >
> > > The exact datasheet for the ISA1200 is not available; all data was mo=
deled
> > > based on available downstream kernel sources for various devices and
> > > fragments of information scattered across the internet.
> > >
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >
> > There are a bunch of valid sashiko comments, please address them:
> >
> > https://sashiko.dev/#/patchset/20260424071305.89503-1-clamor95%40gmail.=
com
> >
> > Thanks.
> >
>
> Acknowledged, thank you.
>

Hello Dmitry!

I have a question regarding this sashiko comment

> +static void isa1200_play_work(struct work_struct *work)
> +{
> + struct isa1200 *isa =3D
> + container_of(work, struct isa1200, play_work);
> +
> + if (isa->level)
> + isa1200_start(isa);
> + else
> + isa1200_stop(isa);
> +}
Because the driver tracks isa->level locklessly, if an effect starts
and quickly stops, the workqueue might only execute once. When it
executes, it sees isa->level =3D=3D 0 and calls isa1200_stop(). Since
isa1200_start() was never called for this effect,
clk_disable_unprepare(isa->clk) will be invoked on an un-enabled
clock. Does this unbalance the clock reference count?

This is a valid comment, but I cannot find how this should be handled
among all available haptic drivers. Maybe you can point me in the
right direction?

> > --
> > Dmitry
