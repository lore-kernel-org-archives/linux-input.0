From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 03/10] hid-multitouch: support for PixCir-based panels
Date: Fri, 7 Jan 2011 18:07:53 +0100
Message-ID: <AANLkTimZ-VuvY8fEuPz7gzWVFvLHaJHG34gvkOuMMq2O@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294248468-19979-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110106172528.GD1790@polaris.bitmath.org>
	<AANLkTimhk80b+jkqsNrxmFzSgmHX=_wdzbwE09NoFgV1@mail.gmail.com>
	<20110107122338.GB2312@polaris.bitmath.org>
	<AANLkTimYaZcvLyijtEm-iu+PzNXdozcNbFJQ6+PzD4vK@mail.gmail.com>
	<20110107155714.GA506@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56515 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab1AGRH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 12:07:56 -0500
In-Reply-To: <20110107155714.GA506@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 4:57 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Fri, Jan 07, 2011 at 04:12:24PM +0100, Benjamin Tissoires wrote:
>> Hi Henrik,
>>
>> I've made the changes and I pushed them on the git of our lab. I
>> thought it was easier for you to have a look at the changes instead =
of
>> resending the whole patch. But v3 will be for this afternoon.
>
> Well, it is not really easier, since there is no easy way to comment
> on the code. Also, transparency is lost. Please let the review proces=
s
> take its time.
>
>>
>> the repo is at:
>> http://lii-enac.fr/cgi-bin/gitweb.cgi?p=3Dlinux-input/enac-drivers.g=
it;a=3Dsummary
>> the changes are on the branch "hid-multitouch-dtor" from "Copyright
>> notice" to the head ("hid-input: better way of handling
>> HID_FEATURE_REPORT").
>>
>> To summarize:
>>
>> - I used touch_state and seen_in_this_frame -> I hope the semantic i=
s
>> now clearer. I was able to test it on stantum and cypress device. I
>> should do the test for pixcir as soon as I can have some time in the
>> afternoon, and the test against generaltouch should happend in the
>> beginning of the week.
>
> The code looks clearer, but there are still two more or less identica=
l
> structures in there. Please remove, it just looks silly.

In not a big fan of this idea, but we have to find a compromise -> will=
 do.

>
>> - I integrated fuzz (please check)
>
> But the mt_input_mapped function did not change - needs to change too=
=2E

I can not see any differences between mt_input_mapped and those found
in 3m and egalax. Can you point me exactly what I should add please?

>
>> - I re-factorized set_abs (just copied-pasted your code)
>
> Ok.
>
>> - I made other small changes
>>
>> - Concerning the quirks, I am not very in favor ATM: a flag for
>> compute slot will infer a switch of 5 cases in the emit_event, and t=
he
>> idea was to be able to have a constant time access (1) when using
>> specific function.
>> The Quirk MT_QUIRK_NOT_SEEN_MEANS_UP is better (it will speed up a
>> little the code: 1 test against 1 test and 1 affectation) but I don'=
t
>> think it worse the effort for further device additions.
>
> Given everything that happens within a hid packet, this really, reall=
y
> does not matter much. And the quirks can be implemented efficiently
> too, if really needed.

Will do.

>
>> - The Egalax problem: I am pretty sure that St=E9phane took this dri=
ver
>> into account when writing the original patch. BTW I propose to
>> postpone the problem for 2.6.39.
>
> This driver is aiming at engulfing a larger set of drivers, and as
> such, should be prepared sensibly, IMO. Rushing things will only caus=
e
> us grief further down the road.
>

So, have you got any clue (or even better, can you test a solution)
for those devices?

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
