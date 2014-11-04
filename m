From: Alan Wu <alan.c.wu@gmail.com>
Subject: Re: Microsoft Surface Pro 3 Type Cover keyboard
Date: Mon, 3 Nov 2014 18:32:30 -0800
Message-ID: <CABkLPOLe=8Um_ATb9=gQcKgHqpowdSXW_XNtOnieCv+P69XDGw@mail.gmail.com>
References: <54492559.8000205@gmail.com>
	<alpine.LNX.2.00.1411031431150.19451@pobox.suse.cz>
	<CAN+gG=HaNviwiTRMxVH+A9mogthwAy=JE1ZJ8+f-d=v7PMf8QA@mail.gmail.com>
	<CAE7eX3JsnY_xAookiT_ycdES5dRP6GkAa+bcRyQ5HaU9iMtGQw@mail.gmail.com>
	<CAN+gG=HBCSE7gGaiSAGa7nzrJqn42qdKvGrbOc=KGZ-BaONyGA@mail.gmail.com>
	<CABkLPOLiiyHSQs=nu0js_NDL61JxoQXGYo9ZwkJ_oT0samftYA@mail.gmail.com>
	<CAN+gG=FnOm_vRAZ87qWKYVP9BSs=quyR2vdaAUjeWOPb2HFeVw@mail.gmail.com>
	<CAOWMAxxvALFUP5Zi9z49nUxPpY+7jhLLAgbLB5bOxKGftHBDLA@mail.gmail.com>
	<CABkLPOK2YQDddLpF2VvoAKxNVYsCOg0-W41SBiSZkDi7df9Opw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:43064 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaKDCcb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 21:32:31 -0500
Received: by mail-yh0-f46.google.com with SMTP id c41so1661364yho.19
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 18:32:30 -0800 (PST)
In-Reply-To: <CABkLPOK2YQDddLpF2VvoAKxNVYsCOg0-W41SBiSZkDi7df9Opw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>

Hi all,
  I submitted the new patch.  Please review and comment.

Thanks,
Alan

On Mon, Nov 3, 2014 at 5:49 PM, Alan Wu <alan.c.wu@gmail.com> wrote:
> Hi all,
>   So after using the patch with Jarrad's changes added in, I was able to
> revert the evdev config to its original and have no problems.  I have
> attached the evdev.conf as follows. However, multitouch does not seem to
> work since ABS_MT_SLOT is defined, but not used.  I have attached some
> sample tests with multiple fingers.  I'm not sure what changed between the
> tests, however, one showed EV_ABS and the other used EV_REL.
>
> I did not realize the dim/brightness was for the type cover hardware
> backlight, and what Jarrad said makes sense that it probably does not send a
> signal.
>
> Please give me some suggestions on what I can do to investigate the
> ABS_MT_SLOT issue now, as this is my first time working with the kernel.
> However, I would second Jarrad's suggestion that we patch this for now and
> get multitouch working later, so at least I can keep ubuntu updated without
> messing with the kernel myself every time.
>
> I will submit the patch soon to the mailing list.
>
> Thanks,
> Alan
>
>
>
> On Mon, Nov 3, 2014 at 5:08 PM, Jarrad Whitaker <jarrad.whitaker@gmail.com>
> wrote:
>>
>> Wow, what a flurry of activity! I don't have much to add beyond Alan's
>> patch on its own did not work for me, I am assuming this is due to
>> manually needing to assign it to evdev which I did not do.
>> Also, on the dim/brightness keys, these control the backlight of the
>> keyboard itself and as far as I can tell do not even pass any signal
>> to the device's native Windows 8.
>> Can probably test a little more tonight or tomorrow, but I am in the
>> middle of exams I'm afraid and this could be a dangerously effective
>> form of procrastination, so I won't be able to so much for a couple of
>> weeks yet.
>>
>> Given the tiny scope of the current patch, is there a chance it could
>> get into 3.18 as is so people at least have a working keyboard, then
>> we continue to work on a proper solution for later?
>>
>> Jarrad
>>
>> P.S. sorry, my win8 mail app lies about sending in plaintext mode.
>>
>> On 4 November 2014 08:27, Benjamin Tissoires
>> <benjamin.tissoires@gmail.com> wrote:
>> > On Mon, Nov 3, 2014 at 4:15 PM, Alan Wu <alan.c.wu@gmail.com> wrote:
>> >> My initial checks after sudo cat /dev/hidraw0 shows that moving
>> >> multiple
>> >> fingers does work with my patch as earlier using hid-microsoft.
>> >> However,
>> >> the dim and brightness keys (Fn+F1, Fn+F2) does not work.
>> >>
>> >> My tests with multiple fingers include:
>> >> moving one finger,
>> >> adding and moving second finger with first finger held,
>> >> moving first finger with second finger stationary,
>> >> adding and moving third finger with first and second finger held,
>> >> moving first or second finger with third finger held.
>> >> repeating with up to eight fingers.
>> >>
>> >> It is hard to check moving two fingers at the same time with another
>> >> one (or
>> >> more) fingers held stationary because the way the output works.  It
>> >> comes
>> >> out something like this, so I can't tell if they are doing what they
>> >> are
>> >> supposed to.
>> >> ^@^@^C\377^@^@
>> >>
>> >> Please let me know how to continue testing.
>> >
>> > You can check the various event node outputs by using evemu.
>> > If the touchpad presents ABS_MT_SLOT and makes use of it, you are
>> > using the raw reporting mode.
>> >
>> > You can also assess it with programs like mtview[1] of mtdiag-qt[2]
>> > (both need to be run as root to get access to the event nodes).
>> >
>> >> I'm currently adding the hid_have_special_driver
>> >> and a couple other lines from Jarrad's website to the patch and will
>> >> test it
>> >> soon before submitting.
>> >>
>> >> Also, how can I continue this thread to linux-input mailing list from
>> >> gmail?
>> >> It keeps rejecting my mail.
>> >
>> > You need to use the "Plain Text Mode" mode. There is a small arrow on
>> > the bottom right of the compose window (next to the trash) and
>> > above "Print", you have the previously mentioned mode.
>> >
>> > Cheers,
>> > Benjamin
>> >
>> > [1] https://github.com/whot/mtview (or maybe
>> > http://bitmath.org/code/mtview/, I can not remember if the bitmath one
>> > is still actively supported)
>> > [2] https://github.com/bentiss/mtdiag-qt
>> >
>> >
>> >>
>> >> On Mon, Nov 3, 2014 at 12:39 PM, Benjamin Tissoires
>> >> <benjamin.tissoires@gmail.com> wrote:
>> >>>
>> >>> On Mon, Nov 3, 2014 at 3:33 PM, Andrew Duggan
>> >>> <andrew.duggan@gmail.com>
>> >>> wrote:
>> >>> >
>> >>> >
>> >>> > On Mon, Nov 3, 2014 at 7:28 AM, Benjamin Tissoires
>> >>> > <benjamin.tissoires@gmail.com> wrote:
>> >>> >>
>> >>> >> On Mon, Nov 3, 2014 at 8:33 AM, Jiri Kosina <jkosina@suse.cz>
>> >>> >> wrote:
>> >>> >> > On Fri, 24 Oct 2014, Jarrad Whitaker wrote:
>> >>> >> >
>> >>> >> >> The keyboard on the Surface Pro 3 type cover does not function
>> >>> >> >> without
>> >>> >> >> some patching, similar to what was apparently required for the
>> >>> >> >> SP2
>> >>> >> >> type/touch covers.
>> >>> >> >>
>> >>> >> >> A working patch against 3.16 attached, it's an amalgamation of
>> >>> >> >> "some
>> >>> >> >> dude posted this on the ubuntu/arch forums and it seems to work"
>> >>> >> >> so
>> >>> >> >> I'm making no claims that it's kernel-quality! Just trying to
>> >>> >> >> give a
>> >>> >> >> better indication of what needs to be added. My C is rudimentary
>> >>> >> >> and
>> >>> >> >> my knowledge of the kernel limited to 'fakeroot debian/rules
>> >>> >> >> updateconfigs', sorry. :)
>> >>> >> >> Happy to test any improved version, but note I only have a type,
>> >>> >> >> not
>> >>> >> >> a
>> >>> >> >> touch cover.
>> >>> >> >>
>> >>> >> >> Patch source is
>> >>> >> >> http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/,
>> >>> >> >> which
>> >>> >> >> in turn sources a Russian site.
>> >>> >> >
>> >>> >> > Hi,
>> >>> >> >
>> >>> >> > thanks. Adding Alan Wu to CC, who sent me a slightly different
>> >>> >> > patch
>> >>> >> > for
>> >>> >> > this issue -- see the archives of linux-input list from a few
>> >>> >> > days
>> >>> >> > back.
>> >>> >> >
>> >>> >> > Your patch is missing at least Signed-off-by: line, and also
>> >>> >> > seems to
>> >>> >> > lack
>> >>> >> > the update to hid_have_special_driver[].
>> >>> >>
>> >>> >> Jiri, actually, the hid_have_special_driver entry is not 100%
>> >>> >> required
>> >>> >> to make it work (though it would be cleaner, I agree).
>> >>> >> Actually, the TypeCover presents a Precision TouchPad, so hid-core
>> >>> >> considers it should have the hid-multitouch driver driving it (see
>> >>> >> https://bugzilla.redhat.com/show_bug.cgi?id=1135338 )
>> >>> >>
>> >>> >> I am not sure we should use hid-multitouch or hid-microsoft. My
>> >>> >> guess
>> >>> >> is that both will work, but hid-multitouch might provide true raw
>> >>> >> reporting for the touchpad. On the other hand, maybe hid-microsoft
>> >>> >> will bind special keys that hid-multitouch will not...
>> >>> >>
>> >>> > I would think that being able to do multifinger gestures would make
>> >>> > using
>> >>> > hid-multitouch preferable. Using hid-microsoft will keep the
>> >>> > touchpad in
>> >>> > mouse mode since the host needs to send the feature report to switch
>> >>> > the
>> >>> > touchpad into PTP mode. In PTP mode, this touchpad will report
>> >>> > absolute
>> >>> > data
>> >>> > for three fingers.
>> >>> >
>> >>> > I think the main issue is how do you get  the keyboard working when
>> >>> > the
>> >>> > device is using the hid-multitouch driver. After looking at the bug
>> >>> > above
>> >>> > and Benjamin's changes on Github it looks like adding an entry in
>> >>> > mt_devices
>> >>> > and setting MT_CLS_EXPORT_ALL_INPUTS would also export the keyboard.
>> >>> > Is
>> >>> > that
>> >>> > correct? I haven't been able to try it out.
>> >>>
>> >>> Correct. See
>> >>>
>> >>> https://github.com/bentiss/hid-multitouch/commit/999eb73d37bab0b72f775f2150b1c27488610414
>> >>> The reporter seems to claim that it works for him, but I need to check
>> >>> if the touchpad is correctly presented (properties, etc), if the
>> >>> touchpad data come from the raw node, and not the mouse node, and if
>> >>> there is no problems with respect to the keyboard. I'd prefer the
>> >>> owners of the device to double check all of this.
>> >>>
>> >>> >
>> >>> > If hid-microsoft has functionality which hid-multitouch doesn't
>> >>> > provide
>> >>> > is
>> >>> > there a way to combine the two without reimplementing the
>> >>> > functionality
>> >>> > of
>> >>> > one driver into the other?
>> >>>
>> >>> The problem with this device is that the keyboard and touchpad are on
>> >>> the same hid device, on different collections. So if hid-microsoft
>> >>> does fancy stuff on the keyboard level, the only option will be to
>> >>> merge hid-multitouch in hid-input (this might be needed at some
>> >>> point).
>> >>>
>> >>> Cheers,
>> >>> Benjamin
>> >>>
>> >>> >
>> >>> >>
>> >>> >> If the path is to go through hid-microsoft, then Jarrad, Alan, yes,
>> >>> >> please, add your device to hid_have_special_driver.
>> >>> >>
>> >>> >> Cheers,
>> >>> >> Benjamin
>> >>> >>
>> >>> >> >
>> >>> >> > Could you two guys please cooperate and send me a patch that
>> >>> >> > should
>> >>> >> > be
>> >>> >> > applied? I don't have the device so can't really test properly
>> >>> >> > myself.
>> >>> >> >
>> >>> >> > Thanks,
>> >>> >> >
>> >>> >> > --
>> >>> >> > Jiri Kosina
>> >>> >> > SUSE Labs
>> >>> >> > --
>> >>> >> > To unsubscribe from this list: send the line "unsubscribe
>> >>> >> > linux-input"
>> >>> >> > in
>> >>> >> > the body of a message to majordomo@vger.kernel.org
>> >>> >> > More majordomo info at
>> >>> >> > http://vger.kernel.org/majordomo-info.html
>> >>> >> --
>> >>> >> To unsubscribe from this list: send the line "unsubscribe
>> >>> >> linux-input"
>> >>> >> in
>> >>> >> the body of a message to majordomo@vger.kernel.org
>> >>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>> >
>> >>> >
>> >>
>> >>
>
>
