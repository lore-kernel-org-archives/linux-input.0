Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC92DEA9B
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235094; cv=pass; b=Mtt2PrtWk+p+vkLHrW1Y4ug4NZj8mKC+BTBW65dCgU81WT2ndONUW0fxitzFr/Ep0jExcl6OlrXhacKQYiPiNy3hvx7JhzWY8OS0AbPwEiHNXl026wTP/0n+I0YMqwVhk8JVEuRLzxURbgeU8V1Ua5x4mA5YlEKTpCG430NXH1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235094; c=relaxed/simple;
	bh=7JeDPZdtothaH94Kzfg7oviNdyb8W0GR/1sF2ozE9eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggr+2Ipyv5trQxRCx4wjoV+TaHmza39YVLWE9RirtMyMpGaKvLf1PxzWF+u/L1ZEl0UBftPvxskbnznb7591bGlR9/qctPrTKqaQYkAW3j3IJd8BYmXvtI0onV5MBxuCB/PK5GTTpX4mUrb/WNjP7XOewHF+EixBUZGP4W8FOt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPPDrJyE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE38L6GV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPPDrJyE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE38L6GV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775235091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqj4LwEwfM7pWgM1Q4Q6R78upwIUlqTyktAU9tN/8x0=;
	b=aPPDrJyELRi/WVFswzJxjEJWXXjWOUvBJ++VuaBGoCf3q/1LLc1nGI+k4T/8RUuyWmYPJ+
	ayZ+xZyBWxr9ZEVV2ypdf5VwrCkCA60PHYzdUY/JX5WPpIwcKl7/gOXWQ7IfS2DObOy46v
	keTiz2YXFjicGU73PjBpobykbVbKlS8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-9mJ4iB_8ORS5CAJDJ6EFdQ-1; Fri, 03 Apr 2026 12:51:30 -0400
X-MC-Unique: 9mJ4iB_8ORS5CAJDJ6EFdQ-1
X-Mimecast-MFC-AGG-ID: 9mJ4iB_8ORS5CAJDJ6EFdQ_1775235089
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8704795d25so191213266b.2
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 09:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775235089; cv=none;
        d=google.com; s=arc-20240605;
        b=BDlB25oMfQJrjrh1+7vnLmoR+vjDMIbh8/xXfm62bpgwLVwWGRjQc6luXOuxG3TnfP
         bnCdqqMNQTO8GsoNw/7CX6VJIpwO/WaWGqFnewZuDWAMtJFa7aGXoh2WRraBCPuYjhRu
         DV59AKcxw1eivNBLeC0qAGp+tmnwv6Dg+f3ezARKhVrrk6p8R5uFsa67bnW3E/Sw71Z/
         ICZAAFEB74VADSsMJDvYGFt5XcEzdz1Q91GdJhoBcGeJFyFMlL3GLCsrb1XCzHr0YMFO
         UF46qLjTx06zVtj77ODMic4lX5T8VK3uGcubI57U5SQWjKhHjUVV5pxkHYLJe+rL1Uor
         rbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqj4LwEwfM7pWgM1Q4Q6R78upwIUlqTyktAU9tN/8x0=;
        fh=m2TbS/KFyUgsmCEhoZFkc/ZYf7Rjgh8FIevfwRgUzGU=;
        b=EXFjzrN7BZkuMpOXT5Tbv3zykFUMY0AwnIo9ioSvfzWVdcGr7KrbMHWZs6NVVraCfX
         Zz5KTEckYzLj3OhhUrBdyYf6rRQd6xbp01rxZplDmKxngyjTB8cSme32DqQ/QYOHr8rd
         fLaPostGq2T7tZvcPJKJY21VqWd/EmFXWoUPO/QfngFT6a3AhAeW4kVFwjsgiyzwf+1m
         vERGol+4i82OIfU/mVVL6aH4YdCAByzDX20g9aChyfNNnaVXRDonH0i4iZsJkptOZ1Dp
         kt61iiPo6ilE21vR/nzb8Jp3SS9IutCCek6cdmPbt58gV7TP6BvXB+TWlb8jW8Z4whu4
         EvbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775235089; x=1775839889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqj4LwEwfM7pWgM1Q4Q6R78upwIUlqTyktAU9tN/8x0=;
        b=JE38L6GVYbDngd5XHpbZYlPMI8skCg0RtU3X1belRX+9Y6j0nkznZYL9XYX0nH51lZ
         zvoQqtiDMDxM+4TGJmrU7qKlMPZxrc5v4qk2ScAnfZuVcZvfQ3QNDHzOtZ4zFGCMabGl
         P/iq9NeuqvQHzwtDcxHrs3pxrAm1rEndA36IHwxWbtgnDwO/d5oX7HpKwHptNTgORbsB
         6XCb2NNLiwK+Tll9P0aCscHoumJlxljz71yS8F7oCn4YCZWEaaoZXuCWV6ZCgCeBE68R
         6MECSS8Cgq8EZeYb91xrkh5fvuxripZ46i7MbsbIaA8x71PA8wskvuYC+6dMocj1QyL5
         x1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775235089; x=1775839889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqj4LwEwfM7pWgM1Q4Q6R78upwIUlqTyktAU9tN/8x0=;
        b=R60cnldRvdbVbNNA0eh/nNjBFZKAoRVPhsMxp4qvcSl3hFSRVWtS84CGPygEDHvamz
         wmTHPJ+QZ1TKmjW9sgwbWaFLeXFXvTaUGY1/Ery3doH1r9u2pLTlfrfZZB4/dZd6nNzA
         9cbpsdyFqekXjuLoEDiovYMVqZb3glb76KNOQDymLvRY3k1/a5QC2jypE+R4QnEXnoCB
         59P7Wgn/PbOJ8xxYo1Czvkb5xzhRSJTjG7tjCOfuSuprDv20B5fQO9zCgyeW1kma+rWc
         BEmdJaOk+F++1nMNO9wPvD+y2QMd1Xnnj9RGWhOi+SY7f95/gjeO85MdnZ+SEcl52Xcr
         F1xg==
X-Forwarded-Encrypted: i=1; AJvYcCXHElJ7hY9kC8b1SgxMjASbs2Kg9KPe3KE2J7us6VWiy25B7v74W9sWAbTr2jyh7hGHUAH2c4vtEyBvvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMTiceSPTfP7NHUxUL7y4kLr1lTeOMFnkIaoUO5vun8A4gFzO
	trScvIVi0sLTuBCOTFY6ScMXRb6qKH4iGYIWmdG25AjgNAoB05dFZkHBSjytOtY7I2LFa1kK7N5
	+MjlKzHSknqQhSpALPhPKaQmUWLz0bBYNnirF7mF3TNgcbc1Xii1oUabM5BXHRqoPF2CCxo8aWT
	8ur8MQVPVgUd2EycWvYAOL1B+kQUxOVc9ktWY9u5Sx98Npm2Y=
X-Gm-Gg: AeBDieuva4nSIbp6nFHmZuKzKmGSI10Zv99Oe+y9rUWDSp/gT1Km7kvzkhAb4IR4/hV
	kyAYlzeKdFxqT+Eb4jbN5Z47fZVQA92mwg3XUrzvnqyZ6EwonYkRguPgmSdnXs2StKbK9cbLgB1
	YuZom1R8Bz6RK6q9JHfP7dbjexi4rGLHR5VDDCvDxbIxaYLxUQ4TQcM8QOk5xPJCpPu8hkjjsBy
	Ic=
X-Received: by 2002:a17:907:1b0e:b0:b98:32c1:2496 with SMTP id a640c23a62f3a-b9c6743226amr179816266b.18.1775235088465;
        Fri, 03 Apr 2026 09:51:28 -0700 (PDT)
X-Received: by 2002:a17:907:1b0e:b0:b98:32c1:2496 with SMTP id
 a640c23a62f3a-b9c6743226amr179814666b.18.1775235087827; Fri, 03 Apr 2026
 09:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402182937.388847-1-carvsdriver@gmail.com>
 <ac-419v9pBcZhuKA@beelink> <CALPvROSB4y0UsPvF5-ZS=_rGmj1NgM6QvBAbHO13bkgpAwQSyA@mail.gmail.com>
In-Reply-To: <CALPvROSB4y0UsPvF5-ZS=_rGmj1NgM6QvBAbHO13bkgpAwQSyA@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 3 Apr 2026 18:51:15 +0200
X-Gm-Features: AQROBzDe3r3KlG4PTGAgnBKtmz-2uHxhfLV9luOsSYgXZDrnxPSjghsvUDgOo8g
Message-ID: <CAO-hwJJfKqz9YSM6soQn2yO1YQeOo8K2xOGfvXgMaqfodzXrWw@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen misclassification
To: Dave Carey <carvsdriver@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

[not sure why your message doesn't appear on lore, so using the
@redhat.com email.]

On Fri, Apr 3, 2026 at 5:17=E2=80=AFPM Dave Carey <carvsdriver@gmail.com> w=
rote:
>
> Benjamin - thanks for the response, I'll admit that I'm not the smartest =
person in the room here.

I wouldn't say that. Given the research you showed in the repo below,
you are definitely smart :)

> My approach was trivially simple, it works in Windows flawlessly so I kne=
w there had to be a way to make it work in Linux.

OK, so that's a hint we are not doing something correctly.

>   I essentially ran USB log captures in Windows, then banged my face agai=
nst the keyboard on the linux side until I could figure out what was going =
on there and implement the same behavior with the firmware.  All of my rese=
arch is in my repo here ...
>
> https://bitbucket.org/carvsdriver/lenovoyoga9ibook/src/main/README_Touch.=
md

Could you add a hid-recorder output when doing a simple touch on one
of the 2 panels? (pip3 install hid-tools).

I'm curious to understand the touchpad emulation part. As I read it,
does the device emit the event on both the touchscreen and the
emulated one simultaneously?

I guess you don't happen to have a compatible stylus? It would be
interesting to look at the events from a pen to understand the button
logic.

>
> Happy to get your input and take a swing at implementing this differently=
.

It looks like there are multiple problems with the touchscreens, and I
need the big picture. The nice thing is you already wrote a HID-BPF
program for it, so why not contribute it upstream to udev-hid-bpf.
I'll eventually push it into the kernel as well and that would help
people who did not updated their kernel yet.

Cheers,
Benjamin

>
> -Dave
>
> On Fri, Apr 3, 2026 at 9:03=E2=80=AFAM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
>>
>> Hi Dave,
>>
>> On Apr 02 2026, Dave Carey wrote:
>> > The Lenovo Yoga Book 9 14IAH10 (83KJ) uses a composite USB HID device
>> > (17EF:6161) where three descriptor quirks combine to cause hid-multito=
uch
>> > to incorrectly set INPUT_PROP_BUTTONPAD on both touchscreen nodes, mak=
ing
>> > libinput treat them as indirect clickpads rather than direct touchscre=
ens.
>> >
>> > Quirk 1: The HID_DG_TOUCHSCREEN application collection contains
>> > HID_UP_BUTTON usages (stylus barrel buttons). The generic heuristic in
>> > mt_touch_input_mapping() treats any touchscreen-with-buttons as a
>> > touchpad, setting INPUT_MT_POINTER.
>> >
>> > Quirk 2: A HID_DG_TOUCHPAD collection ("Emulated Touchpad") sets
>> > INPUT_MT_POINTER unconditionally in mt_allocate_application().
>> >
>> > Quirk 3: The HID_DG_BUTTONTYPE feature report (0x51) returns
>> > MT_BUTTONTYPE_CLICKPAD, directly setting td->is_buttonpad =3D true.
>> >
>> > These combine to produce INPUT_PROP_BUTTONPAD on the touchscreen input
>> > nodes. libinput treats the devices as indirect clickpads and suppresse=
s
>> > direct touch events, leaving the touchscreens non-functional under
>> > KDE/Wayland.
>>
>> This looks like a completely borked report descriptor. Out of curiosity,
>> do you know if there is a specific Windows driver for it or if it's
>> using the plain generic driver there.
>>
>> The reasoning is that if it's using the generic win driver, we are
>> probably doing something wrong, and we need to fix it in a more generic
>> way.
>>
>> >
>> > Additionally, the firmware resets if any USB control request is receiv=
ed
>> > during the CDC ACM initialization window. The existing GET_REPORT call
>> > in mt_check_input_mode() during probe triggers this reset.
>>
>> Ouch, even better :(
>>
>> >
>> > Fix by extending MT_QUIRK_YOGABOOK9I (already defined for the earlier
>> > Yoga Book 9i) to guard all three BUTTONPAD heuristics and skip the
>> > HID_DG_BUTTONTYPE GET_REPORT during probe for this device.
>>
>> Really not a big fan of the approach taken here: We are sprinkling the
>> code with special quirks for one particular device and that makes
>> everything worse.
>>
>> I would much prefer a report descriptor fixup where:
>> - we drop the HID_UP_BUTTON
>> - we drop the HID_DG_TOUCHPAD collection entirely
>> - we drop the HID_DG_BUTTONTYPE feature entirely
>> - we drop the Win8 blob feature as well to prevent queries during
>>   initialization.
>>
>> For ease of development I would recomend working with a separate HID-BPF
>> program instead of a in-kernel fix, but we already have a .report_fixup
>> here, so I wouldn't mind having the fix here as well.
>>
>> Cheers,
>> Benjamin
>>
>> >
>> > Signed-off-by: Dave Carey <carvsdriver@gmail.com>
>> > Tested-by: Dave Carey <carvsdriver@gmail.com>
>> > ---
>> >  drivers/hid/hid-multitouch.c | 34 +++++++++++++++++++++++++++-------
>> >  1 file changed, 27 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch=
.c
>> > index e82a3c4e5..1bef32b1d 100644
>> > --- a/drivers/hid/hid-multitouch.c
>> > +++ b/drivers/hid/hid-multitouch.c
>> > @@ -549,7 +549,14 @@ static void mt_feature_mapping(struct hid_device =
*hdev,
>> >
>> >       switch (usage->hid) {
>> >       case HID_DG_CONTACTMAX:
>> > -             mt_get_feature(hdev, field->report);
>> > +             /*
>> > +              * Yoga Book 9: skip GET_REPORT during probe; the firmwa=
re
>> > +              * resets if it receives any control request before the =
init
>> > +              * Output report is sent (within ~1.18s of USB enumerati=
on).
>> > +              * Logical maximum from the descriptor is used as the fa=
llback.
>> > +              */
>> > +             if (!(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
>> > +                     mt_get_feature(hdev, field->report);
>> >
>> >               td->maxcontacts =3D field->value[0];
>> >               if (!td->maxcontacts &&
>> > @@ -566,6 +573,10 @@ static void mt_feature_mapping(struct hid_device =
*hdev,
>> >                       break;
>> >               }
>> >
>> > +             /* Yoga Book 9 reports Clickpad but is a direct touchscr=
een */
>> > +             if (td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)
>> > +                     break;
>> > +
>> >               mt_get_feature(hdev, field->report);
>> >               switch (field->value[usage->usage_index]) {
>> >               case MT_BUTTONTYPE_CLICKPAD:
>> > @@ -579,7 +590,9 @@ static void mt_feature_mapping(struct hid_device *=
hdev,
>> >               break;
>> >       case 0xff0000c5:
>> >               /* Retrieve the Win8 blob once to enable some devices */
>> > -             if (usage->usage_index =3D=3D 0)
>> > +             /* Yoga Book 9: skip; firmware resets before init if que=
ried */
>> > +             if (usage->usage_index =3D=3D 0 &&
>> > +                 !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
>> >                       mt_get_feature(hdev, field->report);
>> >               break;
>> >       }
>> > @@ -644,8 +657,11 @@ static struct mt_application *mt_allocate_applica=
tion(struct mt_device *td,
>> >
>> >       /*
>> >        * Model touchscreens providing buttons as touchpads.
>> > +      * Yoga Book 9 has an emulated touchpad but its touch surfaces
>> > +      * are direct screens, not indirect pointers.
>> >        */
>> > -     if (application =3D=3D HID_DG_TOUCHPAD) {
>> > +     if (application =3D=3D HID_DG_TOUCHPAD &&
>> > +         !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)) {
>> >               mt_application->mt_flags |=3D INPUT_MT_POINTER;
>> >               td->inputmode_value =3D MT_INPUTMODE_TOUCHPAD;
>> >       }
>> > @@ -802,11 +818,15 @@ static int mt_touch_input_mapping(struct hid_dev=
ice *hdev, struct hid_input *hi,
>> >
>> >       /*
>> >        * Model touchscreens providing buttons as touchpads.
>> > +      * Skip for Yoga Book 9 which has stylus buttons inside
>> > +      * touchscreen collections, not physical touchpad buttons.
>> >        */
>> >       if (field->application =3D=3D HID_DG_TOUCHSCREEN &&
>> >           (usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON) {
>> > -             app->mt_flags |=3D INPUT_MT_POINTER;
>> > -             td->inputmode_value =3D MT_INPUTMODE_TOUCHPAD;
>> > +             if (!(app->quirks & MT_QUIRK_YOGABOOK9I)) {
>> > +                     app->mt_flags |=3D INPUT_MT_POINTER;
>> > +                     td->inputmode_value =3D MT_INPUTMODE_TOUCHPAD;
>> > +             }
>> >       }
>> >
>> >       /* count the buttons on touchpads */
>> > @@ -1420,7 +1440,6 @@ static int mt_touch_input_configured(struct hid_=
device *hdev,
>> >        */
>> >       if (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR)
>> >               app->mt_flags |=3D INPUT_MT_DIRECT;
>> > -
>> >       if (cls->is_indirect)
>> >               app->mt_flags |=3D INPUT_MT_POINTER;
>> >
>> > @@ -1432,7 +1451,8 @@ static int mt_touch_input_configured(struct hid_=
device *hdev,
>> >
>> >       /* check for clickpads */
>> >       if ((app->mt_flags & INPUT_MT_POINTER) &&
>> > -         (app->buttons_count =3D=3D 1))
>> > +         (app->buttons_count =3D=3D 1) &&
>> > +         !(app->quirks & MT_QUIRK_YOGABOOK9I))
>> >               td->is_buttonpad =3D true;
>> >
>> >       if (td->is_buttonpad)
>> > --
>> > 2.53.0
>> >
>> >

