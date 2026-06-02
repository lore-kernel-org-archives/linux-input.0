Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD317A2E8
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365041; cv=pass; b=ZGcrwPnlCUurop/hnRDRHg5mUAP6Si+MqZFW/gO4UvklP9mONBaorQKvL9yVEPKmnHacVi7pOUatUB/rOGZCyfgpG0mirNhtJkJPJ7vfxLmh53jW4Bak9s7ChzR2Dfeg1xp5kA/ODOrri8p/72OsT0nCM6F7rJVmW8gwbqPYihA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365041; c=relaxed/simple;
	bh=IEMMAfJMvJo1FCYhAdFh1jB4SrG/5+lzCPsaeQfGVmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAMM+Um8qF/JVwyz4TLieH2GkduFaXjn0zFIJDuO3onU6D/CqFZyf7RcS/Npuv5zX8dE21fwZYvBB5u+1/fXwuEj7uQtuWeVb9eC+Rl7fWS8KVJJL0kxgAKwq3YXH0o2m3ZL3mEUTpTpE3e9nMd2LjWFESqSfFJhY4A4PasHwBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTpal8Nx; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTpal8Nx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e0743942f8so27997287b3.3
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 18:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780365039; cv=none;
        d=google.com; s=arc-20240605;
        b=S5dVvv5PYUOFAN6T48MzkPqaxOM3t9iu4fKpVpH9IPslplbaLGXRW4kW5HnUdiFeGf
         g5nlEOwBTBqQd9WhUWhRJ6hg0ERb8vfpra2gWAQdrDsDlyikWx2NUAUQBE8vUBJ4iOzc
         Xg2xmrG8IuHKHNgl2rCEgVUeyIbse+nZG+sjZa2ZkJO2+mw4wKLYKtFP9FAEGtHcvPTH
         tIxECh2dHToaYzn48CAj8yUark4xdXRDQRm++TczsmVpXxjx/d75IFlvmZdyR1Gemt6w
         tcwGE9Wl8zXKRELA3PZeH6amw7yPgJ+GhrAbVW5xOwJLRr2bN98mYcAKCrhkLdzKNXmU
         iUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OI+jyiHnSoNLSnd00k7+mmnjKOTTHQJZP66lBErN93Q=;
        fh=NSgzkeHIZ8n5u3UQTELtvs2rL2gofNpFvXaV2CQ81vA=;
        b=azqs+YUhpuYMZ5/lIgydzD0kCYyXX1FPeaxcoEFOISj/MGOJxPW5MECm1fk/pZb8HJ
         jCuwm/+ALGpUd3GesJW38ha8o+LDyr3dLSVrNQ7XTwpF3g20RoEKd1mMNoZZjovVFkQR
         ZlSMfbEPp3Dsf8f5MWea6eRmtiqy4nJhv01XVddd0S90Wfgr1wq7MWZsaCmKM76sL4AC
         96HVbC1RwAFZKAf/7YCKUhWnIT6ONhJ+0supwqwcwRIIe5z1wkFzULjBUu3mbnyfi7RP
         ntFQFqPath6ikwG2AhpwmPBxhWXJ7vFVmNkz2JWlG7eUrTkWpxP544t6p290OPIXFul9
         HggA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780365039; x=1780969839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI+jyiHnSoNLSnd00k7+mmnjKOTTHQJZP66lBErN93Q=;
        b=GTpal8Nx+kmWWi1fkrxucdSWwmN1VNipRDjhD230tNlkBr1LqlH/uvRwVQY2y3lg+N
         6JfapYqqqrlm+uBD7zyL3WYcB05e1qk/8i3jHH8T1eIV00O/xqFFEcvTsr2ut/Ca2rd/
         PAUEomn/GYlYtmurVBJlkW7soDGKByVOw1C2uz7cfqjC/VcZgCZMib3cdzTX+dOILrKM
         Zi8U3DrTauAk4ZZad9okU8rM4uyi7N25DGDCe6TTVqrWknURXn0rcqkUNKfMeDif9y4T
         ohC4LUVKkS9wfQQCeLmIbhXwN/HCe15umWTPjEV9+kWCV4u+ELiUZGFUpGwixdJjKCec
         VuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780365039; x=1780969839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OI+jyiHnSoNLSnd00k7+mmnjKOTTHQJZP66lBErN93Q=;
        b=IPjqVzSH9Th4GJZOdQTeTbISH6dvzgKUArYtnwQY0Quote7JE0x5Vfc9BzzbNdndbc
         6gSe9subdPb8Kll8/FAjGmeWrxtdzm5bCxcP+eFHnA8s8Dq4jz3txO9RjDA33RSZ3jMh
         v0qJvaF9pSPNRfmFq6Owav4z5ofXVxxB+/QBWNsmRZ+bXIRlLe+AL3S+4J+qaKgUJTCn
         syB2m3rLyNr03A9f2tKUhrKGCAq+IDGj+tlphYswHa46iIJdDEiqXEipPFoN0gu2RbCM
         sBAK+e59mYQmqHp7e8HZ79a9dcuXVsqnyQYAU3t6PZK+aMOjNc8x5BYUx/qcxjGIcfbY
         IE1Q==
X-Gm-Message-State: AOJu0YwbZWMk+rsFqWXvRtgAQHRqjqpRv9lbNJ2jSMxloty687alT9W+
	4Uxux7ODhThAfxAGEzUeeihLoGF2g3ZY5SqITOIJa/lo0hm7TSOkkn9f2JmtpcCCHnRWePSp2oS
	2EoVbtFGL2/4XqQEOMX01i0iSbrDAKGAZLcdAzdg=
X-Gm-Gg: Acq92OH58YXHyLDE31fBhobcdNemtms/By3wr2WJwSbO6SJTDP1cdkshoMY9piXD4io
	HTUjeK2Eotq7sZ69j+DFUwWaqHWHOJOJKOtwObrX3wHmj096+DXITu+Uv5J29HUrdz9BZv5tgFs
	7Gq3g+UXESRh84G0i/O2eTxVc/C1RrJ07KcUJmrKPtya1/Q+1qlhpv5f3FBg0eQt6AMXxHJX3jQ
	aVR7rYVttGvzhreVVMSz+tJb0zTDoYYn5U7e/X1AXunjfcE/BqHBRKpnXvovZsGK9lXqYw3jE7a
	Jv6D2xXCZERnTVNGDog=
X-Received: by 2002:a05:690c:4b89:b0:7bd:5579:185a with SMTP id
 00721157ae682-7e05c94e22cmr132557187b3.25.1780365039281; Mon, 01 Jun 2026
 18:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp+u1YARE-sqwuNtbpG7E4TO-Nt1KQEeWiHn6pjoLz5kmt8HQ@mail.gmail.com>
 <ah2-X1_innZZTAMZ@google.com>
In-Reply-To: <ah2-X1_innZZTAMZ@google.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Tue, 2 Jun 2026 09:50:28 +0800
X-Gm-Features: AVHnY4Lk7JmtwUlLvBIBfNnrbDE_5ridLagWhnAM9SoTbzsgVz4V8nplkOhPbZY
Message-ID: <CAGp+u1ZsBan3UmScaJbN5nD4esKCbJeft8dQWvwi_dbbc8+9yw@mail.gmail.com>
Subject: Re: [bug report] Potential atomicity bug in drivers/input/joydev.c,
 between joydev_0x_read() and joydev_ioctl_common()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Many thanks for the clarification.

In that case, may I kindly ask if it is necessary to fix joydev with locks,
or we can leave it this way and let it just tolerate some inconsistencies?

Regards,
Ginger

On Tue, Jun 2, 2026 at 1:22=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Ginger,
>
> On Mon, Jun 01, 2026 at 03:07:05PM +0800, Ginger wrote:
> > Dear Linux kernel maintainers,
> >
> > My research-based static analyzer found a potential atomicity bug
> > within the 'drivers/input' subsystem, more specifically, in
> > 'drivers/input/joydev.c'.
> >
> > This potential issue is present as of git commit
> > eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.
> >
> > Potential concurrent triggering executions:
> > T0:
> > joydev_0x_read
> >      --> spin_lock_irq(&input->event_lock);
> >      --> read from joydev->abs
> >      --> spin_unlock_irq(&input->event_lock);
> >
> > T1:
> > joydev_ioctl_common
> >     --> case JSIOCSCORR:
> >     --> write to joydev->abs[i] (no unlocked)
> >
> > The above trace is meant to demonstrate an illustrative example of the =
issue:
> > IMHO, in 'joydev_0x_read', the 'input->event_lock' is adopted to
> > serialize the read
> > accesses to joydev's fields like 'abs' and 'keypam' or input's fields
> > like 'input->key.
> > However, in either case, the write-side accesses to these fields are
> > not similarly
> > serialized.
>
> Yes, there is lack of locking in joydev. Some of this might be OK (if
> we prevent tearing on reads/writes) since the data may actually be
> obsolete immediately after we read it, while in many places we
> actually do need consistency, especially when we adjust key and axis
> maps.
>
> Thanks.
>
> --
> Dmitry
