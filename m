From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v3 7/7] input: wacom - add 0xE5 (MT device) support
Date: Wed, 22 Feb 2012 15:33:22 -0800
Message-ID: <CANRwn3QhsCQNU9MtLt9+SaJBrA4nzVZp=4NYYc3Qw-+h9BTcvA@mail.gmail.com>
References: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
	<20120220082415.GA6525@polaris.bitmath.org>
	<CAGzDe_bJ1-9qqrNeOt-6-7s++JLQ-x-xpLcrVWTJNWQ95W-P+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43934 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab2BVXdX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 18:33:23 -0500
Received: by wics10 with SMTP id s10so389475wic.19
        for <linux-input@vger.kernel.org>; Wed, 22 Feb 2012 15:33:22 -0800 (PST)
In-Reply-To: <CAGzDe_bJ1-9qqrNeOt-6-7s++JLQ-x-xpLcrVWTJNWQ95W-P+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Feb 20, 2012 at 11:30 AM, Chris Bagwell <chris@cnpbagwell.com> =
wrote:
> On Mon, Feb 20, 2012 at 2:24 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
>> Hi Chris,
>>
>> The input_mt_report_slot_state should be used instead of directly
>> setting the tracking id. If the id reported by the hardware is not
>> bounded by some small number (so that it maps to slots), you will ha=
ve
>> to keep the translation table in the driver.
>>
>> Also, the commit message could need some love.
>>
>> Thanks,
>> Henrik
>
> Thank you for review, Henrik.
>
> Makes sense. =C2=A0hid-multitouch has an example find_slot_from_conta=
ctid()
> that could be used as reference here if the ID's are not bound.
>
> I'll have to table patches 6 and 7 until either Ping is available to
> update them or can provide me some more details on tracking ID
> behavior.
>
> Anyone have comments on patches 1-5 that are for Wireless Bamboo supp=
ort?
>
> Thanks again,
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

Chris,

I got my hands on the hardware, and it looks like the it keeps track
of the total number of touches that have occurred since it was plugged
in. The 1st touch gets an ID of 1, the 10th an ID of 10, and the 100th
an ID of 100. The 256th touch overflows the available byte of space
and is assigned an ID of 0.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
