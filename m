From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] input: bitmap update for sh_keysc V2
Date: Wed, 10 Feb 2010 20:13:38 +0900
Message-ID: <aec7e5c31002100313k1fd54f29o996a11e3967eaa3a@mail.gmail.com>
References: <20100209091609.1262.66929.sendpatchset@rxone.opensource.se>
	 <20100209093954.GC12642@core.coreip.homeip.net>
	 <aec7e5c31002092013y615cb624x78a9d5fad126b3ec@mail.gmail.com>
	 <20100210092650.GA28229@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:51845 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab0BJLNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 06:13:44 -0500
In-Reply-To: <20100210092650.GA28229@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wed, Feb 10, 2010 at 6:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Feb 10, 2010 at 01:13:37PM +0900, Magnus Damm wrote:
>> On Tue, Feb 9, 2010 at 6:39 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, Feb 09, 2010 at 06:16:09PM +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Update the sh_keysc driver with proper bitmap support V2.
>> >> This instead of using a fixed 32-bit integer to keep track
>> >> for the key states. With this change in place the driver
>> >> supports key pads with more than 32 keys.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> ---
>> >>
>> >> =A0Changes since V1:
>> >> =A0- ditched the wrapping macros
>> >> =A0- use __set_bit() and __clear_bit()
>> >
>> > Thank you for making the change. It indeed is easier to read than =
the
>> > original since one does not have to go and look up what wrappers a=
re
>> > doing.
>>
>> Yeah, I initially disliked the SH_KEYSC_MAXKEYS that now are sprinkl=
ed
>> all over the place, but I have to admit that not using wrappers made
>> me realize that I should use __set_bit() and __clear_bit() instead o=
f
>> the atomic ones. So all good.
>>
>
> BTW, that sh_keysc_map seems to be a holdover from the V1 of the patc=
h
> and is not needed anymore. Does the patch below still work for you?

Thanks for updating the patch. It still works as expected. Please mark
the new patch as V3 if possible so people can
tell the difference between the patches.

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
