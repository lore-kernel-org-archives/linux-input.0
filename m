From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1][INCREMENTAL] Input: cyttsp - Fixes to clean-up patch
Date: Tue, 31 Jan 2012 16:52:26 +0000
Message-ID: <CABxcv=m7wBMwwkVi9YzZd=d3v+sPdcqsaOXF157dUsyHqvn9GQ@mail.gmail.com>
References: <1327816430-19887-1-git-send-email-javier@dowhile0.org>
	<20120129061802.GA25977@core.coreip.homeip.net>
	<CAAwP0s16iO_w9cTLY_ps-X5uBCks4p15XBs2Ea69Gu7Qm7Xe_Q@mail.gmail.com>
	<20120131082152.GA4064@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38105 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab2AaQw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 11:52:27 -0500
Received: by iacb35 with SMTP id b35so197277iac.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 08:52:27 -0800 (PST)
In-Reply-To: <20120131082152.GA4064@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org

On Tue, Jan 31, 2012 at 8:21 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Jan 29, 2012 at 04:28:12PM +0100, Javier Martinez Canillas wr=
ote:
>> On Sun, Jan 29, 2012 at 7:18 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sun, Jan 29, 2012 at 06:53:50AM +0100, Javier Martinez Canillas=
 wrote:
>> >> This is patch fixes two bugs in Dmitry's last cleanup patch.
>> >>
>> >> 1- The hardware tracking ids are stored in the ids array and the =
information for
>> >> =C2=A0 =C2=A0each contact is obtained calling cyttsp_get_tch() wi=
th an index. In the clean-up
>> >> =C2=A0 =C2=A0patch the value of the tracking id was used instead =
of the contact index.
>> >>
>> >
>> > Oops, thank you for fixing that.
>> >
>> >> 2- i2c_set_clientdata() is called after the generic cyttsp_probe(=
) function and
>> >> =C2=A0 =C2=A0this function calls cyttsp_power_on() that sends an =
ttsp command to the device
>> >> =C2=A0 =C2=A0and needs the client data before is set. The fix is =
to execute cyttsp_power_on
>> >> =C2=A0 =C2=A0inside the transport specific probe function (I2C, S=
PI) after the generic probe
>> >> =C2=A0 =C2=A0function is executed and the client data is set.
>> >>
>> >
>> > Not quite happy about this one, how about we pass cyttsp directly =
to bus
>> > methods instead of relying on drvdata (as in the patch below)?
>> >
>> > Thanks.
>> >
>> > --
>> > Dmitry
>>
>> Hi Dmitry,
>>
>> Yes, you are right that is a much more clever solution to the issue.
>> Thank you for suggesting that.
>>
>> I just sent an v2 of the incremental patch to be applied on top of
>> your last clean-up.
>>
>> This fixes the index bug stated before and the dev->i2c_client->cytt=
sp
>> reference being NULL issue changing the read/write methods signature
>> as you suggested.
>>
>> It also fixes an unbalanced IRQ warning since soft_reset() now is
>> called inside the probe function and removes the wake_up platform
>> function in enable() as with the incremental v1.
>>
>> Thanks a lot for your help and best regards,
>
> Folded everything up and applied to my 3.4 queue.
>
> Thank you Javier.
>
> --
> Dmitry

Great, thank you very much for your help Dmitry!

Regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
