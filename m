From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?=
	<abyss.7@gmail.com>
Subject: Re: Logitech T650 is unusable since 3.19.0
Date: Tue, 24 Mar 2015 20:29:52 +0300
Message-ID: <CAJc7Lbrbq+_xBLJT8+4=Hdws+ULxU1jvJiR4fnvQLXvbOYzf6g@mail.gmail.com>
References: <CAJc7LbqPY0hcF-JJh+NUDws8UcoMRfodzZ35q34BPQ+3JAktCA@mail.gmail.com>
	<20150323090920.GA32082@pd.tnic>
	<CAN+gG=H0-uMc9wp8jjy-KbwS+WEse5DSNn0prMs_Fkks2QsD=g@mail.gmail.com>
	<20150324060005.GA24791@jelly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33650 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbbCXR3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 13:29:53 -0400
In-Reply-To: <20150324060005.GA24791@jelly.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Thanks to everyone for the response. The run-time kernel option to
return old behavior would be appreciated, because the hardcoded
firmware gestures are better than no gestures at all. Also I'll try to
record multi-finger taps with evemu, when I get familiar with it.

On 24 March 2015 at 09:00, Peter Hutterer <peter.hutterer@who-t.net> wr=
ote:
> On Mon, Mar 23, 2015 at 10:59:24AM -0400, Benjamin Tissoires wrote:
>> Hi,
>>
>> On Mon, Mar 23, 2015 at 5:09 AM, Borislav Petkov <bp@alien8.de> wrot=
e:
>> > CC people.
>> >
>> > On Mon, Mar 23, 2015 at 11:21:02AM +0300, =D0=9B=D0=B5=D0=B6=D0=B0=
=D0=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD wrote:
>> >> Hi,
>> >>
>> >> after update from 3.18.7 to 3.19.x my Logitech touchpad became al=
most
>> >> unusable. I use OpenSUSE Thumbleweed and tried both custom and va=
nilla
>> >> kernels. AFAIK, the problem may come with this changes:
>> >> http://lkml.iu.edu/hypermail/linux/kernel/1412.1/03246.html
>>
>> Indeed, in 3.19, the touchpad is switched into a "raw" mode where it
>> forwards the multitouch points rather than using the mouse emulation
>> mode.
>>
>> >>
>> >> The symptoms are as follows.
>> >>
>> >> 1. The touch density is twice reduced: I have to make longer fing=
er
>> >> motion for a smaller pointer movement. Possibly, it's because the=
 KDE
>> >> starts to detect the touchpad as touchpad - and not the mouse as =
it
>> >> was before - and applies some preferences like the pointer
>> >> acceleration, etc.
>>
>> That's either a xorg-synaptics or a KDE bug. But that's somewhat
>> expected. The synaptics driver was written a long time ago, at a tim=
e
>> where the touchpads were quite small. With a touchpad this big, the
>> xorg driver simply reduces the speed thinking that your finger is no=
t
>> moving much.
>
> It's probably a synaptics bug, I'll add it to my todo list to test th=
is
> locally.
>
>> Fortunately, in libinput (and so xf86-input-libinput too), we take
>> into account the resolution and provide a consistent feeling across
>> touchpads from different sizes.
>>
>> >>
>> >> 2. Some gestures stopped to work: 3-finger swipe up, down, left, =
right
>> >> - so, there are no more "history back-forward", "SuperKey", and
>> >> "SuperKey + d".
>>
>> That's expected too, and I was not expecting people to rely that muc=
h
>> on these features.
>> Again, this should be handled by the upper layer, not by the kernel =
to
>> provide a consistent experience with different touchpads.
>> Libinput began to implement a gesture support, and maybe we should
>> consider adding the 3 finger swipes to the supported gestures.
>
> fwiw, we have some rough long-term plans to provide touchpad gestures=
 in X,
> but nothing implemented yet. libinput already has patches for this on=
 the
> list, it's down to getting the API right and then exporting the data =
through
> the X protocol.
>
> Having said that: until this is all in place, touchpad gestures simpl=
y won't
> work.
>
>> >> 3. Multi-finger tap detection is awful: it doesn't detect 3-finge=
r tap
>> >> in 50%, it sometimes detects 2-finger tap instead of click+drag, =
or
>> >> when the second finger is slightly touching the surface.
>>
>> That is worrisome. It might be a xorg-synaptics bug or a kernel one.
>> We (Peter and I) both have a T650, so I guess we can try to reproduc=
e
>> this. We might need you to record some evemu traces of the various
>> failures.
>
> indeed, please file a bug on bugs.freedesktop.org and assign it to me=
 (with
> evemu recordings please).
>
> Cheers,
>    Peter
>
>> >> Can anyone make a suggestion what should I do, but to stay on an =
older
>> >> kernel version?
>>
>> To sum up, apologies for breaking your current setup. I still believ=
e
>> that we should not rely on the firmware to provide gestures because
>> this generates kind of random shortcuts that are more or less proper=
ly
>> handled by the desktop environment.
>> That being said, it broke your setup, so I will add a parameter that
>> you can pass on boot to disable this mode. It's not ideal though, I
>> concede.
>>
>> I'll come back to you once I have something you can test.
>>
>> Jiri, Peter, Hans, if any of you has a better solution (beside
>> reverting the raw mode) or want to add something, please do.
>>
>> Cheers,
>> Benjamin
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
