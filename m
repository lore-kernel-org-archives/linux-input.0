Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32B3A3E88
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036471; cv=pass; b=b75rdW06JlagSmLxnpbEzQBACeK9mmAhuYSQSy6WYHFhYnU304q1DPBHlGsSZ3bCvaahQ00w+1MaBpGp7IBQznJLf6CHcU8qNwevZ7beKjKtdnWdHvdmrG6ollH85oON1gQ2Josw57uQ4Ic5p6pFaS0HG8WMOUw7nHd//uLpFiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036471; c=relaxed/simple;
	bh=NmGxxV1ccMaWobl9groVKICcT8IcKvrDKiABQsXjUlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ee3Nn8vxi4+e7h+ZzZ8eYTXl5+bT+iqzqHu3TVhEO20GSbwX4Ak2X/G9jgCOaE/L4pYpA+n7yh0mO5y8ciae1zcnu+4KaaEU7hLNJ5zllf0jDncSZwV5gDT31LHqQs1vDYtJK7qxPQ76Z+xRYCohMjZigCUZCmj2t0NXVNN4FIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai4seF2N; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai4seF2N"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9106ea78cd8so2061351385a.3
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 23:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036469; cv=none;
        d=google.com; s=arc-20240605;
        b=K5E7pAqv4NlqpDmvd2/WFGf1cNrSt1a6Q4IO1VhUc9r5YRdTZ5nrD82Bx4GEzUFyEs
         72y4Zh+M52PTrazLSFcRE2V3Q/OcGrVvteGHdNY1H0M8ekG5440ceQvLPxPEIeP/A2vQ
         JDH2KZtx0z8ZC7bsVNfsJ0QIlAjlfsdLR7Nb/wEMhKU5nzeV5PXVXawBbhPV79hNJir8
         HmKp8369am8cCo+FeokPYOGmCaldhwT8qfSo0nTxAHeo9wEl3X9ThINWZ1Vv+ZG8ZvHM
         WsrBLkXBCgBvHJwy7sWhJNq8LPG/M/IHRV/aM94ZN2wJItjI6RqJe7pxsciReyJV0CdE
         3JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Whahk6cXTPlSo53X4gprqXHBEOntvV6kJPO9wAT3iVM=;
        fh=p/h4SgPTmDeBb6TIb+THO0SmnkTHFvDcKKZ3Ugusczk=;
        b=SVrIRbmGP6NWdG73v1lJnqqIt13cV4bzPymAr1xFgNBZKGip1YfmPhYvbj5yWEuZcJ
         q3Bl8D1NNNyHw1cvycY3re80OJ4uMffGNTmRQtqldPK6OBXaR+CJKyAjLx6uhbdiJqRl
         NgW9DEwVxe1HzE8nkCdyfmEMHsDNoSiqevDOF7NSRYzlTKErUTLTnl6cU/cARZ1HIKuP
         qgZQC0qoeM9iXwwjvcqckoL/rPSxoqOMgrlCV+Fu/Mbfy0VeoLZ46ixxBSxWEWlIYkUG
         3/Ln+ht+vEnKFp+/7owZa/3VbmL2n1wu+04FXwkZr61ODNXqO7W4SFWJDCa9LU9gLwcV
         9jNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780036469; x=1780641269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whahk6cXTPlSo53X4gprqXHBEOntvV6kJPO9wAT3iVM=;
        b=ai4seF2NT3L6O8JvBjAnrsTxPPRfH4qks1hh/mbUBYb6lgRlzBS5l8ouToT9kuoNpd
         AGJuOW0n0NV7P6UrlJxGi7gJ56QpHqctEMSZoGcxEHTbc3nLPd2wkSfQSQdco8lYlW97
         06d8MM4/9rodjhy1t2HCLyyWpEhXt/aPEA39/sIjF0q4iAmeWgGdO8wLB5SpzNpRU3SH
         dAc2J96htiY5UPKVbg27lZwZif5Vm9F88yS9V7VlarkOUnq5CTnZ8gpLMjP/fjhgcrLE
         mrsCubEf4iKG+iyo2iFSuhWz0U6i86ZmzNHbjGqbSEJ1NoIw0UsIALh9h9tJeiDsBZfs
         ZyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036469; x=1780641269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Whahk6cXTPlSo53X4gprqXHBEOntvV6kJPO9wAT3iVM=;
        b=XK4j1Gj92/roS9XsTyA4XrbQQw72nzS9RvzqYjExKbvcrGB6ivsEiuDk3ygn+H99cK
         vwIz9iMuC3TVM5q3YA7JPkwq6VRmGBglxsZ+kDfhDm2CwL3T6qmxNjw/Ic1U0yIFvk2S
         dpbOkdXoAjNc/3i/pqqSSepbC+edhaSeCleFClK5LF5zeJRsmJ3RNiEOEm3NwdMd8h48
         1X5pXu8lp7Pw9xaMucLGn8/9YjwsV/0T/vZxSdGUYbBvhnUlLzPC3a374FIz9c8wcFy/
         elxgUaCftSRxdUF5J6ORtstKktrhNF/YUtgaxaoSxA/lgNsMr2HEfBK7mDXVXrOydSAS
         kdOg==
X-Forwarded-Encrypted: i=1; AFNElJ+f0oSgOYYH9mdaB2ctdfgMt2N7aF1xP2yQRDhWZ2e4sz8jP60uZrPFBWWLfi7436jypTc+gR9DI4UHgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvH+jiyA/0NBDy4DECVT3ysSTqOclquweYZqC491fu6Nhpl5N
	AI2C9V4Q7nkcF4nAETwSs9Q9d/ZVAZgiJ0pT4xPQdGqDR8dmSAairdhI12bdSwhIuHCx0exRkDP
	4h6M4oRVdTYX4qnYsgTrPeV4Uo9Xgvi4=
X-Gm-Gg: Acq92OEzcHwmv3i2ReLxpDZ9j8cPlLtZAfZzIYGhLS7UCUPdARtpTzppEKyf4ZG2Cl/
	TATn976ZmxwxwRlKstNmLdMXQwwrhR2TLTQ0HQkh9Z0Ao4DMU+A+WlchcbvcUdwt4OxsMgfEn7t
	mHOJXQAniJ4O4at9PRcAYc6YErshwFV5ehpzbG23EDL9ZziMsI3F5SC5PISSYXj+DFEZ4kJm+rO
	qJf3/TFywDd5/mfjlVFf87i4gQL3BRFgA5UZtkFiOJWR+VFPFVXYZeHsFQUDkfCe6swsb9ItxkD
	+jUdjK3/r6vJNIvcJxT96KAiXS/XRQ==
X-Received: by 2002:a05:620a:3909:b0:909:e4dc:fb30 with SMTP id
 af79cd13be357-9152fdf1113mr198579485a.38.1780036468943; Thu, 28 May 2026
 23:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
 <20260527222122.10620-2-derekjohn.clark@gmail.com> <ahfQW54YoHj2Pal_@google.com>
In-Reply-To: <ahfQW54YoHj2Pal_@google.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 28 May 2026 23:34:18 -0700
X-Gm-Features: AVHnY4L7p9N00U3axazOK5ok5KIWcX4_lFWy9ALaEHgnm6BXqfjhn4HlF5_Axhc
Message-ID: <CAFqHKT=zRMW4gu09xz2WAukjXB0i9d-z-SfkxU67yJkCA0DZvQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] HID: hid-msi: Add MSI Claw configuration driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Denis Benato <denis.benato@linux.dev>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:32=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Derek,
>
> On Wed, May 27, 2026 at 10:21:19PM +0000, Derek J. Clark wrote:
> > Adds configuration HID driver for the MSI Claw series of handheld PC's.
> > In this initial patch add the initial driver outline and attributes for
> > changing the gamepad mode, M-key behavior, and add a WO reset function.
> >
> > Sending the SWITCH_MODE and RESET commands causes a USB disconnect in
> > the device. The completion will therefore never get hit and would trigg=
er
> > an -EIO. To avoid showing the user an error for every write to these
> > attrs a bypass for the completion handling is introduced when timeout =
=3D=3D
> > 0.
> >
> > The initial version of this patch was written by Denis Benato, which
> > contained the initial reverse-engineering and implementation for the
> > gamepad mode switching. This work was later expanded by Zhouwang Huang
> > to include more gamepad modes. Finally, I refactored the drivers data
> > in/out flow and overall format to conform to kernel driver best
> > practices and style guides. Claude was used as an initial reviewer of
> > this patch.
>
> I wonder why do you need to roll asynchronous probing and asynchronous
> resume by hand? This I think complicates the driver greatly and forces
> you to use a ton of works, spinlocks, and checks.
>
> Thanks.
>

Hi Dmitry,

I suppose being asked this means my cover letter and  commit
descriptions need some additional context.  The MCU in these Claw
devices is quite temperamental. There are a few specific issues that
cause the need for multiple work queues, a serialization mutex, and
subsequently spinlocks to prevent stale data reads.

1.) The MCU will halt function if it receives any output reports
before ~500MS after probe or resume. This can either manifest as the
device never responding to a command, or it can cause the entire
system to become unstable and reboot. This creates the need for
cfg_setup to query the MCU and then add the gamepad attrs, led_mc
device, and rgb attrs. As a side effect, because a system could
technically be suspended during that 500ms delay, there exists the
need to re-queue the work if it was never triggered, hence the resume
queue.
2.) The MCU will not always respond in order if two or more output
reports are sent within a few ms of each other. Since many of the
commands use a generic "ACK", or share an "ACK" type but don't provide
specific context about what sub-function called them, we could
potentially have cross talk where data is saved in the wrong attribute
or errors propagate because of a missed message.  To get around this
serialization issue we hold a mutex through a completion triggered in
raw_event and, for most events, save a state machine on what command
is expected and what sub-command was the initiator. (I.E. profile
events handle the M1, M2, RGB, Left rumble, and right rumble). Since
the state machine is accessed on both sides, we need spinlocks
guarding the reads. This essentially serializes the data and makes it
predictable. Using this pattern I haven't had any issues reading from
or writing to the MCU.
3.) Some commands will never return their "ACK" while a completion is
held, so we have a workaround to basically ignore them and hope the
command worked. This is only needed for SYNC_TO_ROM, from which we
don't need to set anything on its "ACK", and switching the gamepad
mode, which causes USB disconnect/reconnect and the driver fully
reloads, so we'll never be able to read it anyway.
4.) The RGB work queue is used to free the userspace write while the
completion is held. I found that use without it could stall userspace
quite significantly if it has multiple writes back to back. I
experienced this using Steam's customization menu, which sends a
single write for every increment of its color and brightness sliders.
when traversing the full length of the slider it is possible to have
effects changing for nearly a minute after stopping. With the queue,
only the most recent write is eventually sent to the MCU. This issue
also affects the Go 2 driver as well, though not to the same extent,
but for which I'll be adding a similar de-bounce queue soon. Go S is
also technically affected by this bug, but that returns quickly enough
that it isn't really feasible to trigger the bug with much frequency.
I'll still fix that one as well though.

TBH I'm not "happy" with the complexity of the driver, but I don't see
a reasonable alternative. If you have any specific suggestions that I
could try that might simplify it, I'd be more than happy to give it a
shot. That being said, I'm not very optimistic about it. Development
on this device has been like wrestling a bear.

- Derek

> --
> Dmitry
