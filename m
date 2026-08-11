Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06243E08A
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483006; cv=pass; b=Z96IAtYd3DTsh8ZP8ME9XsnLaT+252nwOZTj10L10pcFcGuaz1dKbDB75Suy1nUv5m4xmr/EmVl22gBxXQikcdcBG9ukxyefHbPlTf+CLUJVTRGr+Uubrgy3AIfKxPZ96VkJE5cgCOvUWXzGr8ZONLmnMB54ZvPEuyLrU3yCht0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483006; c=relaxed/simple;
	bh=5WNjdkJqHDzzYo8Gbhw8FDuSUKBboQsak0T9rXZsWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJbYxfsjqG9iezSg1hVZ6jO66qWnt9TzP1NnDHu93S8V6zrnsv6BKf3M59y5+GFCpJKlLJ14jsJzFXajM8eu5uwcF5EKZYl/yakrNo7y3YDchlrHl8MESjt060BXBA3CcEM6qAbzJ4RJ5j5/DhsvHfAdCeKdTt5oErHnBtrxLsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQYXR9p+; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQYXR9p+"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e50979c71so39934285a.3
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 14:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786482998; cv=none;
        d=google.com; s=arc-20260327;
        b=YmVPr/eddS4YX+KgJo3/+mflFB+JGQvijQhUei0gdeez7nPExTeNpndrwYXtj6VmnN
         /n88adI4lK8ujk/zWU38IMxEY+1VRZ6YtWrTZcxUPy60Zkz7Wi9kcWoNjCzFDFyAQl+3
         zWJluaasxJIReIFpM8cYg2hLXTLyDEWonrZJYNByF/saRwArYJdWcKAZBNF22uM1W6pC
         htNutTMRQXOosXXr55PCdHhRvTsesgn6Y3iJtPJZG6nfYAkQf5OJTAPIQrwbeZg0r0BB
         p/Q+GdDPjhW5Xan8FcrJxVvJGIg1GS5VhC23MwZuoFaidJOsdgqjfTNIxVJBRwZ/Jop+
         YHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjm5osEUTm14Dg4BTQr4QlbtK+/wdLK1ampWzfc1iA=;
        fh=m3uBQOZXvXqafWCvF3YDT4XSFbFO8OGvjTBsAEZu/U0=;
        b=LRtwS7Qw7vNxpc09Om44uyJ8iCMzu0zojLnRxHZxypkmD5svkUxWXYSmSqW2HLoUHA
         MCCWPwYEQ9Z0OT/J1Xn1+kaC8q5n4Xh4uQFz7hBWZS7xiJwokUVigA9mST6yBszMjjoN
         X1PdRhjnNda8p5QMdKgGOl7SchJ1KedVmguc+TPax0ZT6JN3bex4FA+sKlsJjbXh+YdZ
         9fMRG2J/9QJM1SP7x/frf7qZinx5tYcJXzysmQJv0HiW3WzRcJ5HRA+2Hk7zANs/SfDN
         Mw/zRbdsHtgMWV2NLzcWdiiZYzLH6Kci0t3CfYLDn56RDwLgHeGrrXYahXNkxy3zHR/M
         xyJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786482998; x=1787087798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjm5osEUTm14Dg4BTQr4QlbtK+/wdLK1ampWzfc1iA=;
        b=bQYXR9p+Cbj8hfe6R06Hhrvi/kDdTWrQF1++9j/mVJIn//yGt093ZRbECUKZWhWyEZ
         GJEkhWr/DRptX4BStG+Tv+TTiyyPDJdC2BCUu1LdOH9qRnsotM5IfF41t5eMbVgIYk5U
         4yl8jb2ic5rIffnCNDdsX3Gfi+I+IQqqCZVlh7BJ2+OJs5/Mu4cuOA1jkACPx8ds2ZBI
         JrZsV7pSHttEb8umupuP9ecMJcaY/4ld4zSi+t0Tm7Bkpiug/kgTiCJ5ZBEZjWRB/cr/
         jDzcu1ksXSOW2PbvqIPDlWgXrnvMgHL0IgLzKz33wa+t8IFGDNNU/aYerFupBnmiaytA
         m/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482998; x=1787087798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjm5osEUTm14Dg4BTQr4QlbtK+/wdLK1ampWzfc1iA=;
        b=jniCWr14n6Jy2984lYZMUq2PvNdBd27yibO0zRE5GsDOp4lZksqgQ+7bkltzKnrubx
         XO5Gb+xfYAa+BzL9CvBCizJyR0Ygm+9eLxq3wEZ5XSy1pqUrhAabay2PY8luYCYLWJ/K
         JJt+3QYIPu5fEdJe4Z5YuDgBKF1hDIWPakcuPZ2hXoN6MeB0oD2eOmj1UMUgUiZu+v7P
         skSLFFLPVZd5upFL06FoSCmYkeItxquK9dysNJ0mI65tFubb9XmCynQ8L8+jJKcXs9jA
         tYVfYvLiBG3LPl4NhYT2xSmaiPm9FNNHy7+z7E4FIz/nwnpQf7UqcUXEFiFyv4ldb1+K
         quWw==
X-Forwarded-Encrypted: i=1; AHgh+Rprn2wlw0PbS2wsvxbx0+WXw0+L4EkuSsWSZnKEdgBZFI1biDVoR7XPwISnVlmM/r0Ijh3K4fRN07pbgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qHlk+l6CG1ySdQlnNzPb+rI1R4R54vk6DbMi+MX9863p1Tmt
	F9AxTuCDPmJkQQuH8DvR9mwI4xqDACveb9Vhhxa1yvUU/A0WMKr5uHJLz+XHwZoH40HHY1NEopD
	WPNG3oIUTiuL07Le3UX0h8AaW6xnx2vFm1QO0
X-Gm-Gg: AR+sD12BQAlUHBOrhMnJwio8a48dys595ZwCfRWy1cdo5GR6xhbDdVGk9XDsLv7zbNx
	iCOOQsBX0kTyalPRn/h6VSig13dQbsk3dzusIzHbcmf6uBYajckhnWe9b/R6ktl/8mm7VxQx4so
	K1MX+yOuB8+RF7px4M9gJZcqtUOPqD/C/Sjaaqg0bB5TYnXD2GMuUN3OJhN85C2jtx9byTz9J9v
	jHWGvXrEFPUXKvZiNGZVGHMj19VLnp6nbJp4fAI+OCIoZ+EU9TDhBjb93Sm1nk1NBuDTgXb3PrI
	HqY+JI0fL1FfbT7gBo2IxwDyjszJOBDQGOCbkJqSfi3g
X-Received: by 2002:a05:620a:2806:b0:92e:675e:8ede with SMTP id
 af79cd13be357-936b3abc728mr36048685a.13.1786482998200; Tue, 11 Aug 2026
 14:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804103209.1496683-1-lee@kernel.org> <20260810105633.GS2869284@google.com>
In-Reply-To: <20260810105633.GS2869284@google.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 11 Aug 2026 14:16:27 -0700
X-Gm-Features: AUfX_mxNL6gcrTGrLr8Sg1eT0tI5mQYm6T8z0Sgvyet0DJ_Pj6pHVru9EJEmFms
Message-ID: <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:57=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Jason,
>
> Can you confirm that you've seen this new version please?
>
> [intentional top-post]
>
>
> On Tue, 04 Aug 2026, Lee Jones wrote:
>
> > Input subsystem guidelines require that device capabilities are adverti=
sed
> > before the input device is registered.  The Wacom driver was violating
> > this by advertising the SW_MUTE_DEVICE capability post-registration in
> > wacom_set_shared_values() (and duplicating it in device-specific setup
> > cases).
> >
> > Resolve this by moving the SW_MUTE_DEVICE capability setup to
> > wacom_setup_touch_input_capabilities() for all touch devices that suppo=
rt
> > it, including composite USB generic touch devices.
> >
> > Additionally, replace the lookup-dependent
> > 'wacom_wac->shared->touch->product' references with 'hdev->product'
> > inside wacom_setup_touch_input_capabilities() as 'hdev' is already
> > available and represents the touch device itself.
> >
> > Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch=
")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >
> > v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's req=
uest
> > v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch dev=
ices
> > v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch =
devices
> >
> >  drivers/hid/wacom_sys.c | 23 +++++++++++++++++------
> >  drivers/hid/wacom_wac.c | 19 +++++++++++--------
> >  2 files changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 0eafa483b7f7..92b73ed0028f 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom=
_wac *wacom_wac)
> >                       wacom_wac->shared->is_touch_on =3D true;
> >       }
> >
> > -     if (wacom_wac->shared->has_mute_touch_switch &&
> > -         wacom_wac->shared->touch_input) {
> > -             set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> > -             input_set_capability(wacom_wac->shared->touch_input, EV_S=
W,
> > -                                  SW_MUTE_DEVICE);
> > -     }
> >  }
> >
> >  static int wacom_parse_and_register(struct wacom *wacom, bool wireless=
)
> > @@ -2414,6 +2408,23 @@ static int wacom_parse_and_register(struct wacom=
 *wacom, bool wireless)
> >       wacom_retrieve_hid_descriptor(hdev, features);
> >       wacom_setup_device_quirks(wacom);
> >
> > +     if (features->type =3D=3D HID_GENERIC &&
> > +         (features->device_type & WACOM_DEVICETYPE_TOUCH)) {
> > +             if (wacom->usbdev && wacom->usbdev->actconfig &&
> > +                 wacom->usbdev->actconfig->desc.bNumInterfaces > 1) {
> > +                     /*
> > +                      * Heuristic: Composite USB devices (like tablets=
 with
> > +                      * pen/pad + touch) likely have a touch mute swit=
ch.
> > +                      * We flag it here to advertise the capability be=
fore
> > +                      * registration. We also set is_soft_touch_switch=
 to
> > +                      * default touch to ON in case there is no physic=
al
> > +                      * switch.
> > +                      */
> > +                     wacom_wac->has_mute_touch_switch =3D true;
> > +                     wacom_wac->is_soft_touch_switch =3D true;
> > +             }
> > +     }
> > +

Apologies for the delay, Lee.

[ Begin ramble ]

This probably isn't a half-bad heuristic. I'm a bit hesitant to sign
off on it, mostly because I don't like the idea of the driver
advertising the existence of non-existent hardware.

My understanding is that it is theoretically allowable to change
capabilities post-registration (assuming we take due care to spinlock
relevant structures). The problem with doing so, however, is that if
userland queries the capabilities before we make the change, that it
will be stuck with an incorrect set. Software could theoretically
re-issue EVIOCGBIT ioctls at a later point in time to refresh
capabilities, but if we're honest that doesn't actually happen.

It feels like we're in a situation where we either:

A. Over-declare device capabilities on some devices (mostly older ones
that didn't have a touch switch)

-- or --

B. Have devices with under-declared capabilities if userland opens
them fast enough

The touch switch capability lets userland know to expect switch events
and to potentially offer some kind of software display of its state.
Its presence or absence is not critical since the switch state can
often be observed in other ways (physical hardware switch location) or
toggled back into a disabled state even if not immediately observable.
It's probably marginally better to err on providing state information
in situations where controls don't actually exist, but not by much.

[ End ramble ]

With all of that out of the way, I guess that I've convinced myself
that this is probably acceptable.

The only remaining nitpick I can identify looking at this again is
that the hunks that replace 'wacom_wac->shared->touch->product' with
'hdev->product' should really be in their own standalone cleanup patch
rather than in this (slightly-) behavior modifying one.

Address that one nitpick and I'll send out my reviewed-by for the two
new patches. Apologies again for my many delays... This should be the
last one :)

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> >       if (features->device_type =3D=3D WACOM_DEVICETYPE_NONE &&
> >           features->type !=3D WIRELESS) {
> >               error =3D features->type =3D=3D HID_GENERIC ? -ENODEV : 0=
;
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index a29bf051ada7..afc82fcbb20b 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
> >  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >                                        struct wacom_wac *wacom_wac)
> >  {
> > +     struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wac=
om_wac);
> > +     struct hid_device *hdev =3D wacom->hdev;
> >       struct wacom_features *features =3D &wacom_wac->features;
> >
> >       if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > @@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(struct =
input_dev *input_dev,
> >       else
> >               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >
> > -     if (features->type =3D=3D HID_GENERIC)
> > +     if (features->type =3D=3D HID_GENERIC) {
> > +             if (wacom_wac->has_mute_touch_switch)
> > +                     input_set_capability(input_dev, EV_SW, SW_MUTE_DE=
VICE);
> >               /* setup has already been done */
> >               return 0;
> > +     }
> >
> >       input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> >       __set_bit(BTN_TOUCH, input_dev->keybit);
> > @@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct=
 input_dev *input_dev,
> >               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> >               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >
> > -             if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> > +             if (hdev->product =3D=3D 0x361) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 12440, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> >                                            0, 8640, 4, 0);
> > -             }
> > -             else if (wacom_wac->shared->touch->product =3D=3D 0x360) =
{
> > +             } else if (hdev->product =3D=3D 0x360) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 8960, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> >                                            0, 5920, 4, 0);
> > -             }
> > -             else if (wacom_wac->shared->touch->product =3D=3D 0x393) =
{
> > +             } else if (hdev->product =3D=3D 0x393) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 6400, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> > @@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct i=
nput_dev *input_dev,
> >               fallthrough;
> >
> >       case WACOM_27QHDT:
> > -             if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> > -                 wacom_wac->shared->touch->product =3D=3D 0xF6) {
> > +             if (hdev->product =3D=3D 0x32C ||
> > +                 hdev->product =3D=3D 0xF6) {
> >                       input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> >                       __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >                       wacom_wac->has_mute_touch_switch =3D true;
> > --
> > 2.55.0.571.g244d577d93-goog
> >
>
> --
> Lee Jones
>
