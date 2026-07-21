Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9A3BC667
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622142; cv=pass; b=Zn4FIQq2AyQjO0w0+vUEBe3H9zDMe1eZFaCBFkCVM9lO+ZqHMVjfTFd9B3UHlXxneWYffIJguhvb4lovDFKVsYgD0F457ClmtZyTWqYHX0hMV8nFiKD29QTl6msQCbm2pKjv35mjYADHeQUqyK5kbOnb5tHCEsMtU7M715nDxl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622142; c=relaxed/simple;
	bh=PbIJX6UD1ZoB02wL/E9q33eYJBL+Acq3spZ3mV7eLNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQcn3wiIjwlpcpviRdq6DT2Hg4hE2NZq8guS/rI3KAxIdnKcrSkiSeKb7+PRuVbvCpoSGr0CGQqw048d0pAs2fQflQSG1X7d4F2slXb0Se1xYwPNCOacuIvMfw4DLVMpRYMVlvO0I4dFTFUd1PF/SlvUp+fQbuWV7mHI7J59uXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F1XjJP9R; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1XjJP9R"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81eb41c1f1aso90135887b3.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 01:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784622139; cv=none;
        d=google.com; s=arc-20260327;
        b=m12tuG8677o6FtVdtWSU9+0u0fx9SGCJplUhZKXhjG9XjPa2W4oV02zHBKQIIcNAiO
         wlpaHTVLGn4bMbyVjIZEvHBoLNXrqk8jWf3JtE3jLG/4hyGlizDKXso6eE6MblfijXJl
         lSBLBw+8HN3ANpkXzJKDCgylfM4eEFEVvSCLtN2Za+vG6yBxwIDtbJ7VZUOoihE6TlXU
         Vsf0gTKTXystlxn02CTk/Q/e69+dChdtz/deSFBKrDyA6E9CfFbTJifloeawpG/1iL0m
         ULr6+qXDhg1+AfM0wnL91XVNaY4sO8vHUh58oiOpD6Fn71JOFxPa6A1TnYS2mKi1ohBY
         n+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYMCpupp8yQkTntIzJ+s6xUACTMSRm9maqPbU9ARNc0=;
        fh=fxc0XItP4GNEzshsxLeHxykFjLLl+OEkAmX2boQhxA0=;
        b=PDFoJ1lrZCJmUMkjExjnT7quV8jxxtl9Wgw8qHvupBmdwnv+fQU2bEIFb1BBvjUxqd
         4ERP8nWg7bMpj+HfY6Dc3cUOGccQpgtgkI+wFZ44WH6coRIL6Q9vvpbG4gmUJD48zOPB
         FZMqCcMr0AfbIZuzX/yracoyU6cSN8cMwCqD5G98OBZagrbAe1FDcdGDtqxiSiFdeA8j
         gzekFQAHFZvlU0u59/FOZPJqRrjtRjNB8wnX6Q8gpcrQ29v/fLjDiN/Jj2xNYJbvjO7T
         AsAR4VSSjSF8a3Dk1hjWE9sARMhfXBu68MXYHYp4mqVAaClH/INhShq3PiF92u9eVEXB
         LaCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784622139; x=1785226939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HYMCpupp8yQkTntIzJ+s6xUACTMSRm9maqPbU9ARNc0=;
        b=F1XjJP9RSududKCLo6EeKgKou/kEV42yt4KUpQBLEwNmDAK9KIVeC+QT0N3l723QsX
         /Kmz+ZNc/ahHWhwYxu5Ge3w9AZXFrhOW+JhPCZUlbGI44QOZetIHFvmGIcnrSKnu6zgY
         /4I/5fcpD4lMTu49IoiH2eXbPiRcw+8rQWLfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622139; x=1785226939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYMCpupp8yQkTntIzJ+s6xUACTMSRm9maqPbU9ARNc0=;
        b=Wxz951xRb5yiNGuCdmW5UB6i0LCCGbkXnnSAGu3Y/MZM8+jNv4m7DSXCsFHBDGMjlJ
         AytJIKjjcvtezoeXpD+c1PM1RVbWDm55kbx4XRjXI2hXh8TZBx7aFF6865StTvr5QwYS
         g8V4vPHEQ/hWp/N+S3mo1NrGQ/N09a9H1KJV70r8ftDuqNlZHxWnYwwyUovF54XisO2g
         yI9KttG/H4WZ1Ap95cbpkev4wFSMUH5kn0HDBcwaaxIJOp3AneypTZzVQL3E9ufUQaaA
         CTwl/Svgm4XAgsDkHvW3phsYYSHm0fyU/56Fg4rMjveCJVk+JV331/SdWrbMfF3Dac99
         oJZg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6cPcydtZ23Qo7eW97fA4pjuTKdrwcnJkMxIYi+tSNMWBjLDuFQ8QnKguNI8IU8F3Qhj8kAE74elHTpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoxUJib+aY+5jmxxuiRyVsR8zOG3z5BJ0o3nc7fZQJSTG+yK4
	tooy67VysezV1Z/tt8dGfWwggUwukVGwga7hpX7HqvQ5wm9CEftJIah13a1N14jsZr+fFiB6+LD
	nOE/Gp58LmMhMOk0OXzq0b/I+VKOQfQhWTsQmzmzr
X-Gm-Gg: AR+sD11BRgL7XakC5kUnqDEKWrnnpIJGE3ZE0nr7i4oc06HaCUhkcqWZr+HoJGYrDeX
	GFrICx7PTeu3iFahpbHlJpUaeaRvbN/YOXthB7IloIXWcxdRellppAX85/kAI02REoPjLTwW38c
	jRNfQK/vPHzRdVVERxZ2WB4igUqmJCpMBwsMTZiDdOJ2nCNAOBWpbmmiHoyxQnWbceK0jNL2U7F
	oJGvGQXT9hUxli2dntI251QJr93HCJRvchI0lBHTkm776+dhKigx39Xkkr9nGmyiuu1NQDz6ph7
	9ZH3EvCNE+cTgiXjI+YxUEjANA==
X-Received: by 2002:a05:690c:7342:b0:81d:cc00:cb8e with SMTP id
 00721157ae682-81ef27f1cbfmr54139227b3.37.1784622138845; Tue, 21 Jul 2026
 01:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-2-wenst@chromium.org>
 <20260721080829.4153C1F000E9@smtp.kernel.org>
In-Reply-To: <20260721080829.4153C1F000E9@smtp.kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 21 Jul 2026 16:22:08 +0800
X-Gm-Features: AUfX_mxfs-owsFVntpy2TfnfT2PivUx0k_MVeEmOEDZDOObrM7yQy9fA6FUILhA
Message-ID: <CAGXv+5ECnGRwdqRLQG6EQ_bqaezYCrMkczn=MP=wXfLhG3Sh=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
To: sashiko-reviews@lists.linux.dev, Mark Brown <broonie@kernel.org>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The prototype for `regulator_enable_and_wait` in `consumer.h` in=
correctly names the delay parameter `ms` instead of `wait_us`, inviting dev=
elopers to pass millisecond values that will be incorrectly interpreted as =
microseconds.
> - [High] Sleeping for the consumer delay while holding the recursive `ww_=
mutex` for the regulator and its entire parent supply chain severely degrad=
es concurrency, blocking shared regulators and serializing async bulk enabl=
ement.
> --
>
> --- Patch [1]: [PATCH v3 1/9] regulator: core: Add "enable and wait" func=
tions ---
> commit 73793dc0bdc3050ff22074a860d438d5d9cc0b49
> Author: Chen-Yu Tsai <wenst@chromium.org>
>
> regulator: core: Add "enable and wait" functions
>
> This commit introduces new "enable and wait" functions to the regulator c=
ore,
> allowing consumers to ensure a minimum amount of time has passed since a
> regulator was actually turned on. It adds a last_on timestamp to the
> regulator device and updates single and bulk enable APIs to accept a wait=
 time.
>
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 1797929dfe566..d14ce86d8f7bb 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
>
> [ ... ]
>
> > @@ -3159,13 +3162,24 @@ static int _regulator_enable(struct regulator *=
regulator)
> >               } else if (ret < 0) {
> >                       rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_=
PTR(ret));
> >                       goto err_consumer_disable;
> > +             } else {
> > +                     /* regulator already enabled somehow, but timesta=
mp might be invalid */
> > +                     if (!rdev->last_on)
> > +                             rdev->last_on =3D ktime_get_boottime();
> >               }
> > -             /* Fallthrough on positive return values - already enable=
d */
> >       }
> >
> >       if (regulator->enable_count =3D=3D 1)
> >               rdev->use_count++;
> >
> > +     if (wait_us) {
> > +             ktime_t end =3D ktime_add_us(rdev->last_on, wait_us);
> > +             s64 remaining =3D ktime_us_delta(end, ktime_get_boottime(=
));
> > +
> > +             if (remaining > 0)
> > +                     fsleep(remaining);
> > +     }
> > +
>
> [Severity: High]
> Does sleeping here while holding the recursive ww_mutex for the regulator=
 and
> its parent supply chain cause concurrency issues?
>
> Since regulator_enable_and_wait() acquires these locks via
> regulator_lock_dependent() before calling _regulator_enable_and_wait(), t=
his
> sleep happens while the locks are held.
>
> In cases like regulator_bulk_enable_and_wait() where async workers are cr=
eated
> to enable regulators in parallel, won't this serialize the wait times for=
 any
> consumers sharing a parent supply, defeating the purpose of the async des=
ign?

I suppose the fsleep() needs to be moved outside the lock region.

So instead of changing _regulator_enable(), make it return the last_on
timestamp, and then act on it in regulator_enable_and_wait() after the
lock is released.

> >       return 0;
> >
> >  err_consumer_disable:
>
> [ ... ]
>
> > diff --git a/include/linux/regulator/consumer.h b/include/linux/regulat=
or/consumer.h
> > index 56fe2693d9b22..a69157c9b5b51 100644
> > --- a/include/linux/regulator/consumer.h
> > +++ b/include/linux/regulator/consumer.h
>
> [ ... ]
>
> > @@ -192,7 +193,7 @@ int devm_regulator_bulk_register_supply_alias(struc=
t device *dev,
> >                                             int num_id);
> >
> >  /* regulator output control and status */
> > -int __must_check regulator_enable(struct regulator *regulator);
> > +int __must_check regulator_enable_and_wait(struct regulator *regulator=
, unsigned int ms);
>
> [Severity: High]
> Could the naming of this parameter cause consumers to inadvertently pass
> millisecond values that get interpreted as microseconds?

Yes I missed this part when I changed the API to use microseconds
instead of milliseconds. Will fix in the next version.


ChenYu

> The prototype here defines the parameter as ms, but the implementation an=
d
> the parameter passed to ktime_add_us() inside _regulator_enable_and_wait(=
)
> treat it strictly as microseconds.
>
> If a driver developer passes 10 expecting a 10-millisecond delay based on=
 this
> header, the core will interpret it as 10 microseconds. Could this lead to
> hardware initialization failures due to premature access to unstable powe=
r
> supplies?
>
> >  int regulator_disable(struct regulator *regulator);
> >  int regulator_force_disable(struct regulator *regulator);
> >  int regulator_is_enabled(struct regulator *regulator);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721075226.23=
47933-1-wenst@chromium.org?part=3D1
