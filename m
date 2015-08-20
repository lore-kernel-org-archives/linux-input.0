From: Gabor Balla <gaborwho@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Fri, 21 Aug 2015 00:24:59 +0200
Message-ID: <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f68.google.com ([209.85.215.68]:34382 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbHTWZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 18:25:01 -0400
Received: by lahi9 with SMTP id i9so2608398lah.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 15:25:00 -0700 (PDT)
In-Reply-To: <20150820213526.GA10980@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Dmitry,

On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
[...]
>> At some point a new PS/2 mode was introduced by Synaptics, called EW=
mode. This
>> can be enabled by setting bit 2 of the mode byte. But previously thi=
s bit was
>> used for 'Disable Gesture', whatever that stands for, and it was reu=
sed for
>> selecting EWmode. Now if plain Wmode is selected, with bit 0 of the =
mode byte,
>> than disable gesture is on by default and bit 2 selects EWmode inste=
ad.
>>
>> Reference:
>> http://www.synaptics.com/sites/default/files/511-000275-01_RevB.pdf
[...]
>> A quick fix follows:
[...]
>
> It looks like the patch "direction" is reverted. Also, the presence o=
f
> extended capabilities is not the indication that gesture mode should =
not
> be used: in relative mode bit 2 disables gesture reporting, in absolu=
te
> mode it enables Extended W-mode.
>
> Does the patch below also work for you?

If I'm not mistaken, the function of bit 2 depends on the state of W mo=
de rather
than absolute vs relative mode. From page 40 of the PDF:

"If the Wmode bit is not set (0), then Gesture is reported and bit 2 re=
fers to
DisGest. (..) When this bit is 1, the Relative mode mouse packet report=
s the
true physical button states, and the Absolute mode packet=E2=80=99s Ges=
ture bit always
reports as zero."

So it still has a meaning in absolute mode, when Wmode is disabled.
I've tried the patch, it works, but I don't believe it's correct.

Sorry for the reversed patch, I'm not really experienced with making pa=
tches.

Regards,
Gabor
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
