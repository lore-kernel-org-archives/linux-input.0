Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95E3C457A
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908730; cv=pass; b=H7+ZGjM7TnrqHchdRbzkeYlbAkP3Ghpn39ImlIlAH5+3Z4hep1Wop12vr4spjIb2yvFa54RrRmL7K6g2+/2ciDXSD874UhpNwnbjbixDXwL9H6KoAwjZhf3Z1xf6XYc97QYOvwowPTzs6jQ247waQCEKNaMuFDPsZ36Edz2UsEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908730; c=relaxed/simple;
	bh=ZQNNOodnafUfKyYUtCD2T6LN3qY+Op9dMMGlqc0Nkz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S50XMiZ6PUVIjYT4SFHQf54Tvb0eZx2OnHJbshQVzY7bcz3syL/SI+Si9Ch2AQx12sj+PVkewDQwvJ4NRlLvO8yzJ0i7HTXEGIdVFubyS/uzOXpyccBtrHO/PBWUWihDviDOp6jdKIh8Q3Ngy/4D+8cp1hXCGHccuBgTVV8xND0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABs6RKfd; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABs6RKfd"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so3619704a12.1
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 05:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789908720; cv=none;
        d=google.com; s=arc-20260327;
        b=kLZFFcON/z1XdxK6sTEwLfEZ8sUb173pMRtz1Ja5E1tO2Znpay5iEBnLQ/r0uzCaRp
         7W3o/f7jJmYw0GXrOurc6GnbEQEqS9jcoEJZoL92barEskmBYU1muC5R3ABQG/U0CTMy
         CXIYdf1WQldI1uIVyhIY2VN/jZv1aYJJnbT81IRI/qfr/x058BLIng1nJo3SqUao+v8M
         k79YUtt+1h37T9CaWZnsbQYCiDKyf0IDl/ClAhE5RAv6pmrz3s5BoHA3434oPrlZDK8M
         o6hKDkXwPpCZr+iXlbNeGa7eLueGXGP4vz2cJwwQ+eKPj4GyU/pr+ZIYPh8Wgnsa8wml
         2thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bp4dAKucK/aMgP12WCskWZGtUcUwRPZ8et2zUP/K8hw=;
        fh=Kbzgpu79cgdyN2NuFwRWBAbXeaK6QS+TmkjhyC2aT8s=;
        b=jWK9plO9utMRCwdXvdrwLXZy83tQh7kRHLT3KiKb/9Mj7KxRk1R6FMoPY2VkiQRCo5
         h6PNEcq59mKAAwC00Qnh2svWFSI8r5Ia1QuSEK513qq5qEkQBm041ht4r42U7oiATnjw
         Rk5mUa7eNFAmLRHSF+bHd4OL4X3bs1YCdanxndcmIPemVIzrgWdJhFFDT3EYSKdgNk3t
         /RG76j6wBUDkzgJ507fjhQyDeRi2T8msIqFET5NMndQZlS8gi+5BMYbDMGFsEHH6v+jR
         ofINuVg9o3kqlXSQ2/dckwhYgXCxDLFvJVTCuY2pF31/hn0wBPcBZYMHQqOJrl9EK0Ab
         K4wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908720; x=1790513520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bp4dAKucK/aMgP12WCskWZGtUcUwRPZ8et2zUP/K8hw=;
        b=ABs6RKfdNDin0NrMSCUd44X/VUvHJdum9N0S+RzL+zxuN22cf2zBb6pSUYqQMaBzyB
         HRqRMju07/t6Vq/S9NQP755ymLyDDCDUukCyA6kfbYSvHlQVNKvEUzqHsdWzjpu34b6B
         jwFEpp3BrxmVRdgeOlGXXtq4Cugqrcs5NDTrhvcdd+SiOY69POzXmPeSqz1KFqIkAPZc
         Ekj9jIQUWuJN9BJMWUvw6V+Fe8fvJAN/x0CFQHhkfl61d7/C6NRfpe2g6B1VwYcC7qpz
         nAYBoMWahmUKTN/ZKo7xQS2KHjO1bFkl2Bx6ZZqYBAZS1W+Uqu5nPePnAmHZXYJKo4uP
         +emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908720; x=1790513520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bp4dAKucK/aMgP12WCskWZGtUcUwRPZ8et2zUP/K8hw=;
        b=yT94HbYZhyYKwBmHvqN/RfW8XP25NMaOM/6hK1BZJShVtgzC4K50EwOa9mInG6WhX0
         OLhJO+UWD/7xsGXWjXT9dKxLecnSyvBQpjfwetJXjRHzcGnxx6bG3B7HPsCzSswOHWFq
         /pTsfOG20z7yHhp9rC5YnkyhgMbDuxY1U0hoVk0S0bL/khRi83CtnO2nJYRd1m3qtSN/
         h5NKNEfUbtwNRS4sW5Ptd1VnCrXTP4B5vg0NUUxo2Jhl1PzDMwe+jMeL9C38V8ZPAYEd
         RQzTyfKxFK4kWme/i4IaiN6asnY3Yo2H0ecuvxlpkmn45oDBcVJHGcVV6l0gktOXjN98
         5iQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCZZBcQdhz+atuuxZsX4viX06EeJpijgA/lrgEnnGPjONr6aniP6NWG7Jt+IMBBiS4kMW9uvIyhxX78g==@vger.kernel.org
X-Gm-Message-State: AFuF++mvxbJaZIAL3V639mdM+5Df/bYVYfnidwZdTxzmYy0eNmE6YfYx
	ZIF4qb0DaBdoDu/59lp6igQLsavZS/XJTj29zcrV279EuT2VGTncfH5de4mvQyoFglxllnZOT6e
	kwb9CcBkXx+kVimfONFavGytJ/rL+nWU=
X-Gm-Gg: AYBFou1OI8ezuiLbnr4QZBOl5aBBW8U7Xy4J+EHd0vsWf7byB62GwzMCEN9FWM+Oxdu
	kd/w8vnMyXicbhC0s7jpl3wnLtTx/Y6lemsFMtlN9MUl9WlPeT8sRiTncOV/x7g8zFKK8vBWQuo
	4puj1tsW4u/vbyi6t2xGFxsVSCgESthT6z1yZc6rxaWl0l7WR3ymHh9kye2FFldEcVju+SNqvVq
	MGzn3Q+j/BqPEbLJhM+zWXwA6BkGxo6PIGCvdPM+bjG1r+X6m1TS/AJM9nL9W2+VwwBtgvQ0mVb
	4gH1hU8VNIs/ZXwB8OdoD8EBUQT5rfEAlC1jhgx+SwEUdYQwx/Sg2jmjNx4MR9J7o3xxI1ra3HI
	aoqHtPG7PJ4TWHLDMJS1GUwzZreZk/85Q8OJpKtg=
X-Received: by 2002:a05:6402:4613:b0:6a9:a5e7:f8d3 with SMTP id
 4fb4d7f45d1cf-6aa5780920dmr5457337a12.19.1789908719372; Sun, 20 Sep 2026
 05:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919192152.271808-2-meatuni001@gmail.com> <aq9aQzLGtt0MNWjJ@google.com>
In-Reply-To: <aq9aQzLGtt0MNWjJ@google.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sun, 20 Sep 2026 17:51:47 +0500
X-Gm-Features: AcwNN1WS_OTZgLbdgE2iMi0_eKEI4p5XEzEkUWHl2UKLnrUNe_-9fFx845pTuWQ
Message-ID: <CADqcGBkADNEdagkP-SdoXqP2a-z44oY+LRfTuV2kY_9JjxSypw@mail.gmail.com>
Subject: Re: [PATCH] Input: wacom_w8001 - validate index before storing data byte
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jayakumar.lkml@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for the review. You are right. idx advances by one per call and
the W8001_PKTLEN_TOUCH2FG - 1 case resets it unconditionally, so it
always stays in [0, 12] against a 13 byte buffer. I rechecked against
current master and w8001_interrupt() is the only place that writes
idx, so the store cannot go out of bounds. The commit message was
wrong to say nothing stops idx from growing.

Please drop this patch.

Thanks,
Muhammad

On Sun, Sep 20, 2026 at 9:02=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Muhammad,
>
> On Sun, Sep 20, 2026 at 12:21:53AM +0500, Muhammad Bilal wrote:
> > w8001_interrupt() stores every incoming byte at w8001->data[w8001->idx]
> > before the following switch on w8001->idx++ has a chance to detect an
> > invalid packet and reset idx. The switch only resets idx for the
> > specific packet lengths it recognizes; once idx has advanced past all
> > of those (W8001_PKTLEN_TOUCH2FG - 1 at most), any further byte falls
> > into default, where idx is only reset for pen-only devices without a
> > touch_dev (the ThinkPad X60 workaround). A touch-capable device fed a
> > malformed or overlong packet therefore has nothing to stop idx from
> > growing without bound, and w8001->data[w8001->idx] =3D data runs past
> > the end of the W8001_MAX_LENGTH-sized array.
>
> This analysis does not match the code.
>
> w8001->idx starts at 0 and is incremented by 1 on each invocation via
> switch (w8001->idx++). To advance past W8001_PKTLEN_TOUCH2FG - 1 (12),
> w8001->idx would first have to pass through 12, which matches:
>
>         /* 2 finger touch packet */
>         case W8001_PKTLEN_TOUCH2FG - 1:
>                 w8001->idx =3D 0;
>                 parse_multi_touch(w8001);
>                 break;
>
> Unlike the shorter packet length cases, this case has no conditional
> break and unconditionally resets w8001->idx to 0. Since W8001_MAX_LENGTH
> is 13 (matching W8001_PKTLEN_TOUCH2FG), w8001->idx is always in the
> [0, 12] range when entering w8001_interrupt().
>
> As a result, w8001->idx >=3D W8001_MAX_LENGTH is unreachable and the arra=
y
> store cannot go out of bounds.
>
> Thanks.
>
> --
> Dmitry
