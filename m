From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Microsoft Surface Pro 3 Type Cover keyboard
Date: Mon, 3 Nov 2014 15:39:39 -0500
Message-ID: <CAN+gG=HBCSE7gGaiSAGa7nzrJqn42qdKvGrbOc=KGZ-BaONyGA@mail.gmail.com>
References: <54492559.8000205@gmail.com>
	<alpine.LNX.2.00.1411031431150.19451@pobox.suse.cz>
	<CAN+gG=HaNviwiTRMxVH+A9mogthwAy=JE1ZJ8+f-d=v7PMf8QA@mail.gmail.com>
	<CAE7eX3JsnY_xAookiT_ycdES5dRP6GkAa+bcRyQ5HaU9iMtGQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:61139 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbaKCUjk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 15:39:40 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so9402087qge.16
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 12:39:39 -0800 (PST)
In-Reply-To: <CAE7eX3JsnY_xAookiT_ycdES5dRP6GkAa+bcRyQ5HaU9iMtGQw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <andrew.duggan@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jarrad Whitaker <jarrad.whitaker@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Wu <alan.c.wu@gmail.com>, Andrew Duggan <aduggan@synaptics.com>

On Mon, Nov 3, 2014 at 3:33 PM, Andrew Duggan <andrew.duggan@gmail.com> wrote:
>
>
> On Mon, Nov 3, 2014 at 7:28 AM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>>
>> On Mon, Nov 3, 2014 at 8:33 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> > On Fri, 24 Oct 2014, Jarrad Whitaker wrote:
>> >
>> >> The keyboard on the Surface Pro 3 type cover does not function without
>> >> some patching, similar to what was apparently required for the SP2
>> >> type/touch covers.
>> >>
>> >> A working patch against 3.16 attached, it's an amalgamation of "some
>> >> dude posted this on the ubuntu/arch forums and it seems to work" so
>> >> I'm making no claims that it's kernel-quality! Just trying to give a
>> >> better indication of what needs to be added. My C is rudimentary and
>> >> my knowledge of the kernel limited to 'fakeroot debian/rules
>> >> updateconfigs', sorry. :)
>> >> Happy to test any improved version, but note I only have a type, not a
>> >> touch cover.
>> >>
>> >> Patch source is
>> >> http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/, which
>> >> in turn sources a Russian site.
>> >
>> > Hi,
>> >
>> > thanks. Adding Alan Wu to CC, who sent me a slightly different patch for
>> > this issue -- see the archives of linux-input list from a few days back.
>> >
>> > Your patch is missing at least Signed-off-by: line, and also seems to
>> > lack
>> > the update to hid_have_special_driver[].
>>
>> Jiri, actually, the hid_have_special_driver entry is not 100% required
>> to make it work (though it would be cleaner, I agree).
>> Actually, the TypeCover presents a Precision TouchPad, so hid-core
>> considers it should have the hid-multitouch driver driving it (see
>> https://bugzilla.redhat.com/show_bug.cgi?id=1135338 )
>>
>> I am not sure we should use hid-multitouch or hid-microsoft. My guess
>> is that both will work, but hid-multitouch might provide true raw
>> reporting for the touchpad. On the other hand, maybe hid-microsoft
>> will bind special keys that hid-multitouch will not...
>>
> I would think that being able to do multifinger gestures would make using
> hid-multitouch preferable. Using hid-microsoft will keep the touchpad in
> mouse mode since the host needs to send the feature report to switch the
> touchpad into PTP mode. In PTP mode, this touchpad will report absolute data
> for three fingers.
>
> I think the main issue is how do you get  the keyboard working when the
> device is using the hid-multitouch driver. After looking at the bug above
> and Benjamin's changes on Github it looks like adding an entry in mt_devices
> and setting MT_CLS_EXPORT_ALL_INPUTS would also export the keyboard. Is that
> correct? I haven't been able to try it out.

Correct. See https://github.com/bentiss/hid-multitouch/commit/999eb73d37bab0b72f775f2150b1c27488610414
The reporter seems to claim that it works for him, but I need to check
if the touchpad is correctly presented (properties, etc), if the
touchpad data come from the raw node, and not the mouse node, and if
there is no problems with respect to the keyboard. I'd prefer the
owners of the device to double check all of this.

>
> If hid-microsoft has functionality which hid-multitouch doesn't provide is
> there a way to combine the two without reimplementing the functionality of
> one driver into the other?

The problem with this device is that the keyboard and touchpad are on
the same hid device, on different collections. So if hid-microsoft
does fancy stuff on the keyboard level, the only option will be to
merge hid-multitouch in hid-input (this might be needed at some
point).

Cheers,
Benjamin

>
>>
>> If the path is to go through hid-microsoft, then Jarrad, Alan, yes,
>> please, add your device to hid_have_special_driver.
>>
>> Cheers,
>> Benjamin
>>
>> >
>> > Could you two guys please cooperate and send me a patch that should be
>> > applied? I don't have the device so can't really test properly myself.
>> >
>> > Thanks,
>> >
>> > --
>> > Jiri Kosina
>> > SUSE Labs
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-input"
>> > in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
