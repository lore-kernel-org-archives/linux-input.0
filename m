From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol detection
Date: Thu, 10 May 2012 11:32:56 +0200
Message-ID: <CAN+gG=HJQxvFvCDf4LkYcvG3th4dyNFTNy8LzCZcq=gqo97p-w@mail.gmail.com>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
	<1336136030-18503-2-git-send-email-benjamin.tissoires@gmail.com>
	<20120506190146.GA12571@polaris.bitmath.org>
	<CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
	<20120509195632.GA12406@polaris.bitmath.org>
	<alpine.LNX.2.00.1205101026010.31253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55773 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab2EJJc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 05:32:57 -0400
In-Reply-To: <alpine.LNX.2.00.1205101026010.31253@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 10, 2012 at 10:31 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 9 May 2012, Henrik Rydberg wrote:
>
>> > well, the idea was to keep the memory footprint low. As these valu=
es
>> > are only needed at init, then I freed them once I finished using t=
hem.
>> > I can of course skip the pointer, but in that case, wouldn't the
>> > struct declaration be worthless?
>>
>> My bad, I misread the placement of the free() statement. I was also
>> concerned about memory, since HID is big enough a memory hog as it
>> is. Barring the added complexity of this patch, it now makes more
>> sense.
>>
>> =A0 =A0 Acked-by: Henrik Rydberg <rydberg@euromail.se>
>
> drivers/hid/hid-multitouch.c: In function =91mt_post_parse=92:
> drivers/hid/hid-multitouch.c:673: error: invalid type argument of =91=
->=92 (have =91unsigned int=92)
> make[1]: *** [drivers/hid/hid-multitouch.o] Error 1
>
> I believe that
>
> =A0 =A0 =A0 =A0td->last_slot_field =3D f->usages[field_count_per_touc=
h - 1]->hid;
>
> should be
>
> =A0 =A0 =A0 =A0td->last_slot_field =3D f->usages[field_count_per_touc=
h - 1];

Ouch, indeed. the "->hid" is extra. When I split the patch 1 and 5, I
missed that one.

I tested it without the ->hid, and it's good. Do I need to resend the p=
atch?

Cheers,
Benjamin

>
> but I leave this up to you guys to fix.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
