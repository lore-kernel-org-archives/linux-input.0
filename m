Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B370374A16;
	Wed, 12 Aug 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544282; cv=none; b=AOCYPYrAG7UdZqa1k5/w9fADPH90xfQMXAsKVE4lyjo0cqzSQrwBM5Q42DHD/B1HtNiScIClckK+5hspU+YObXWSvAXJK8VbibnYSduv08JFoyU8hndg5R7PZBEWfev8LkkTXN+QkSDE9dksazdMdUcsZdlBkBIIsnHbk5gzt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544282; c=relaxed/simple;
	bh=wsF/fZeEji5Bu2QGfuvQedVsbxm+J/V29zMyxS8537w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOdLmrhk0waVgGleh10bj1X2HwNKcZXu5mHbUIpzR6XkSioB2iW472dkgBzUn6le0oKmZV8y7eDTdRrQZIr4BJHHlc3e/B8l37xcxDEI5OBl7RPEnRJrfitW1uBs1s8IL9UrafpK+qBXsQNJtNdoky+6rV58d2V1DIXB0ArXrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Puwky8wa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puwky8wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD81F000E9;
	Wed, 12 Aug 2026 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544280;
	bh=pGLPYlvXPXqogKwk9yVJAveVOSsbe7Ug/jtyA9j/1X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Puwky8wah+wNGuOxcErsxHDPPXv4L1+uUyDbpbNf4idAUMxtMXL4QOqsUnVI8Khs8
	 lhB+IyUaLObSjITMKHkb//amwGOUlCTvydXkiL4h63VbKM515htX+XzOoku7PLKM6F
	 qnGLswbua2bp/BUBQ6GYgKp4NXNcMq6J75Zmcy014miYZ7m8X0UOJO5/RgPwiD9Sha
	 Y9o4mB917jnIzDm0oYCYVSri1qxOFXGoIm54ZVDT7nDeDmRulKk6XtKx6ctEUqgOry
	 uQ1WXzEQ+iytqfsuPvrygl0WbuMabH4IdsGvsG/cD8JOTo9z8fxNaPJqPgsJ/NA1qx
	 c5HH7so7pq/Aw==
Date: Wed, 12 Aug 2026 16:17:56 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <anx-28l7cr141aA3@beelink>
References: <20260804103209.1496683-1-lee@kernel.org>
 <20260810105633.GS2869284@google.com>
 <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>

On Aug 11 2026, Jason Gerecke wrote:
> On Mon, Aug 10, 2026 at 3:57 AM Lee Jones <lee@kernel.org> wrote:
> >
> > Jason,
> >
> > Can you confirm that you've seen this new version please?
> >
> > [intentional top-post]
> >
> >
> > On Tue, 04 Aug 2026, Lee Jones wrote:
> >
> > > Input subsystem guidelines require that device capabilities are advertised
> > > before the input device is registered.  The Wacom driver was violating
> > > this by advertising the SW_MUTE_DEVICE capability post-registration in
> > > wacom_set_shared_values() (and duplicating it in device-specific setup
> > > cases).
> > >
> > > Resolve this by moving the SW_MUTE_DEVICE capability setup to
> > > wacom_setup_touch_input_capabilities() for all touch devices that support
> > > it, including composite USB generic touch devices.
> > >
> > > Additionally, replace the lookup-dependent
> > > 'wacom_wac->shared->touch->product' references with 'hdev->product'
> > > inside wacom_setup_touch_input_capabilities() as 'hdev' is already
> > > available and represents the touch device itself.
> > >
> > > Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >
> > > v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
> > > v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
> > > v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch devices
> > >
> > >  drivers/hid/wacom_sys.c | 23 +++++++++++++++++------
> > >  drivers/hid/wacom_wac.c | 19 +++++++++++--------
> > >  2 files changed, 28 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 0eafa483b7f7..92b73ed0028f 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
> > >                       wacom_wac->shared->is_touch_on = true;
> > >       }
> > >
> > > -     if (wacom_wac->shared->has_mute_touch_switch &&
> > > -         wacom_wac->shared->touch_input) {
> > > -             set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> > > -             input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> > > -                                  SW_MUTE_DEVICE);
> > > -     }
> > >  }
> > >
> > >  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> > > @@ -2414,6 +2408,23 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> > >       wacom_retrieve_hid_descriptor(hdev, features);
> > >       wacom_setup_device_quirks(wacom);
> > >
> > > +     if (features->type == HID_GENERIC &&
> > > +         (features->device_type & WACOM_DEVICETYPE_TOUCH)) {
> > > +             if (wacom->usbdev && wacom->usbdev->actconfig &&
> > > +                 wacom->usbdev->actconfig->desc.bNumInterfaces > 1) {
> > > +                     /*
> > > +                      * Heuristic: Composite USB devices (like tablets with
> > > +                      * pen/pad + touch) likely have a touch mute switch.
> > > +                      * We flag it here to advertise the capability before
> > > +                      * registration. We also set is_soft_touch_switch to
> > > +                      * default touch to ON in case there is no physical
> > > +                      * switch.
> > > +                      */
> > > +                     wacom_wac->has_mute_touch_switch = true;
> > > +                     wacom_wac->is_soft_touch_switch = true;
> > > +             }
> > > +     }
> > > +
> 
> Apologies for the delay, Lee.
> 
> [ Begin ramble ]
> 
> This probably isn't a half-bad heuristic. I'm a bit hesitant to sign
> off on it, mostly because I don't like the idea of the driver
> advertising the existence of non-existent hardware.
> 
> My understanding is that it is theoretically allowable to change
> capabilities post-registration (assuming we take due care to spinlock
> relevant structures). The problem with doing so, however, is that if
> userland queries the capabilities before we make the change, that it
> will be stuck with an incorrect set. Software could theoretically
> re-issue EVIOCGBIT ioctls at a later point in time to refresh
> capabilities, but if we're honest that doesn't actually happen.
> 
> It feels like we're in a situation where we either:
> 
> A. Over-declare device capabilities on some devices (mostly older ones
> that didn't have a touch switch)
> 
> -- or --
> 
> B. Have devices with under-declared capabilities if userland opens
> them fast enough

or C: do not put random heuristic and lie to userspace.

The problem comes from the fact that the driver knows after the fact
that a button comes from a different HID node and is redirected in its
own input device.

So: either enforce that the pad device is registered first
(-EPROBE_DEFER), or defer the registering of the touch input node when
both have been parsed/analyzed.

But anyway, we should not call input_register on the touch while we
haven't parsed the pad. period.

Having such a heuristic on a USB composite device feels like shooting
ourselves in the foot.

Cheers,
Benjamin

> 
> The touch switch capability lets userland know to expect switch events
> and to potentially offer some kind of software display of its state.
> Its presence or absence is not critical since the switch state can
> often be observed in other ways (physical hardware switch location) or
> toggled back into a disabled state even if not immediately observable.
> It's probably marginally better to err on providing state information
> in situations where controls don't actually exist, but not by much.
> 
> [ End ramble ]
> 
> With all of that out of the way, I guess that I've convinced myself
> that this is probably acceptable.
> 
> The only remaining nitpick I can identify looking at this again is
> that the hunks that replace 'wacom_wac->shared->touch->product' with
> 'hdev->product' should really be in their own standalone cleanup patch
> rather than in this (slightly-) behavior modifying one.
> 
> Address that one nitpick and I'll send out my reviewed-by for the two
> new patches. Apologies again for my many delays... This should be the
> last one :)
> 
> Jason (she/they)
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
> 
> > >       if (features->device_type == WACOM_DEVICETYPE_NONE &&
> > >           features->type != WIRELESS) {
> > >               error = features->type == HID_GENERIC ? -ENODEV : 0;
> > > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > > index a29bf051ada7..afc82fcbb20b 100644
> > > --- a/drivers/hid/wacom_wac.c
> > > +++ b/drivers/hid/wacom_wac.c
> > > @@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
> > >  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> > >                                        struct wacom_wac *wacom_wac)
> > >  {
> > > +     struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
> > > +     struct hid_device *hdev = wacom->hdev;
> > >       struct wacom_features *features = &wacom_wac->features;
> > >
> > >       if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > > @@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> > >       else
> > >               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> > >
> > > -     if (features->type == HID_GENERIC)
> > > +     if (features->type == HID_GENERIC) {
> > > +             if (wacom_wac->has_mute_touch_switch)
> > > +                     input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
> > >               /* setup has already been done */
> > >               return 0;
> > > +     }
> > >
> > >       input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > >       __set_bit(BTN_TOUCH, input_dev->keybit);
> > > @@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> > >               input_dev->evbit[0] |= BIT_MASK(EV_SW);
> > >               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> > >
> > > -             if (wacom_wac->shared->touch->product == 0x361) {
> > > +             if (hdev->product == 0x361) {
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> > >                                            0, 12440, 4, 0);
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> > >                                            0, 8640, 4, 0);
> > > -             }
> > > -             else if (wacom_wac->shared->touch->product == 0x360) {
> > > +             } else if (hdev->product == 0x360) {
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> > >                                            0, 8960, 4, 0);
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> > >                                            0, 5920, 4, 0);
> > > -             }
> > > -             else if (wacom_wac->shared->touch->product == 0x393) {
> > > +             } else if (hdev->product == 0x393) {
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> > >                                            0, 6400, 4, 0);
> > >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> > > @@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> > >               fallthrough;
> > >
> > >       case WACOM_27QHDT:
> > > -             if (wacom_wac->shared->touch->product == 0x32C ||
> > > -                 wacom_wac->shared->touch->product == 0xF6) {
> > > +             if (hdev->product == 0x32C ||
> > > +                 hdev->product == 0xF6) {
> > >                       input_dev->evbit[0] |= BIT_MASK(EV_SW);
> > >                       __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> > >                       wacom_wac->has_mute_touch_switch = true;
> > > --
> > > 2.55.0.571.g244d577d93-goog
> > >
> >
> > --
> > Lee Jones
> >
> 
