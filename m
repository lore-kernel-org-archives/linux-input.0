From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 16:01:35 -0700
Message-ID: <CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34190 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbHTXBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:01:36 -0400
Received: by oiey141 with SMTP id y141so32087463oie.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:01:35 -0700 (PDT)
In-Reply-To: <20150820225633.GA12900@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Balla <gaborwho@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

On Thu, Aug 20, 2015 at 3:56 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
>> Hi Dmitry,
>>
>> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
>> [...]
>> >> At some point a new PS/2 mode was introduced by Synaptics, called=
 EWmode. This
>> >> can be enabled by setting bit 2 of the mode byte. But previously =
this bit was
>> >> used for 'Disable Gesture', whatever that stands for, and it was =
reused for
>> >> selecting EWmode. Now if plain Wmode is selected, with bit 0 of t=
he mode byte,
>> >> than disable gesture is on by default and bit 2 selects EWmode in=
stead.
>> >>
>> >> Reference:
>> >> http://www.synaptics.com/sites/default/files/511-000275-01_RevB.p=
df
>> [...]
>> >> A quick fix follows:
>> [...]
>> >
>> > It looks like the patch "direction" is reverted. Also, the presenc=
e of
>> > extended capabilities is not the indication that gesture mode shou=
ld not
>> > be used: in relative mode bit 2 disables gesture reporting, in abs=
olute
>> > mode it enables Extended W-mode.
>> >
>> > Does the patch below also work for you?
>>
>> If I'm not mistaken, the function of bit 2 depends on the state of W=
 mode rather
>> than absolute vs relative mode. From page 40 of the PDF:
>>
>> "If the Wmode bit is not set (0), then Gesture is reported and bit 2=
 refers to
>> DisGest. (..) When this bit is 1, the Relative mode mouse packet rep=
orts the
>> true physical button states, and the Absolute mode packet=E2=80=99s =
Gesture bit always
>> reports as zero."
>>
>> So it still has a meaning in absolute mode, when Wmode is disabled.
>> I've tried the patch, it works, but I don't believe it's correct.
>
> Yes, you are right, the bot does have meaning on Absolute mode, howev=
er
> we want to give option to enable gestures only when in relative mode;
> I've adjusted the description accordingly.

Ah, wait, not quite still. So we actually do want to disable gestures
when in Absolute mode (non extended). Although frankly I do not think
we'll ever see pre 4.0 Synaptics device in a wild.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
