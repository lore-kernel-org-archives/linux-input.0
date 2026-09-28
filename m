Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7259376A0B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639110; cv=pass; b=Jj0UylyT2tcWbDQsGL/q7AsU886aXVPqQm+RnO3lADj0WPiHUQpiBHUHavWykpWkrT9Ed0iDLxaR05g7gnlkrtSu9L+C9Y6sRJBGL5iF+9+IeqDkZr/fIfWaqzZwTuQpYWChaYUOMgPgzwl5aIn/hqjlStTZbr+tqE4WDelSZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639110; c=relaxed/simple;
	bh=2dW3KjRO43zQyQhXJDYouu00AL6Lvrd3NzAIkU41sfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOvJhKEdE1mgpidgXgNJRCb0XrqdyOzt3SfCGfAnnw0hzYHGecW4avDtXIWyM79BsoyQVkL9VjonWFa/5cFRFU0xruq0jb46lsXqOguUt2hdnc5qEELyJ6cYh4wbUWhtexgG+K9E+mBVuu4rCZBK/QXhYKwFKhiNZ4QwHJGMXw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpr28FAy; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpr28FAy"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672c2880f58so3476382d50.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 16:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790639107; cv=none;
        d=google.com; s=arc-20260327;
        b=OH9xTwk3zRqMDT8KF+pENYulI256UoyPVhzu3OejtKsylFtZPWtuTx+SkUgQF8VNZe
         hGYHoIcj+4PJT4YPQytbH9xjHjLOTNQN0mqJdGWr/znQ7Pd3qDA3Um+NasvOskN/2isK
         2f12F/tzbKABeLGSjmw2hA5hdFS33PFY+Bm7IcdCclMNNc5DKv2XnxZSaI7uLoD4rfno
         OmjIbLc+0L97FYFoKppTaoiGzFGa/FfLN9dFijscIaGqCeDz1pQYM+kPvftU+iwYwYhG
         XR77og5xafvJVQbnkYNB4W4fZN7kSls3LicQzZ2B0VGUzFM5L94ILGBKU+5Cr8TpEU1u
         ifmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2dW3KjRO43zQyQhXJDYouu00AL6Lvrd3NzAIkU41sfk=;
        fh=kzw9bTtg9W2S/OcRdA6YtESGXux8u08clBQtv5R3oOg=;
        b=SnqBY0TkiVVfBlLf7CHTHPMcEj/LOqIc0yI4FZgI8Tn5+AFxVQwAFaQApOAhY94blB
         06WQxjQ/IuCbhNcLGuWrWSW9IhbtO8f+wbaRba15ZjA7k6NFo6tX920xoN2uYAv3zDJk
         IYJMW4jLTSvyZAppnrGoiRjmCfjYi82DwDseA1mLou9t11o2vCKeGg1zkVPiwWTrMiH+
         0mCTdVaRIhDLK5F16KP7/1djKXJ6F68hKj9I1NHtF2y3e0cQHbhoJxGiGWq1A41jaskr
         dLWM5ToIZIX3q2lq7P8Zpr8P318kNH1GMiWKOQFf00T++o1oCeUNVmYhhRWAHeRhVMMB
         q/Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790639107; x=1791243907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2dW3KjRO43zQyQhXJDYouu00AL6Lvrd3NzAIkU41sfk=;
        b=Rpr28FAyMEEPF1NfMPgZSnN16YJdezL7Dn8o/1qL9a0cBQ92Cex1nyM02hxFNkatTq
         mehEk29eV/piFtd+8XQ+y15tKysjtmRUAHqUJxfiwg4cyWUzIUOIwWCHyWNWkYi+zqPc
         G6Xaa/Vs5I7v3racNIA1A+N6/Msbq7EGKfHr0n70Df0ZfXaUqTbq6qz9FtOe0GbcJ+m9
         CxISC1wIA+B4E1epnXVD906d++RRPyZQRgmxWrHXkhcSniUjIsINMHDX/Q45pXCdC/8k
         vDt6yj/pOJV+LCc8MYTfKUpGUzHTNH/NcKAYRQTojht2mcPq6alcYXhNe1IKqH0HIEF/
         hsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790639107; x=1791243907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dW3KjRO43zQyQhXJDYouu00AL6Lvrd3NzAIkU41sfk=;
        b=gAcZ2FH8lWqxYbhOhLSv2MezXb1duxKvcewnmm8jXOSeC1JyyBeen8fNEVk84jtPVx
         8ajaljCdP4HPZSd3yL6GBiuAHSi9dozHzUawNyDhbakJNLULD0NoJcIdmBwfVd8mgCjx
         4UGa0AV+0p4ONesHq7sV4NeQksh+05XZkzDht+Hnb4xCnhi4GF8cmXtJM6iG8pFSfb7j
         tiMcjzRVaMMxdG0AmRy/3toj5Ph4nMkJ4cmwpipH8auLzsK1HRFiYGhviKKpQ695XLlR
         y4xD9tmmn6gOSiwXH6txMaretbKVlxDhpNh7UjB6LwbzWJh/8fIPJxBA4XxO7fZnndkp
         UYfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCKZ3ZtJiyAEzOjTQlHij0OmHakBwl/VI5FV4n1NBdNWT9hO9Qx2jHqzuAtQigeaNB7gWF164OefmW7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJs+afjbuqRrQtvwya/4AdDa4WDb7dS9MU+zVcOdcKlBK/uucWj
	EPT3ASI01pr1xIbV2uREfDHF/klINLHAEbNswwQUxTzAElvDXADUqVm2Z8xL0WoGqfWdLUxOjp1
	P/px+kzM2Rrg9GgnjfHsECrRewma2oDw=
X-Gm-Gg: AYBFou17ASBRzWvTLZNo7z3RiEBl0DReM6JfhhEQLxDXkFEju6xiRhVbt/pNJi5MOb2
	QPmneP2lfG1lukkg0LN4VZ4ueTWmGSaqi67Bfur2Zrf9rS7PxR9BF8LqmmiqTxpeEZsHv79bW4o
	xDWsYjodq+r+it31Z/hXiSqixsQsiA0QtnGLwmWhuy4V30h+gxuzDkq1d/Ns3EQcuYoFxw6wk3u
	SocOW17k0SUwpaD2L+gOZaJDV/8PwfP9sdARVsxREfPSaxZo0wLBSVauelmZJICZ8r+7glOrk7e
	CnYQlL8Nm/LvawbVLeFu6Cg9q/IDTslg+dpqL2HV0J78oGpvZzr8Sirzs9MGJ6jWKX7hkI/RIcR
	O2KmL/vdTVUVU2zdBcHfhYYC80Tme9mGT0Ns9VqW8w8wrBzzWT4yfpe3qm3ancL/UgHD/k9Ia7a
	/8bGD0MDc/cX5+SDJLwVADIn0dCIEOA+3SVUF5BURtOyxeqryN+1l/sA==
X-Received: by 2002:a05:690e:4084:b0:674:170b:cb2d with SMTP id
 956f58d0204a3-674170bcdc6mr4003364d50.74.1790639106668; Mon, 28 Sep 2026
 16:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814031745.17140-1-schmitzmic@gmail.com> <20260814031745.17140-2-schmitzmic@gmail.com>
 <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
 <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com> <8c7863da-299f-8c77-0727-fb438467a7ba@gmail.com>
 <CAN5rfbQMTtcvmcgbDwhTQ-D9AGxP5yGqHc=JWbN7PPJXXKPGHg@mail.gmail.com>
In-Reply-To: <CAN5rfbQMTtcvmcgbDwhTQ-D9AGxP5yGqHc=JWbN7PPJXXKPGHg@mail.gmail.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Tue, 29 Sep 2026 09:44:49 +1000
X-Gm-Features: AclHuK9mefzTsnWcGVGq7BKDMJ7VEQKK0e6FJ0Ob2zlKdQoMEB8M1aNeQcESDS0
Message-ID: <CAN5rfbTSiRqo9V1yscb04yckJxQ2z=4VP+G__4+kbTDXeGbj-Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
	linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

this patch still seems to be pending, i.e. I can't see it included in
any of the trees. If there is something more you'd like to know from
me, I'm happy to help.

Thanks,
Miro

On Mon, 7 Sept 2026 at 19:39, Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.=
com> wrote:
>
> Hi,
>
> On Sun, 16 Aug 2026 at 15:04, Michael Schmitz <schmitzmic@gmail.com> wrot=
e:
> >
> > Hi Geert,
> >
> > Am 15.08.2026 um 11:15 schrieb Michael Schmitz:
> > >>> --- a/drivers/input/mouse/atarimouse.c
> > >>> +++ b/drivers/input/mouse/atarimouse.c
> > >>> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)
> > >>
> > >> Alternative, you could change/restore the function's signature to ta=
ke a
> > >> "signed char *".
> > >
> > > Agreed, but without a way to test this, I'd rather wait for Miro
> > > confirming that change also fixed the issue.
> I have just tested it. The new version works equally well,
>
> I have just noticed that if I enable the pointer signedness warnings, I g=
et:
>
> make ARCH=3Dm68k CROSS_COMPILE=3Dm68k-linux-gnu- KCFLAGS=3D-Wpointer-sign
> arch/m68k/atari/atakeyb.o
>
> arch/m68k/atari/atakeyb.c: In function 'atari_keyboard_interrupt':
> arch/m68k/atari/atakeyb.c:263:82: warning: pointer targets in
> passing argument 1 of 'atari_input_mouse_interrupt_hook' differ in
> signedness [-Wpointer-sign]
>
> atari_input_mouse_interrupt_hook(kb_state.buf);
> arch/m68k/atari/atakeyb.c:263:82: note: expected 'signed char *' but
> argument is of type 'unsigned char *'
>
> I guess this is expected but wanted to mention it just to be on the safe =
side.
>
> --
> http://mikro.atari.org



--=20
http://mikro.atari.org
