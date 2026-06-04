Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A483AE709
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548200; cv=pass; b=BYoAXPcfHbfwqqBf+5VOOVa4pDkP7cB6UFnUkXKgAtgOJtE492q0aqpI1jNtaMb/rTbpyiidfz/uPLtYoIRI572DPnUF8nnjEpTKO6kNbd46lzjCROgLnEY85yB/xdCbcv7ek9Hyd6XMDC7+YNGXOevqMEcw7TP2XkbPIn+jpX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548200; c=relaxed/simple;
	bh=3RJe6dpSrTJydc+DARNysumViUAgzuKZGzr+hdLqGJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5AzJ4AIzmOJmVWkEqIBRqzHP2iw1lWvgFJR/hzm0OM36ayYqoxUEO3f61JWGCtof/Snea/QZR7A3i7VmDPOmbzU7P0j+OHmO9ol4+f7PI7i14Zw79N8Jk1Lqk4KqnxvUN4RCA1QyfYYLuEc8SxcaJe3fYLp/lmQbVLf8HELW9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7AbE/1z; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7AbE/1z"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf3781ca51so2959445ad.0
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 21:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780548198; cv=none;
        d=google.com; s=arc-20240605;
        b=iVCbEAJ+T0JzJgGE9RjXL4dM0ZKrbCiGyUYvLTeRZdW9FxJpbnd8dWR3XggU97lou4
         ytAHwo0tkFv6j2GgjJlaCxmNcTJ+N0ny+11AAkmniw7hZHCLwCv2mSrzinu5w9/FX2n1
         N2rSJqkAvecaAtldyrg+MxkPxoK5AcBLm3EHPdqurlaXbY2LBM+PFyyYKNhEQmVHpnNM
         yi7UnQvl4tKxr8TWfPq4RW5vTE4oTk5OrqE2OjH3LFgFseUcOEhiqJAZkCaaoRecoczD
         fIB/vd8KsS5utimrKHLe7WFtuiX3FfR1d2vR2vqn/ToMNSMAFKo4BMdOe3d/rY62FCGK
         W/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        fh=PNUCQ/jZySE6c3qxqt/d4Kp18IpgWE1GJQdNjFXiKlo=;
        b=lc/g65Ti9EOAfFSXjf7pq0WAbFugEB34H8qrurO9LBmmbSfZsymu3AzoaBP1m2A7yN
         7yvkpDSQqh7/fIjDcs0rN0cwUWvxnxRLxI3JHRJ8l4X6UzOU3tUnfT6Rytv6OZ7MGcmR
         PeBprWOl/lVbxumhNKy0sUc0LQWVBycYhPfCzWm9M3s66nWSOygTuPzWKu3zOtZ6adqx
         JYY/3Sp5mXwQGJ4Vi38KFEl54rAzSafpdF3HSTfPVB1k3akOtEVC8kUZF3A8msKU6LMq
         fkORd21d7wa1EQQIisGxFSSqk40+NW7JyR5v/7e6yjNW90JEJiD14lbP2xRoxANWHGje
         zlIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780548198; x=1781152998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        b=h7AbE/1zzeaWzU5skp7+nIhxP2T1ptX4xMqBkdqESxMnCtYGKErBmSpabh3svY/Quy
         2yHY+SiyW5P2JrFTa129N/3lTyoh7/yyE50J+4y6dDibL78Y3jmvCB13nM1H6MJKJpKv
         H7BPIgnmUdFIw1Lfyz1TqNqLs8nhGvRKGw2/xknQ1sFaPnloTxdabydUhdBZaGJsTB2N
         l24V1EqCUQqEcAXULd0EyNdxAhnVau0+bxagnPDP4q1kqigllDZJuwq2ah7994eQgeyZ
         cXAP8D6nPIJH1FzDka8Dbo2Xi+I9u/XPJRZh7+JD6EL6q8B0V7lLSCqfpDtwgAztcn4A
         SxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780548198; x=1781152998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        b=lmPY28SeeSuyiXff5Q9XvEskiRhUB9a2F085wBqZo1A+V71u8BWv7BDLPVI87TxWJo
         cPqDxiYh4TzQiv5Ci/99CTQp0cDKy+SxFoyfzOHLEA19DPYaoH/jpXsJl/uSYaYZQW4x
         ujvO7wkI9E+395Cl69/xUzI/U3TGw5XC72/kxZExOHRZOx6c3AkTxuToTg/HWx2uq9rt
         nX7XgnaIK7Lksq+qH6khNd5kCRsA5TSi8Bc3XnB0EF0qUNZ8t+3ztdxyIGHHPr/p9U/U
         jXZMCXf7v4WwvtEdhpeTkDgofZsBgDlqzIm3U1R65EpZsTr3IFyfbL9iV80DjikQUXTQ
         kbLA==
X-Forwarded-Encrypted: i=1; AFNElJ+EIeFU3fozsDdzQLMuhQ4Qt0fo4X5+AcAEB5FzJxq3LT6Cgrb6AErwMnB7wTxxzDTJj88I2UpCxn6sCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywQuMFS5eRZXRRTpLfD1xCLMTVHB+prVpw3ldVV2X1uAfT8YRC
	0j0PUFRvULOuVi+PaL05Bg7atyhKoxJaqM8tnWynSIikVw4pAlZbtew98Mu8vRAaE/mmsWk/huj
	tvwJHTUBxLXG7/4+uYMh5+gJH8V5pEDe+yODGtg==
X-Gm-Gg: Acq92OHUMMBDuQk1uG2AxjLma+r/AU6b8dJWWME2Q9k+LqPboNRHCXq0pKdTHIHzy3e
	0GX9RLQ9VEbTGji+30kvweRzAvk/4szgE0w3I7OzL/70PAfYklIHJlQmuoSImL2AAAtkm5+V2jj
	bIzbLg0e/+JtaBUKRLLlyCvNXjeLzNB5YS0oar9cVFX0H/55WWfqs/M7gKeY97CctiM5vsQ6Cse
	RefZCV8Z4FCqhm1YbfijNBHvkkwXfV/66Gs840zlUBJj4qyNW5O+/tbfZM/5cDKQCyUrja7HjkU
	2T6c5RRT+40ESLlzn4TlAaHrbETr8gqZz6WQGovQXOEKm0SrCVnIq1bA7Zk=
X-Received: by 2002:a17:903:2446:b0:2bf:305a:312a with SMTP id
 d9443c01a7336-2c163fa8208mr68644605ad.22.1780548198268; Wed, 03 Jun 2026
 21:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524175552.1973-1-mhun512@gmail.com> <ahdE9G8I7kd_OoGW@google.com>
 <nr568s88-77o5-p5pn-5r1n-236371989rn0@xreary.bet>
In-Reply-To: <nr568s88-77o5-p5pn-5r1n-236371989rn0@xreary.bet>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 4 Jun 2026 13:43:01 +0900
X-Gm-Features: AVHnY4ITieUM9oAw8Yb2dovzKSILbIbJGByWFFRmd3Q98L5EffP8CtXRVS1zhQ8
Message-ID: <CAGEsz8HDzf62R016fJ9Wn_M+_pmWCT8Rk3OQJm3-MihS0MVqbA@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe failures
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri and Dmitry,

Thank you both for the review. I agree with Dmitry's suggestion to
remove 'fail_quirks' and use 'fail_hw_stop' throughout the probe path.
I will send out v2 with this change shortly.

Best regards,
Myeonghun Pak

2026=EB=85=84 6=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:23, Ji=
ri Kosina <jikos@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, 27 May 2026, Dmitry Torokhov wrote:
>
> > > wacom_parse_and_register() starts HID hardware before registering inp=
uts
> > > and initializing pad LEDs/remotes. Those later steps can fail, but th=
eir
> > > error paths currently release Wacom resources without stopping the HI=
D
> > > hardware.
> > >
> > > Route post-hid_hw_start() failures through hid_hw_stop() before
> > > releasing driver resources.
> > >
> > > This issue was identified during our ongoing static-analysis research=
 while
> > > reviewing kernel code.
> > >
> > > Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until=
 after hid_hw_start")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > > ---
> > >  drivers/hid/wacom_sys.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 0d1c6d90fe..c824d9c224 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wa=
com *wacom, bool wireless)
> > >
> > >     error =3D wacom_register_inputs(wacom);
> > >     if (error)
> > > -           goto fail;
> > > +           goto fail_hw_stop;
> > >
> > >     if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD)=
 {
> > >             error =3D wacom_initialize_leds(wacom);
> > >             if (error)
> > > -                   goto fail;
> > > +                   goto fail_hw_stop;
> > >
> > >             error =3D wacom_initialize_remotes(wacom);
> > >             if (error)
> > > -                   goto fail;
> > > +                   goto fail_hw_stop;
> > >     }
> > >
> > >     if (!wireless) {
> > > @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct waco=
m *wacom, bool wireless)
> > >     return 0;
> > >
> > >  fail_quirks:
> > > +fail_hw_stop:
> > >     hid_hw_stop(hdev);
> > >  fail:
> > >     wacom_release_resources(wacom);
> >
> > I'd get rid of 'fail_quirks' and use 'fail_hw_stop' everywhere,
>
> Agreed. Myeonghun, will you send v2 please?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
