From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Logitech T650 is unusable since 3.19.0
Date: Mon, 23 Mar 2015 10:59:24 -0400
Message-ID: <CAN+gG=H0-uMc9wp8jjy-KbwS+WEse5DSNn0prMs_Fkks2QsD=g@mail.gmail.com>
References: <CAJc7LbqPY0hcF-JJh+NUDws8UcoMRfodzZ35q34BPQ+3JAktCA@mail.gmail.com>
	<20150323090920.GA32082@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150323090920.GA32082@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= <abyss.7@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Mar 23, 2015 at 5:09 AM, Borislav Petkov <bp@alien8.de> wrote:
> CC people.
>
> On Mon, Mar 23, 2015 at 11:21:02AM +0300, =D0=9B=D0=B5=D0=B6=D0=B0=D0=
=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD wrote:
>> Hi,
>>
>> after update from 3.18.7 to 3.19.x my Logitech touchpad became almos=
t
>> unusable. I use OpenSUSE Thumbleweed and tried both custom and vanil=
la
>> kernels. AFAIK, the problem may come with this changes:
>> http://lkml.iu.edu/hypermail/linux/kernel/1412.1/03246.html

Indeed, in 3.19, the touchpad is switched into a "raw" mode where it
forwards the multitouch points rather than using the mouse emulation
mode.

>>
>> The symptoms are as follows.
>>
>> 1. The touch density is twice reduced: I have to make longer finger
>> motion for a smaller pointer movement. Possibly, it's because the KD=
E
>> starts to detect the touchpad as touchpad - and not the mouse as it
>> was before - and applies some preferences like the pointer
>> acceleration, etc.

That's either a xorg-synaptics or a KDE bug. But that's somewhat
expected. The synaptics driver was written a long time ago, at a time
where the touchpads were quite small. With a touchpad this big, the
xorg driver simply reduces the speed thinking that your finger is not
moving much.

=46ortunately, in libinput (and so xf86-input-libinput too), we take
into account the resolution and provide a consistent feeling across
touchpads from different sizes.

>>
>> 2. Some gestures stopped to work: 3-finger swipe up, down, left, rig=
ht
>> - so, there are no more "history back-forward", "SuperKey", and
>> "SuperKey + d".

That's expected too, and I was not expecting people to rely that much
on these features.
Again, this should be handled by the upper layer, not by the kernel to
provide a consistent experience with different touchpads.
Libinput began to implement a gesture support, and maybe we should
consider adding the 3 finger swipes to the supported gestures.

>>
>> 3. Multi-finger tap detection is awful: it doesn't detect 3-finger t=
ap
>> in 50%, it sometimes detects 2-finger tap instead of click+drag, or
>> when the second finger is slightly touching the surface.

That is worrisome. It might be a xorg-synaptics bug or a kernel one.
We (Peter and I) both have a T650, so I guess we can try to reproduce
this. We might need you to record some evemu traces of the various
failures.

>>
>> Can anyone make a suggestion what should I do, but to stay on an old=
er
>> kernel version?

To sum up, apologies for breaking your current setup. I still believe
that we should not rely on the firmware to provide gestures because
this generates kind of random shortcuts that are more or less properly
handled by the desktop environment.
That being said, it broke your setup, so I will add a parameter that
you can pass on boot to disable this mode. It's not ideal though, I
concede.

I'll come back to you once I have something you can test.

Jiri, Peter, Hans, if any of you has a better solution (beside
reverting the raw mode) or want to add something, please do.

Cheers,
Benjamin

>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
