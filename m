Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19886443E5E
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146615; cv=pass; b=kZZT1ai5C6GSNTikjnUWfeRd7lNzCbmSYACKfr2y5SBtgTvJU7QZl9FBeQX7jeZnmgoOw7kcnzfY8pQtwR+4e4t050CKO5YxOlQkO9Tiz1KcXlbgLIBiBw3uj+GoLd/g1wFrySTyMPpSDSBsK71l06xqQf6az5jceBbbbMlfJbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146615; c=relaxed/simple;
	bh=9xHQ3WPoBRJA6pLffeOMmxeaFKJ9Fi/A5A4l8P9y8gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw9/gV7qeiZZ8LLDUqiupxwGo60SzkIsoH9AZNmbj+X1NfAO6HRxj1k4/Fo+nAUHR3bgmFG7eRnfLj3tZqTmME7SJsQQpJLuEgVwi9FXEdEEwKDtse+E3SeF5tdFae5YqHMDLpmwKtn89TQDqkoqmfwLmlnPh6tSl2OsN23ioSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWEtOpNU; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWEtOpNU"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so385327241.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790146609; cv=none;
        d=google.com; s=arc-20260327;
        b=ZT4a9SNfOsLRhs7+3YulRyWMDO7tZPkeurIBsUvUtoPnap5PeaVdrRECAgdEU90m+T
         IPkUznFZR47r37GaTecpXOaJg/ToZyc1xYIkFs0EMlc49TYJEWXMJE3Kn6HQOyAU/ymp
         h2z9lAyLwwdgEmUBBPbHlf4kHmq5pX3Ftqxo7f8Uz87M76qjZsMjy0zPoRksRAMCvN96
         fl+nA7d7WNCkxPeg+hBfQD9F6ZNuvraTsSMSsFToQCrwrz6fA0t9YOPTLoKjDYGEQUde
         v7MHhqSjJqtkwQqtsta75xekWKDEUk3yve1YNqfM3vpsbI6WlzhW0/Pq0Er1TpInwnUJ
         +7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAxPiacOiPR9kbZrzNk61u7R2KSBWQzo+Rt1br4Efz8=;
        fh=+vUmw978O0AFTCSZW6/90y7AB+x8IP8cm/BDC9+zZKU=;
        b=EM8cGMZAwBxeP9wNQvpA9L8w71k5AOp1+bHFOyFU0ZexJSsCgowDZD+Vl2/y5dSjN6
         UDuUtmTVeaid03nvH21lB1bu43ljB5XZJSoqT5qHo09Adcv7sE9DscAlcWAoyxmRxf/4
         3lkjQ7Us7HAqxB/rDPHDAG/NYpIjgsJDE5Qc1U6Gsr0gGyXV4tjuXAvb6KmmlWKwjemn
         Qk+qIojw16PYu2JITBbw24zVdraCLwxmwCOkpS/aHm5gvr1c1ItT3Shtrz7BmtqONOCA
         xKYuLWmD5+0F0kYFHwbTrmv6WHw8K6obr2KI+5mRFbiaVuJyFjMKSJTxyPbQ9fXSwWgb
         mxFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790146609; x=1790751409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAxPiacOiPR9kbZrzNk61u7R2KSBWQzo+Rt1br4Efz8=;
        b=wWEtOpNUa9sGj8YtxaIBJtBrYgTi81YS+4zSJEiO/qu34ICwjYCOdSZ9+ZBQCjlU9Q
         ye1UfVsCtlp1oVKwbh5GXP2DG4aI8fj9hbmAqRSLbPm15jYKyQR+6J5fn2a/4LIBeLpK
         F1kxiCOqYxQz2RqzuI9tUbB0SR1hzVgTDNJwI3O10UKuxTuLi6RHuhMug94Y/PUwlMN0
         P6D9aS97oajLDPiVJwvC0VLI8MH0RQKtJH4mPX9aC+XqOoEpbeyjyxmsqEMbetheXlND
         8Z3fCwwkQ5kH4g8/jeRgdMFTpFF4FPzE/1rpKenfuVMpRjctkOPsPIpkYQW+o4yGIrBT
         MO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146609; x=1790751409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAxPiacOiPR9kbZrzNk61u7R2KSBWQzo+Rt1br4Efz8=;
        b=X/UHy6or8cWqaMWtRwKxkTXJmeWR+Cw6a8Sam11w9erhl7bzyzKRXNQEU9XNKJrYWW
         3fUTw7YB5JmhqAQXMMupXqPIocZxHQJryHcefNKuzLZvB4BUuhRjNeLsBIYV60hFvbck
         41yc2b/ENsJktRDHNF13Mbbmj3K+6z7OwrGJbLFA7KKYuaqG5TKaN1TWCye8+qNTZUWi
         inLYg2Sd0sFedS8B4alMMa2D3qbrOfm0X6XbAohpfoHM34ad/H1lSSoHkfQgj+M0S0H2
         61PZ5pOgXpH2PotakjwowqfU8/Ujg33GTbVDCU8xLorLGcEXCAfCqKuA4r1IsdHDmsS7
         1NhQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7W032Qosuw6a+Z1oLL52mktCUOlGnjKL/fno8USQb+5GrDdVQ1I2nIxcv++pHhcvx7jZUOYSMa+6G3A==@vger.kernel.org
X-Gm-Message-State: AFuF++kwhiGHsGjGN2pEEhEofj5rrvC7IWMr+BOTcgDJJxQ5ywbcWpxb
	ZbuKgZUyaSSark25chnkmy4R1VBez7LGlVLcpcAZOI75VWVCx6MPaa792hC/A9IMpxL9dOkAVNx
	4sAWprP4OdUEAlUX8/f8n3KhDpuQYrmlX1VlS6Ro=
X-Gm-Gg: AYBFou2QnmhZkqp/7uKB7xfj4i0X4DE1zdS3QScOo7vn8roEzq6XaBZmyduZcfDwBmg
	7/5E3i4CRv0NwBNzFnUofttn0WXnvld60QQhJsHRzGRsd97e/r9/mY3S34WepOawM5xig97U2AR
	xev0DcjfY8F8zFwSHb/LmtW4/BaNql5NSs2OPLeSoNzLDUy4kluMZjvlXp4xSZ+DF8exoQsWzHq
	FOXg9nFg8GEGsmtgP4VGvQan3QCev55g9pWWe0sneLdr7NFjk3j6YYTzNTPAzLZKcrf1BzZd9FG
	F25KAUTFsSmvfbxY8MXWmnt0gz/h6kZiSeI4li6qaRDOXydEL69VSVSlHcN3mRtou4OCoFcj+op
	0qSXKIN365/Vef7kiHxwy
X-Received: by 2002:a05:6102:c94:b0:7a7:19aa:8a81 with SMTP id
 ada2fe7eead31-7ac1ceab000mr1709991137.28.1790146608109; Tue, 22 Sep 2026
 23:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923063114.2683575-1-morbo@google.com> <20260923064622.90D881F000FF@smtp.kernel.org>
In-Reply-To: <20260923064622.90D881F000FF@smtp.kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Tue, 22 Sep 2026 23:56:30 -0700
X-Gm-Features: AclHuK8okRDYHTzt7mr8q9IW4N8bIkemMSEoI0A8lraA56wTX6JOq4NKSUi0ez8
Message-ID: <CAGG=3QUPSZeAPQg=MmxXqqvr3xM3PwV84HVGKryhmk8qJZoTkA@mail.gmail.com>
Subject: Re: [PATCH] HID: bpf: add __counted_by_ptr attribute to device_data
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] hid-bpf: false-positive bounds check panic via data race in __hi=
d_bpf_allocate_data()
> --
>
> commit 4a962db9c72042e7d956ca752f9439fb64fe5e37
> Author: Bill Wendling <morbo@google.com>
>
> HID: bpf: add __counted_by_ptr attribute to device_data
>
> The 'struct hid_bpf' contains a 'device_data' pointer field and an
> 'allocated_data' field that specifies the size in bytes. This commit
> adds the '__counted_by_ptr' attribute to 'device_data' to enable bounds
> checking sanitizers.
>
> > diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> > index 19fffa4574a47..f45fb9cccece8 100644
> > --- a/include/linux/hid_bpf.h
> > +++ b/include/linux/hid_bpf.h
> > @@ -185,10 +185,12 @@ struct hid_bpf_ops {
> >
> >  /* stored in each device */
> >  struct hid_bpf {
> > -     u8 *device_data;                /* allocated when a bpf program o=
f type
> > -                                      * SEC(f.../hid_bpf_device_event)=
 has been attached
> > -                                      * to this HID device
> > -                                      */
> > +     /*
> > +      * allocated when a bpf program of type
> > +      * SEC(f.../hid_bpf_device_event) has been attached
> > +      * to this HID device
> > +      */
> > +     u8 *device_data __counted_by_ptr(allocated_data);
>
> [Severity: High]
> Does this newly added attribute introduce a false-positive bounds check p=
anic?
>
> The commit message mentions that allocated_data is always set before any
> access, but looking at __hid_bpf_allocate_data() in
> drivers/hid/bpf/hid_bpf_dispatch.c, it appears the pointer is assigned be=
fore
> the count without memory barriers:
>
>         *data =3D alloc_data;
>         *size =3D alloc_size;
>
> Concurrently, if an incoming HID report triggers
> dispatch_hid_bpf_device_event() (which holds driver_input_lock but not
> prog_list_lock), could it observe a non-NULL device_data pointer while th=
e
> allocated_data count still evaluates to 0?
>
> If so, would the new __counted_by_ptr() attribute cause sanitizers to eva=
luate
> the buffer size as 0 while device_data is active, triggering a false-posi=
tive
> kernel panic when memcpy(ctx_kern.data, data, *size) is called?
>
This is a false-positive, though arguably correct way to look at how
initializations of a counted buffer with its count field should be
ordered. It's a false-positive, because assigning the buffer isn't an
access. I'll send a v2.

-bw

> >       u32 allocated_data;
> >       bool destroyed;                 /* prevents the assignment of any=
 progs */
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923063114.26=
83575-1-morbo@google.com?part=3D1
