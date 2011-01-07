From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 03/10] hid-multitouch: support for PixCir-based panels
Date: Fri, 7 Jan 2011 18:31:17 +0100
Message-ID: <AANLkTik1qZwrbOFO3cDB6YqnmF+-3BsGCUa3u1s5fRu2@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294248468-19979-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110106172528.GD1790@polaris.bitmath.org>
	<AANLkTimhk80b+jkqsNrxmFzSgmHX=_wdzbwE09NoFgV1@mail.gmail.com>
	<20110107122338.GB2312@polaris.bitmath.org>
	<AANLkTimYaZcvLyijtEm-iu+PzNXdozcNbFJQ6+PzD4vK@mail.gmail.com>
	<20110107155714.GA506@polaris.bitmath.org>
	<AANLkTimZ-VuvY8fEuPz7gzWVFvLHaJHG34gvkOuMMq2O@mail.gmail.com>
	<20110107172707.GA6095@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110107172707.GA6095@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 7, 2011 at 6:27 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
>> > But the mt_input_mapped function did not change - needs to change =
too.
>>
>> I can not see any differences between mt_input_mapped and those foun=
d
>> in 3m and egalax. Can you point me exactly what I should add please?
>
> My bad - it seems your tree does contain the right function. Another
> reason to have the patches in mail. :-)
>
>> >> - The Egalax problem: I am pretty sure that St=E9phane took this =
driver
>> >> into account when writing the original patch. BTW I propose to
>> >> postpone the problem for 2.6.39.
>> >
>> > This driver is aiming at engulfing a larger set of drivers, and as
>> > such, should be prepared sensibly, IMO. Rushing things will only c=
ause
>> > us grief further down the road.
>> >
>>
>> So, have you got any clue (or even better, can you test a solution)
>> for those devices?
>
> Yes I can, but I will not be available the coming couple of days, so
> the timing is a bit off. I agree with you that we do not need to solv=
e
> every issue right now, but I know for a fact that the newer DWAV
> firmware has no touch frame indication, and does not assume the
> not-seen-means-up behavior. Perhaps it is enough to just add the
> quirks field to the class, define one or two quirks currently in use,
> and leave the rest for later. Sounds reasonable?
>

Sounds reasonable

Cheers,
Benjamin
