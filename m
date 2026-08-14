Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6219D074
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740525; cv=pass; b=EUejnNmCTPWP9PQ01BrHp0fZmKPn0ivdGiiJvcY5gls4MBc3t8rW7JApwFg3+FRfQu68nPlcjHeyT7Lx/KxrstzB0gJQUh2+xI0lneVm+4Mq7ursRn05rRn0nHRCpQ/0KZKfl69tYTbu7THLg5wJndBrBYL6NrXueyCLkBh17AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740525; c=relaxed/simple;
	bh=IQVDiuamIEAiwDrYVYhYCZJ20EbS6U1tmJb2VZA1TLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pioTQR8yfN50JUqIe7GrMPl0x+a8M3SvlvwvtrDLBLQ5A0ebx8yFz/mP/BupRZ907H9rQJer3LmGXs0w3/HcJ+xzXy2N8iEF5+7ZXCfNMkq2fmb3Esf1YS8pILVqHPRXi2CXIq9F9Dc5WI/3u8Khd1Ezp7mcN6dC7PnDYHZ91Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKs8Y8+A; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKs8Y8+A"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so15512431cf.0
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 13:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786740522; cv=none;
        d=google.com; s=arc-20260327;
        b=qO3SqT8Z8aZHrW8rb+LKE3vSRfVzP4FCxlYHIAOJ5lCA6ppcRp5ImtVRf51zcqwOeE
         F/FiSYG/1cfRkEdUqO18ileDADIk/OKDtQ5daJRIPhiDxkckmiQtn6D4TpJQ7l8n+3Da
         PYbXjk1WMqOvfZG5ucBo1pl1bAWn41UzoVzCWSXe0oJ8gc22/a5Pxjsr1tf/BaznT8ll
         gI+YEHlzfFnk3dhQ6oLtr0iqBHGnLMZhkS1231bU0CQRnI2rl+PolGvDCfBgTGvtrhvz
         +wFLB7d/ZZeUphtSL+NVb6nrw8qcHfGJSiuUkL2M5KwT483jalCyXUVMGVz+3CV48ff5
         EDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMzgsn/CYFdHwvZbvqAJ/++E5Upm8WCGjV6QHlbcG+4=;
        fh=w0AH+SG3wIduxcDYbD4ds1hdkggCKsXBd653bdKrfVs=;
        b=ducfUD1Q7uSwoyCSx6DJhwOLiipEgh95x3fVihtpKSqhs7mUXMrrNATi64nke5ODKl
         G01FDqJp2qOo4nUaiuGXbyEVgx+0pfylVmHXjSTpTTppffbeTeWtKp2ro6NrYvW4HyQL
         uGrskS1sm31GirgEn4IyD+kmi5gZPzgtHvBihG7MlIECaUzbFZ0r28QiqFtZcyZt04As
         zONDOOENAhvuVedgOuOidc4Dc9BgTKDYgcYhQ/AK6fgMc8dJOMgKxH+m2eQJq2tDHh/Q
         NcrQ4X9puxbBmEK4QPaFIBKyaFL+PPQt3bKXesXV0a8N8lYGrsqfOjr/mf3jxZzvZZcZ
         oAFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740522; x=1787345322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rMzgsn/CYFdHwvZbvqAJ/++E5Upm8WCGjV6QHlbcG+4=;
        b=QKs8Y8+A+x53435fSauaqco0rGRz/dWkRK23++AZympNUayCM8shraI1NwLfH2UvRp
         R6Tepx5QVwjMugUHqnQNmvEAMLMBxahelltlXLkDSqmjMld5LAHv2h9Rvu4VW2pelK0Z
         mZM5zBgCNxa9Bdmp74LJb+MIIeL0q6c9Srzrn9rBceCixms18ba3EkXol6GgjSeYjxEm
         RI/LFy2UEJXaL4TvqiMBrW9vZz1kkQVFzQzQ3rDPcyRXnfrsjPlyDvbFsKABSkdKq6rM
         3/BtrxcIQoAys0eOUaOtYauLAItr8f4qK/RVSDDEWEKuzCb1+kuim2Z1u6CnQOi93509
         mpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740522; x=1787345322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMzgsn/CYFdHwvZbvqAJ/++E5Upm8WCGjV6QHlbcG+4=;
        b=ZuM86pAXZvnjXe8zBS3abMHZOK25MSqKQpb2XBdB9Qu5P1+PiGzL7vo5Sz070kJSwv
         Ol/zmJgLiAgWXqpUYW0Ji0wfOkdAL9PzwcDcqjA1RjkO1qVkxlB6HGhcJ3GU/TFGQJ0p
         P4vdfZW9hv1v8LSubnm2mBZ42xckx6QfIDj0toKmKNe/fMcolSlLLGoks+EMIyK1K+LA
         2xgje5QbKrAshpKnDZpO+qq8ac3ZLGurgx5IJAqlNax3bgh0ZHPCwGMuJBRKpJLKWdEt
         62CNOUC7y1Fu6pFab6LE2ZuOL4TVaswUwTNMgNWn2ioyQeDWdWZzIpnWzgR2RZht+BHh
         Bwvg==
X-Forwarded-Encrypted: i=1; AHgh+Rowl3Frox5EfxYMqEYS8ia4uDKyH8Y+K10c481Ycau1TWe4f8fpJswsSfMGLUeSkBu05shr5iFH29wBKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEM7hIn4pl41HcNaXDNRkvr1OrjbtcbHlieGcM6rWN/i2Mo2si
	Jy7YMmUf9K3MDUr/4cw9V5aEHqKEl8ZK93BKPM6M5C5XkKAZnfINk2Xn53uEcajxPzX/Zr23LSF
	8af4AJ/PH5NvRYYvuNa6YQ47T/1tjh1U=
X-Gm-Gg: AR+sD13Jqp8wJUQ3QhhJuRdz7yyZXY+qhnI+19yJCDboaaXYahOz6mu/JuucSNNqf0G
	jOnRasZd0cdbxcrjZ6IiWczBgVKQrh+At+XZlM3sL5AAe/fU9TFGNJ2Eq+WlT52EdO5iv4nOP04
	VTlolAbrZR7y1f4Xiq7kGGRkPVfHzXNZZ4zPedoZDzTIFMuIdDo2PKG7gz+NcBNtmoiDbpZxOwo
	jygP9TIDNvPuQEAcLfo9Rdr7Nh091u9lXLevzJTMvcSrdzyRBBoV+oLiWADoS1as8lLjq54WNUc
	veym+biQ9Pq9VcUu2KhmLUyhQBOxXKtJ1wjtTpU3xIaI
X-Received: by 2002:a05:622a:250a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d74baa1femr206518031cf.22.1786740522041; Fri, 14 Aug 2026
 13:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804103209.1496683-1-lee@kernel.org> <20260810105633.GS2869284@google.com>
 <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>
 <anx-28l7cr141aA3@beelink> <20260813094703.GY1072730@google.com>
In-Reply-To: <20260813094703.GY1072730@google.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 14 Aug 2026 13:48:29 -0700
X-Gm-Features: AcwNN1VabRl3EVwtKC66AdzUxQm9rI1BJYS-Etn15_UoLM4y7Xe9Wan5qFO0j-g
Message-ID: <CANRwn3TfnzYbNizPL65GbZUVnhgaRbWM924UKwKF+Q2qhHQb2g@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
To: Lee Jones <lee@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not terribly familiar with EPROBE_DEFER so I would have to defer
to Benjamin's expertise on which approach is more appropriate. It
seems like "Option A" would likely be the more appropriate approach.

As for the challenge of detecting siblings, that is indeed somewhat
tricky. Thinking about this more deeply, your existing evaluation of
`wacom->usbdev->actconfig->desc.bNumInterfaces > 1` does not actually
catch some types of sibling (for example: sometimes the touch device
is its own independent USB device with a PID different from the
pen/pad device). We have a `wacom_are_sibling` function that can be
used to check if two devices are siblings or not, and you could
probably draw inspiration from `wacom_get_hdev_data` for how to write
a function that would "find" siblings, if they exist...

Hopefully that helps?

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


On Thu, Aug 13, 2026 at 2:47=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 12 Aug 2026, Benjamin Tissoires wrote:
>
> > On Aug 11 2026, Jason Gerecke wrote:
> > > On Mon, Aug 10, 2026 at 3:57=E2=80=AFAM Lee Jones <lee@kernel.org> wr=
ote:
> > > >
> > > > Jason,
> > > >
> > > > Can you confirm that you've seen this new version please?
> > > >
> > > > [intentional top-post]
> > > >
> > > >
> > > > On Tue, 04 Aug 2026, Lee Jones wrote:
> > > >
> > > > > Input subsystem guidelines require that device capabilities are a=
dvertised
> > > > > before the input device is registered.  The Wacom driver was viol=
ating
> > > > > this by advertising the SW_MUTE_DEVICE capability post-registrati=
on in
> > > > > wacom_set_shared_values() (and duplicating it in device-specific =
setup
> > > > > cases).
> > > > >
> > > > > Resolve this by moving the SW_MUTE_DEVICE capability setup to
> > > > > wacom_setup_touch_input_capabilities() for all touch devices that=
 support
> > > > > it, including composite USB generic touch devices.
> > > > >
> > > > > Additionally, replace the lookup-dependent
> > > > > 'wacom_wac->shared->touch->product' references with 'hdev->produc=
t'
> > > > > inside wacom_setup_touch_input_capabilities() as 'hdev' is alread=
y
> > > > > available and represents the touch device itself.
> > > > >
> > > > > Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch =
switch")
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >
> > > > > v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason=
's request
> > > > > v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic tou=
ch devices
> > > > > v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic =
touch devices
> > > > >
> > > > >  drivers/hid/wacom_sys.c | 23 +++++++++++++++++------
> > > > >  drivers/hid/wacom_wac.c | 19 +++++++++++--------
> > > > >  2 files changed, 28 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > > > index 0eafa483b7f7..92b73ed0028f 100644
> > > > > --- a/drivers/hid/wacom_sys.c
> > > > > +++ b/drivers/hid/wacom_sys.c
> > > > > @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct=
 wacom_wac *wacom_wac)
> > > > >                       wacom_wac->shared->is_touch_on =3D true;
> > > > >       }
> > > > >
> > > > > -     if (wacom_wac->shared->has_mute_touch_switch &&
> > > > > -         wacom_wac->shared->touch_input) {
> > > > > -             set_bit(EV_SW, wacom_wac->shared->touch_input->evbi=
t);
> > > > > -             input_set_capability(wacom_wac->shared->touch_input=
, EV_SW,
> > > > > -                                  SW_MUTE_DEVICE);
> > > > > -     }
> > > > >  }
> > > > >
> > > > >  static int wacom_parse_and_register(struct wacom *wacom, bool wi=
reless)
> > > > > @@ -2414,6 +2408,23 @@ static int wacom_parse_and_register(struct=
 wacom *wacom, bool wireless)
> > > > >       wacom_retrieve_hid_descriptor(hdev, features);
> > > > >       wacom_setup_device_quirks(wacom);
> > > > >
> > > > > +     if (features->type =3D=3D HID_GENERIC &&
> > > > > +         (features->device_type & WACOM_DEVICETYPE_TOUCH)) {
> > > > > +             if (wacom->usbdev && wacom->usbdev->actconfig &&
> > > > > +                 wacom->usbdev->actconfig->desc.bNumInterfaces >=
 1) {
> > > > > +                     /*
> > > > > +                      * Heuristic: Composite USB devices (like t=
ablets with
> > > > > +                      * pen/pad + touch) likely have a touch mut=
e switch.
> > > > > +                      * We flag it here to advertise the capabil=
ity before
> > > > > +                      * registration. We also set is_soft_touch_=
switch to
> > > > > +                      * default touch to ON in case there is no =
physical
> > > > > +                      * switch.
> > > > > +                      */
> > > > > +                     wacom_wac->has_mute_touch_switch =3D true;
> > > > > +                     wacom_wac->is_soft_touch_switch =3D true;
> > > > > +             }
> > > > > +     }
> > > > > +
> > >
> > > Apologies for the delay, Lee.
> > >
> > > [ Begin ramble ]
> > >
> > > This probably isn't a half-bad heuristic. I'm a bit hesitant to sign
> > > off on it, mostly because I don't like the idea of the driver
> > > advertising the existence of non-existent hardware.
> > >
> > > My understanding is that it is theoretically allowable to change
> > > capabilities post-registration (assuming we take due care to spinlock
> > > relevant structures). The problem with doing so, however, is that if
> > > userland queries the capabilities before we make the change, that it
> > > will be stuck with an incorrect set. Software could theoretically
> > > re-issue EVIOCGBIT ioctls at a later point in time to refresh
> > > capabilities, but if we're honest that doesn't actually happen.
> > >
> > > It feels like we're in a situation where we either:
> > >
> > > A. Over-declare device capabilities on some devices (mostly older one=
s
> > > that didn't have a touch switch)
> > >
> > > -- or --
> > >
> > > B. Have devices with under-declared capabilities if userland opens
> > > them fast enough
> >
> > or C: do not put random heuristic and lie to userspace.
> >
> > The problem comes from the fact that the driver knows after the fact
> > that a button comes from a different HID node and is redirected in its
> > own input device.
> >
> > So: either enforce that the pad device is registered first
> > (-EPROBE_DEFER), or defer the registering of the touch input node when
> > both have been parsed/analyzed.
> >
> > But anyway, we should not call input_register on the touch while we
> > haven't parsed the pad. period.
> >
> > Having such a heuristic on a USB composite device feels like shooting
> > ourselves in the foot.
>
> Thanks for the input Benjamin.
>
> I let Gemini have a good go at comparing these options.  Below is the
> summary.  Please have a quick look and let me know if it sounds
> reasonable to you.
>
> Since this bug is important to me, for 'reasons', and I have already put
> hours of work into this, I would like to gain consensus from both of you
> before pouring yet more time into it.
>
> Please could you prioritise this - time is of the essence.  Thanks.
>
> <gemini>
>
>   ### 1. Understanding the Maintainer's Objection
>
>   The maintainer (Benjamin Tissoires) strongly objects to the heuristic
>   introduced in v7/v8 (checking if it's a composite USB device to
>   guess the presence of a mute switch).
>
>   =E2=80=A2 The Issue: The heuristic is "lying to userspace" because it m=
ight
>     advertise the SW_MUTE_DEVICE capability on devices that do not
>     actually have a physical or soft touch switch.
>   =E2=80=A2 The Rule: Input devices must not be registered
>     (input_register_device()) until their capabilities are 100% known.
>     We must not register the touch device before the pad device has been
>     parsed, because the touch device's capabilities depend on what we
>     find in the pad's report descriptors.
>
>   This is a hard gate for getting the patch merged upstream. The
>   heuristic approach will be rejected.
>
>   ### 2. Assessment of Proposed Solutions
>
>   The maintainer suggests two paths to ensure we don't register touch
>   before parsing pad:
>
>   #### Option A: Enforce Probe Order via EPROBE_DEFER
>
>   If the touch interface probes first, it should return -EPROBE_DEFER
>   and wait until the pad/pen interface has probed, parsed its
>   descriptors, and set the shared capabilities (like
>   has_mute_touch_switch).
>
>   =E2=80=A2 Pros:
>       =E2=80=A2 Standard kernel mechanism for dependency management.
>       =E2=80=A2 Clean device lifecycle: once probe() succeeds, the device=
 is
>         fully registered and ready.
>   =E2=80=A2 Cons/Challenges:
>       =E2=80=A2 Detecting Siblings in HID_GENERIC: For generic devices, w=
e don't
>         have a static database (like wacom_features) telling us what
>         interfaces to expect.
>       =E2=80=A2 Risk of Infinite Deferral: If touch-only devices return
>         -EPROBE_DEFER waiting for a pen/pad interface that doesn't
>         exist, they will never finish probing.
>       =E2=80=A2 Resolution: We would need to inspect the parent USB devic=
e
>         descriptors during touch probe to see if a sibling HID interface
>         (which would be the pen/pad) exists. If it exists but hasn't
>         registered in the shared list yet, we defer. If it doesn't exist
>         (touch-only device), we proceed immediately.
>
>   #### Option B: Deferred Input Registration
>
>   Allow both interfaces to probe successfully, but do not call
>   input_register_device() for the touch device immediately if the pad
>   hasn't been parsed yet. Instead, store the unregistered input_dev
>   pointer in the shared structure, and have the pad interface register
>   it later once it finishes parsing.
>
>   =E2=80=A2 Pros:
>       =E2=80=A2 Avoids messing with probe deferrals and driver core bindi=
ng
>         logic.
>   =E2=80=A2 Cons/Challenges:
>       =E2=80=A2 Complex Lifecycle: We have a "half-probed" state where th=
e
>         driver probe succeeded but the input device doesn't exist yet.
>       =E2=80=A2 Cross-Interface Registration: The pad interface driver wo=
uld
>         become responsible for registering the touch interface's input
>         device. This breaks separation of concerns and complicates error
>         handling (what if registration fails during pad probe?).
>       =E2=80=A2 Sync Logic: We would need complex synchronization to hand=
le
>         cases where one interface is unbound/removed while registration
>         is    pending.
>
>   ### Conclusion & Recommendation
>
>   The EPROBE_DEFER (Option A) approach is the cleaner and more standard
>   way to handle this in the Linux kernel, despite the challenge of
>   detecting sibling interfaces for generic devices.
>
>   If we proceed with refactoring, we should investigate how to reliably
>   inspect the USB parent configuration in wacom_probe to detect if we
>   should expect a sibling interface, and defer touch probe if that
>   sibling has not yet joined the wacom_udev_list.
>
> </gemini>
>
> > > The touch switch capability lets userland know to expect switch event=
s
> > > and to potentially offer some kind of software display of its state.
> > > Its presence or absence is not critical since the switch state can
> > > often be observed in other ways (physical hardware switch location) o=
r
> > > toggled back into a disabled state even if not immediately observable=
.
> > > It's probably marginally better to err on providing state information
> > > in situations where controls don't actually exist, but not by much.
> > >
> > > [ End ramble ]
> > >
> > > With all of that out of the way, I guess that I've convinced myself
> > > that this is probably acceptable.
> > >
> > > The only remaining nitpick I can identify looking at this again is
> > > that the hunks that replace 'wacom_wac->shared->touch->product' with
> > > 'hdev->product' should really be in their own standalone cleanup patc=
h
> > > rather than in this (slightly-) behavior modifying one.
> > >
> > > Address that one nitpick and I'll send out my reviewed-by for the two
> > > new patches. Apologies again for my many delays... This should be the
> > > last one :)
> > >
> > > Jason (she/they)
> > > ---
> > > Now instead of four in the eights place /
> > > you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> > > (That is to say, eight) to the two,     /
> > > But you can=E2=80=99t take seven from three,    /
> > > So you look at the sixty-fours....
> > >
> > > > >       if (features->device_type =3D=3D WACOM_DEVICETYPE_NONE &&
> > > > >           features->type !=3D WIRELESS) {
> > > > >               error =3D features->type =3D=3D HID_GENERIC ? -ENOD=
EV : 0;
> > > > > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > > > > index a29bf051ada7..afc82fcbb20b 100644
> > > > > --- a/drivers/hid/wacom_wac.c
> > > > > +++ b/drivers/hid/wacom_wac.c
> > > > > @@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(stru=
ct input_dev *input_dev,
> > > > >  int wacom_setup_touch_input_capabilities(struct input_dev *input=
_dev,
> > > > >                                        struct wacom_wac *wacom_wa=
c)
> > > > >  {
> > > > > +     struct wacom *wacom =3D container_of(wacom_wac, struct waco=
m, wacom_wac);
> > > > > +     struct hid_device *hdev =3D wacom->hdev;
> > > > >       struct wacom_features *features =3D &wacom_wac->features;
> > > > >
> > > > >       if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > > > > @@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(s=
truct input_dev *input_dev,
> > > > >       else
> > > > >               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> > > > >
> > > > > -     if (features->type =3D=3D HID_GENERIC)
> > > > > +     if (features->type =3D=3D HID_GENERIC) {
> > > > > +             if (wacom_wac->has_mute_touch_switch)
> > > > > +                     input_set_capability(input_dev, EV_SW, SW_M=
UTE_DEVICE);
> > > > >               /* setup has already been done */
> > > > >               return 0;
> > > > > +     }
> > > > >
> > > > >       input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS=
);
> > > > >       __set_bit(BTN_TOUCH, input_dev->keybit);
> > > > > @@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(=
struct input_dev *input_dev,
> > > > >               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> > > > >               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> > > > >
> > > > > -             if (wacom_wac->shared->touch->product =3D=3D 0x361)=
 {
> > > > > +             if (hdev->product =3D=3D 0x361) {
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_X,
> > > > >                                            0, 12440, 4, 0);
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_Y,
> > > > >                                            0, 8640, 4, 0);
> > > > > -             }
> > > > > -             else if (wacom_wac->shared->touch->product =3D=3D 0=
x360) {
> > > > > +             } else if (hdev->product =3D=3D 0x360) {
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_X,
> > > > >                                            0, 8960, 4, 0);
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_Y,
> > > > >                                            0, 5920, 4, 0);
> > > > > -             }
> > > > > -             else if (wacom_wac->shared->touch->product =3D=3D 0=
x393) {
> > > > > +             } else if (hdev->product =3D=3D 0x393) {
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_X,
> > > > >                                            0, 6400, 4, 0);
> > > > >                       input_set_abs_params(input_dev, ABS_MT_POSI=
TION_Y,
> > > > > @@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(st=
ruct input_dev *input_dev,
> > > > >               fallthrough;
> > > > >
> > > > >       case WACOM_27QHDT:
> > > > > -             if (wacom_wac->shared->touch->product =3D=3D 0x32C =
||
> > > > > -                 wacom_wac->shared->touch->product =3D=3D 0xF6) =
{
> > > > > +             if (hdev->product =3D=3D 0x32C ||
> > > > > +                 hdev->product =3D=3D 0xF6) {
> > > > >                       input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> > > > >                       __set_bit(SW_MUTE_DEVICE, input_dev->swbit)=
;
> > > > >                       wacom_wac->has_mute_touch_switch =3D true;
> > > > > --
> > > > > 2.55.0.571.g244d577d93-goog
> > > > >
> > > >
> > > > --
> > > > Lee Jones
> > > >
> > >
>
> --
> Lee Jones
