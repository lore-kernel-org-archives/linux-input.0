Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE048097C
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711734; cv=pass; b=kKoSsPgO9DspSdqjLUXLowiufkfTSRXdf1P63ryQ+vGOx1VI4eSPwNwmr6AqRZB3U+mB9yi587PgA3zXHYPHqoMg7EK9nIxpMZRLV/8eiBYOFxPSXgZyMZM2AeVJfxRjJuRnTdSboJzFW2BHdIfOHRzXLy2JT2lyA56cdvTDATY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711734; c=relaxed/simple;
	bh=0svBjYU8Rlxkjftgl8zGK+GshjTNX38hympT6l5KjSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfx3G95odDKJhzillvWSVKWVPz2RCZB8733qjszjZ+m4cuuJYNR80CBbf7F44chmgJuzJ5pstRbgFvaWmAQCFW1h+DQWD2IbqWrzJ1UJXSPgMUHEZN+afeegu0sCljf7VWJE43WfBydwE0oXvOyMiA2NbcE0t642A5pVQEjagv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBA2jcDn; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBA2jcDn"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccf887de87so66793606d6.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711721; cv=none;
        d=google.com; s=arc-20240605;
        b=aawaFOdLs2wf4T63+UKe0ioAdJLCM87+YuFB8HdEpK25PpMcZvcRyljkegqjoJRgdz
         16H0aSW/p3OHbSarEK8PNGEPcy0ZmVXQmlwN5tVOC1V/bcxjhAwQ30gnFunvIZ2Oc7bg
         qOiws2bdWn2wqg998jDUo9hj0B6cGxhyH0iPUh9UlcYofdZA43G6w6n3Kes3ArM6UuPq
         uhuxnduJ42pZIVp0wfHTEspqrxqZzDqQdWq8qs2OLEaAp8v77mEj9U4BBydh+ghYGHmu
         EE+i+BURgXl3zmrbw0XrbzbPrm3pv5Kh9h5AEw0Hga4h44SmbnIqrAT9ZVY7U3uJc88N
         QcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        fh=wUWsGf8EL6Yd+Rnw4Gk1zf/4I+tDILIlc0UWu4FsICU=;
        b=F1gjhUaaAKIBx/YPYaIGs4oQ0rVeoaEAvyFL2py6X54E9l5VafBNHRdiT4UpSRF5Mf
         rjD5whkwzvKf1yJ0t/ugZcqP6qZw4YBb6m/rYJd/I5dP8XR2/412EfxumZYEf/bSn0/8
         lhTcDg2IvcLrVpGxC2wAm8Vpy0hOeYWULPayUC9k+cyWmofGmKy4b02Tdeg8JDwxqMlz
         RVIGJdznAvapzMYjI1woRN+AB8LDHa+pKm0ao7xPHk3ydV+ElECNt+pYocoWMC0PAqgR
         fiSsEenv2u8rI40URNQMS/T3ZuiQUcYPUo8nCmjixUE+xcQlGGJfLnezUwnCLuNtcsDa
         zq9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781711721; x=1782316521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        b=iBA2jcDnSJShyJy1mjdVuNziZ6FmCqn37jwU7ROhJ3NiBFxrDvupxhl+ao1TZSl8si
         jXO0jUXAYtrChplUzMD7F75Twk1Xe+iWYjvU338rKA8fPkKlLSs27mio+cmxoc91ijSx
         IDOwr/rsDbJzs0bX5PSQsUoHrou4x3OjKgKwK8V3VfmTRzFxF/rQNHqqYHeMqpfCRYj9
         5h5YDrt4UWR3iwRy7JL2a0ud5n/HoaDLtT/AIgYVDX/5ccC2AU66IGyreNTPQjmxRT0m
         wwkR4GMnX48ok4JvUIlRGggszjEq8Otstw7BZnmyvYUUseQWBPA8AsWP4RkwYHgAhZwR
         W1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711721; x=1782316521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0GZODSrZgipIY+mYkKr0WTQPzn3Ok5TDY0Ttij7IlI=;
        b=a/AEIJRuzxrBN4A+OmMbNWebvF6dy+U2ZOd+ol34cnN3Vam2okYWiU4gzZvIeIzLmO
         XDOs0QFZ1d9UjK2dyly1y8LB3Nt1/yQdOi2AzSXyTEOtvXtlTtH2+7Svnxt021SpOUmM
         wrN8o/y1Nd5RGVE1Qie0wn1itnzR+jM+RYMH9Oy6SHpf8XVxw98wsAXUtrB8WgxcQOlP
         NPrqcngonyZvmiC7c2L05rksTV9UIxaNj3VjUP205McJORUR53wrlXKH0RxJTci7muiC
         znpHWZCG/nInh/fD8hcn4imutE7SamvB3gjYfjNACLjWEKLoGhTLoiKWwoygveG7HPqc
         45XA==
X-Forwarded-Encrypted: i=1; AFNElJ+7HuS7KdWOo4FOjWPXe2QHumgAvKiDOjUS7p0p2+KZqQKofcxNLP0jXURSuVrbnyNjAkDYLJq7OhIZBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVz8+nkQxi/J7djchTVAPDRbm1BOBxTSVnAvpWYqsWaWEP93F
	Yus1JZlY9MDR9sSLfJGZO71uPjPtEH0cs/TSmXfMC5m3nVn9sHNQwwqcJkIRAUICRbpnLMOk40c
	9xDYoWEgKmxWjD1zuwHp+HKvZd1oUogQ=
X-Gm-Gg: AfdE7ckS6VU7HLwcnx4eliN5O8T4dxMSEEXA5E2BxMjBLqHMBAv/Kw9/IjiTxcQbZ1e
	4w7iY9rvhOArvnQt44j+QAE8Jp0m2V/UOnYH6K9mag3pxmqAFPNItZCRPEHZs43yFN0rLFw1VIN
	2tt+aEpvqSWrPi7/YpDFdcFl/OJ7+fdrz0tU4fFdZ3SApI+ZP0FldW4KdDk1v/yGIhgWwskJtl9
	Hjs2W/6gmLhmDLGESVew7GpoyWVAz/xXZi4IF2mtb1CNJr8mZzNOpacH4ZCQ51rEi6NMh3+9g==
X-Received: by 2002:a05:6214:4885:b0:8ce:9cbd:b0ce with SMTP id
 6a1803df08f44-8db83be3792mr79261076d6.34.1781711720531; Wed, 17 Jun 2026
 08:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com> <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
In-Reply-To: <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 17 Jun 2026 08:55:09 -0700
X-Gm-Features: AVVi8CduFyKxlhK1RSjwdH8nJ6Ov3bv8dg2gVWyi3GEY7zVefRXqpDRmgWhQReA
Message-ID: <CANRwn3RTGZcOV_kcF02C18Jd6uLMdHz4vB-n-GaCiuobNBubzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] HID: wacom: add report length validation in irq handlers
To: Jiri Kosina <jikos@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>, linux-input@vger.kernel.org, 
	benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:19=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Sun, 17 May 2026, Jinmo Yang wrote:
>
> > Several wacom IRQ handler sub-functions access fixed offsets in the raw
> > HID report buffer without validating the buffer length. wacom_wac_irq()
> > receives the length from wacom_raw_event() but does not validate it
> > before dispatching to the sub-functions, which do not receive the lengt=
h
> > parameter.
> >
> > A malicious USB device can declare a small HID report in its descriptor
> > and send a matching short report that passes the HID core size check
> > (csize >=3D rsize), but the driver assumes a full-size hardware report
> > layout, leading to slab-out-of-bounds reads.
> >
> > Note: this is not mitigated by the recent HID core bounds checking
> > series which validates actual_size >=3D declared_size. An attacker
> > controls both the descriptor (declared size) and the sent data (actual
> > size), so the core check passes. Driver-level validation against the
> > expected hardware report layout is still necessary.
> >
> > Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
> > verified kernel panic on a production device via uhid.
> >
> > Jinmo Yang (4):
> >   HID: wacom: validate report length for PL and PTU handlers
> >   HID: wacom: validate report length for DTU handler
> >   HID: wacom: validate report length for DTUS handler
> >   HID: wacom: validate report length for 24HDT and 27QHDT handlers
> >

Two main comments:

1) I would prefer each of these commits to pass 'len' as a value into
the sub-functions and perform the checks there. We already do this
with several of the sub-functions, and it would be good to be
consistent in where the checks are performed.

2) Please define new WACOM_PKGLEN_* values in drivers/hid/wacom_wac.h
and use these definitions rather than magic numbers. E.g. `#define
WACOM_PKGLEN_PL 8` to cover the PL case.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> >  drivers/hid/wacom_wac.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
>
> CCing Ping and Jason for their review. Thanks in advance,
>
> --
> Jiri Kosina
> SUSE Labs
>
>
