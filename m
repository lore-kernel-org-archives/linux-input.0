From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Microsoft Surface Pro 3 Type Cover keyboard
Date: Mon, 3 Nov 2014 10:28:40 -0500
Message-ID: <CAN+gG=HaNviwiTRMxVH+A9mogthwAy=JE1ZJ8+f-d=v7PMf8QA@mail.gmail.com>
References: <54492559.8000205@gmail.com>
	<alpine.LNX.2.00.1411031431150.19451@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:37453 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbaKCP2m (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 10:28:42 -0500
Received: by mail-qc0-f171.google.com with SMTP id m20so9169732qcx.2
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 07:28:41 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1411031431150.19451@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jarrad Whitaker <jarrad.whitaker@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Wu <alan.c.wu@gmail.com>

On Mon, Nov 3, 2014 at 8:33 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 24 Oct 2014, Jarrad Whitaker wrote:
>
>> The keyboard on the Surface Pro 3 type cover does not function without
>> some patching, similar to what was apparently required for the SP2
>> type/touch covers.
>>
>> A working patch against 3.16 attached, it's an amalgamation of "some
>> dude posted this on the ubuntu/arch forums and it seems to work" so
>> I'm making no claims that it's kernel-quality! Just trying to give a
>> better indication of what needs to be added. My C is rudimentary and
>> my knowledge of the kernel limited to 'fakeroot debian/rules
>> updateconfigs', sorry. :)
>> Happy to test any improved version, but note I only have a type, not a
>> touch cover.
>>
>> Patch source is
>> http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/, which
>> in turn sources a Russian site.
>
> Hi,
>
> thanks. Adding Alan Wu to CC, who sent me a slightly different patch for
> this issue -- see the archives of linux-input list from a few days back.
>
> Your patch is missing at least Signed-off-by: line, and also seems to lack
> the update to hid_have_special_driver[].

Jiri, actually, the hid_have_special_driver entry is not 100% required
to make it work (though it would be cleaner, I agree).
Actually, the TypeCover presents a Precision TouchPad, so hid-core
considers it should have the hid-multitouch driver driving it (see
https://bugzilla.redhat.com/show_bug.cgi?id=1135338 )

I am not sure we should use hid-multtiouch or hid-microsoft. My guess
is that both will work, but hid-multitouch might provide true raw
reporting for the touchpad. On the other hand, maybe hid-microsoft
will bind special keys that hid-multitouch will not...

If the path is to go through hid-microsoft, then Jarrad, Alan, yes,
please, add your device to hid_have_special_driver.

Cheers,
Benjamin

>
> Could you two guys please cooperate and send me a patch that should be
> applied? I don't have the device so can't really test properly myself.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
