Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBE312831
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378758; cv=none; b=HfceAXvL1jQlsQ5R7VK9TqcBz11cSPfc94MXhZ1qolVzMEz2j15zkREQIhPl3lz0D6PoJy89GPGty6cQjXAMuZN9eA4462YMiA99cM3rlJuDaFsTlkYEOuJ1T58XI44R2O+ka/GQ/B1k78/idlWuEuyIUMHLvJ38s7tu48T7V7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378758; c=relaxed/simple;
	bh=OBpSCo7baAqWaHhWm8XkfjR/AVZn34K+aQNHGbC/dYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbtn7BXOVpIN1AY2s8V3ri5GYRPyQHT7GEByGFCDJJW3ASLCLVQVLZ060B93ntqHTOlAWipa1FzzErKq7oMsgzHGp4+wzacXC8zlGBvoaZqakapouIceVIJaS/Jyuo/5CZ0p1AunJdqjYSIzAhIbtsoKWnlrnJDFgbaJBu4BJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzjChMeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzjChMeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A92E1F000E9
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378756;
	bh=B3WNNMGUbyIMycpJl0kckf6qrESHQlesOfk2i2lSlrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CzjChMeR/kAg5E0Ltu82noQuJ77H/8ept9zRz4ZoA1u0AziET6iscuAAhricZG6aF
	 ferBolzA8A6Eyp08S5fpbJ32rzytPeHeC2e9hz/sVRR/O6TmqSGpB52881GM6GscQQ
	 pGujVUt3Y2MeiwMHCqYKOyapWhct8OrkBvoPjPgLwlvJ7O/EY3VEgAIF8kxyKdYFie
	 A2K3R88Tex6/T1oNOVaS1f6Ak8ugoHGelvnHDViewGKfcDuyvOnosNJ4z/084zZKpM
	 A7z2U0k+lB5ZGcbQ4u+hyt5mUNv/Uf4biFLgUAQn1svqxB6KJOOwC4zloIpuOLw1RE
	 iLrejOMB5WYOw==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bab82d75fdso31309095ad.2
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 08:52:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzr5EmR3Qc95S1IWty1MxOLiS62/BZWYUJO0Y09SAWq/lIZOgCB
	cz1YtFvsjpzm0yJbtBDRBiDFa3KLYKJ7S6xGnmTq/6ytY78MoryV0cwsizjVlXld7jZ5rbyO32a
	fIN/Gr9lJNsPz5QH+92+9fCPzSu1E5ge3jH0KEJS6eA==
X-Received: by 2002:a17:903:2391:b0:2bd:2de3:519a with SMTP id
 d9443c01a7336-2bea3091304mr35787765ad.7.1779378755568; Thu, 21 May 2026
 08:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515175253.873796-1-carvsdriver@gmail.com>
 <ag7FhOx4kuT9QpW3@beelink> <CALPvROT0GE24qUOpjZdEd6FiSfMFVWjbwmS=9CiP7NiF+ZQGSA@mail.gmail.com>
In-Reply-To: <CALPvROT0GE24qUOpjZdEd6FiSfMFVWjbwmS=9CiP7NiF+ZQGSA@mail.gmail.com>
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 21 May 2026 17:52:22 +0200
X-Gmail-Original-Message-ID: <CAO-hwJ+HXoqA8+-RO2Uj3udu910oqKAAe1TRzfHcA74t7_YnWw@mail.gmail.com>
X-Gm-Features: AVHnY4INilpCCypRK8cJZ1KnAPSO4iG0gKlvj38Ojh9EgyNQnxsU5JFECBGJ83E
Message-ID: <CAO-hwJ+HXoqA8+-RO2Uj3udu910oqKAAe1TRzfHcA74t7_YnWw@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Fix stale MT slots when contact count
 drops to zero
To: Dave Carey <carvsdriver@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:03=E2=80=AFPM Dave Carey <carvsdriver@gmail.com> =
wrote:
>
> Benjamin - would you like me to make that update and test?  I don't see a=
n immediate problem with it otherwise.

Yes, please test and send as a v2.

Cheers,
Benjamin

>
> On Thu, May 21, 2026 at 9:17=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
>>
>> On May 15 2026, Dave Carey wrote:
>> > The INGENIC 17EF:6161 touchscreen (Lenovo Yoga Book 9 14IAH10) reports
>> > HID_DG_CONTACTCOUNT=3D0 in the frame immediately following the last fi=
nger
>> > lift rather than omitting the frame entirely.  In mt_touch_report() th=
e
>> > existing code only updates num_expected when contact_count is non-zero=
,
>> > so a zero contact count on the first packet of a new frame leaves
>> > num_expected at its previous value (e.g. 2 for a two-finger gesture).
>> > The sync check "num_received >=3D num_expected" then evaluates "0 >=3D=
 2"
>> > and never fires, preventing INPUT_MT_DROP_UNUSED from releasing the
>> > stale slots.  Those slots remain active in the kernel MT layer until t=
he
>> > next touch, at which point they are released in a batch alongside the
>> > new contact =E2=80=94 causing the userspace event consumer to miss the=
 intervening
>> > finger-up sequence and corrupt its gesture session state.
>> >
>> > Fix by resetting num_expected to 0 when contact_count is zero and
>> > num_received is still 0 (i.e., this is the first and only packet of th=
e
>> > frame, not a continuation packet in a multi-packet sequence).  With
>> > num_expected=3D0 the sync check "0 >=3D 0" fires immediately, calling
>> > input_mt_sync_frame() which drops the stale slots via INPUT_MT_DROP_UN=
USED.
>> >
>> > The num_received=3D=3D0 guard is critical: continuation packets in a
>> > multi-packet frame arrive after at least one contact has already been
>> > processed (num_received>0), so they are correctly excluded from this
>> > path and the existing multi-packet logic is unaffected.
>>
>> I've just tested the change, and the testsuite seem to still be happy
>> and I can't find a flaw in the design.
>> However: (inlined comment)
>>
>> >
>> > Signed-off-by: Dave Carey <carvsdriver@gmail.com>
>> > Tested-by: Dave Carey <carvsdriver@gmail.com>
>> > ---
>> > This follows commit 108ac841 ("HID: multitouch: Fix Yoga Book 9 14IAH1=
0
>> > touchscreen misclassification"), applied to hid/for-next on 2026-05-12=
.
>> > That commit established MT_CLS_YOGABOOK9I.
>> >
>> > This fix is independent of the companion ghost-contacts patch ("HID:
>> > multitouch: Honor ContactCount for Yoga Book 9 to suppress ghost conta=
cts",
>> > sent 2026-05-14), which adds MT_QUIRK_CONTACT_CNT_ACCURATE to the same
>> > class.  Both apply cleanly on top of 108ac841.
>> >
>> > Tested on Lenovo Yoga Book 9 14IAH10 (83KJ).
>> >
>> >  drivers/hid/hid-multitouch.c | 12 ++++++++++++
>> >  1 file changed, 12 insertions(+)
>> >
>> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch=
.c
>> > index ec04dba..e91ba89 100644
>> > --- a/drivers/hid/hid-multitouch.c
>> > +++ b/drivers/hid/hid-multitouch.c
>> > @@ -1336,6 +1336,18 @@ static void mt_touch_report(struct hid_device *=
hid,
>> >               /* A non 0 contact count always indicates a first packet=
 */
>> >               else if (contact_count)
>> >                       app->num_expected =3D contact_count;
>> > +             /*
>> > +              * contact_count =3D=3D 0 on the first packet of a new f=
rame means
>> > +              * all contacts have lifted (the firmware sends an expli=
cit zero
>> > +              * to signal all-up rather than simply omitting the fram=
e).
>> > +              * Reset num_expected so that the sync check below fires=
 and
>> > +              * INPUT_MT_DROP_UNUSED releases any stale slots.  This =
is safe
>> > +              * for multi-packet continuation frames because those ar=
rive with
>> > +              * num_received > 0 (at least one contact was already pr=
ocessed
>> > +              * from the preceding first-packet in the same frame).
>> > +              */
>> > +             else if (app->num_received =3D=3D 0)
>> > +                     app->num_expected =3D 0;
>>
>> this succession of if/else if makes the code harder to understand,
>> especially with long blocks of comments.
>>
>> How about this instead (wouldn't mind a second pair of eyes):
>>
>>         /*
>>          * Includes multi-packet support where subsequent
>>          * packets are sent with zero contactcount.
>>          */
>>         if (contact_count > 0)
>>                 app->num_expected =3D contact_count;
>>         else if (!contact_count && app->num_received =3D=3D 0 &&  app->p=
rev_scantime !=3D scantime) {
>>                 /*
>>                  * New multi-report frame:
>>                  *
>>                  * For Win8 PTPs the first packet (td->num_received =3D=
=3D 0) may
>>                  * have a contactcount of 0 if there only is a button ev=
ent.
>>                  *
>>                  * Some other devices use a sentinel frame with 0 to rel=
ease all contacts
>>                  */
>>                 app->num_expected =3D 0;
>>         }
>>
>> At least the test-suite is happy with this change.
>>
>> Cheers,
>> Benjamin
>>
>> >       }
>> >       app->prev_scantime =3D scantime;
>> >
>> > --
>> > 2.54.0
>> >
>> >
