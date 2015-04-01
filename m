From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH FIX for 4.0 0/2] alps: Report alps v2 Dualpoint Stick
 events via the right event node
Date: Wed, 01 Apr 2015 18:14:43 +0200
Message-ID: <551C1973.6060304@redhat.com>
References: <1427903046-26692-1-git-send-email-hdegoede@redhat.com> <201504011811.03302@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbbDAQOr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Apr 2015 12:14:47 -0400
In-Reply-To: <201504011811.03302@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

On 01-04-15 18:11, Pali Roh=C3=A1r wrote:
> On Wednesday 01 April 2015 17:44:04 Hans de Goede wrote:
>> Hi Dmitry & Pali,
>>
>> While working on some libinput code to deal with trackpoints
>> of different model laptops having quite different speed /
>> sensitivity ootb, I noticed that with the current 4.0-rc#
>> kernels the trackpoint events on laptops with a PROTO_V2 alps
>> touchpad are no longer being send by the "Dualpoint Stick"
>> event node, instead a new "ALPS PS/2 Mouse" node gets created
>> and sends the trackpoint events.
>>
>> The cause of this is that the stick on these devices sends
>> bare ps/2 packets as data.
>>
>> Although this does not really break anything (atm, it does
>> break my libinput work), it is still wrong, esp. also since
>> the "Dualpoint Stick" node has the POINTING_STICK property
>> set, where as the "ALPS PS/2 Mouse" node which is actually
>> sending the stick events does not.
>>
>> If still possible I would like to see this fixes added to 4.0,
>> if not we should queue them up for stable.
>>
>> Regards,
>>
>> Hans
>
> Hi Hans, thanks for testing!
>
> I would like to see this observation also in alps protocol
> documentation, where is all information how are data from
> touchpads and tracksticks reported.

Good point, for today I'm already a bit late with logging
off, but I'll do a follow up patch for this tomorrow.

> Also for me it it makes sense to squash both patches into one.

I think having them separate is slightly better, but either
way is fine with me,

> And can you check if your change is needed only for
> ALPS_PS2_INTERLEAVED devices? For me it looks like that only
> those alps devices could mix both 3-bytes and 6-bytes packets...

That is what I expected in the beginning too, but no that is
not the case, this happens on my Latitude D620 too, and that
one does not use / set ALPS_PS2_INTERLEAVED.

Regards,

Hans

p.s.

Talking about ALPS_PS2_INTERLEAVED did you ever try that on the
current troublesome models which sometime get out of sync?

Maybe they are actually interleaving things again ?

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
