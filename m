From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 2/3] HID: wacom: Initialize MT slots for generic
 devices at post_parse_hid
Date: Tue, 9 Dec 2014 09:29:24 -0500
Message-ID: <CAN+gG=HuSs0Bpe7LaHZC6rqWTTaNQ_4_hrOMm+3Sv1Z80vB5nQ@mail.gmail.com>
References: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
	<CAN+gG=E5EfxzKgOBf9wAXrzwq=i8XKNk9d8oSWeQbVGVMojjJQ@mail.gmail.com>
	<alpine.LNX.2.00.1412090900120.14413@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33663 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaLIO3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2014 09:29:36 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so478903qcx.13
        for <linux-input@vger.kernel.org>; Tue, 09 Dec 2014 06:29:35 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1412090900120.14413@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Tue, Dec 9, 2014 at 3:00 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 5 Dec 2014, Benjamin Tissoires wrote:
>
>> > If a HID descriptor places HID_DG_CONTACTID before HID_DG_X and HID_DG_Y then
>> > the ABS_X and ABS_Y will not be automatically initialized by the call to
>> > input_mt_init_slots. To ensure that this is not a problem, we relocate that
>> > call to occur after HID parsing has been completed and we've initalized all
>> > the multitouch axes.
>> >
>> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> > ---
>>
>> This one is
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Benjamin, does your Reviewed-by: apply to both 2/3 and 3/3?
>

Hi Jiri,

Well, I wanted to make some cosmetic changes in 3/3 and double check
that it was generic enough, but I've been sidetracked, and today I
have to keep my sick daughter.
Please apply my rev-by on this one only. Feel free to apply 3/3
however - if you can dedicate a little bit of time to check it -
(without my rev-by then), it's not that it will prevent us to change
it later if we have to.

Cheers,
Benjamin

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
