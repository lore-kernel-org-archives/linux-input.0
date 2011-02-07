From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Mon, 7 Feb 2011 17:51:27 +0100
Message-ID: <AANLkTi=yTh4YSPSQBnPFPyen9vfyfYGiT6GJVEKwGHjh@mail.gmail.com>
References: <1296485689.7756.9.camel@novo.hadess.net>
	<20110131212842.GB1603@polaris.bitmath.org>
	<AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	<1296561717.15349.5.camel@novo.hadess.net>
	<AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
	<1296650569.2123.2.camel@novo.hadess.net>
	<AANLkTinOK+=J64NRWZjit3S7hAdGVXxRE9HYkxTxrxON@mail.gmail.com>
	<AANLkTi=MGNLfLHQpVEyJGtE-j-D0dj-RWXAihW1xMKDe@mail.gmail.com>
	<1296922260.4223.4.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46313 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab1BGQv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Feb 2011 11:51:29 -0500
Received: by wwa36 with SMTP id 36so4999267wwa.1
        for <linux-input@vger.kernel.org>; Mon, 07 Feb 2011 08:51:27 -0800 (PST)
In-Reply-To: <1296922260.4223.4.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Bastien,

On Sat, Feb 5, 2011 at 17:10, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2011-02-02 at 14:20 +0100, Benjamin Tissoires wrote:
>> With the patch this time.... ;)
>>
>> On Wed, Feb 2, 2011 at 14:18, Benjamin Tissoires
>> <benjamin.tissoires@gmail.com> wrote:
>> > On Wed, Feb 2, 2011 at 13:42, Bastien Nocera <hadess@hadess.net> wrote:
>> >> On Tue, 2011-02-01 at 14:25 +0100, Benjamin Tissoires wrote:
>> >> <snip>
>> >>> First pass:
>> >>> - please get the branch multitouch of jiri's tree (at
>> >>> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/multitouch)
>> >>> - then apply the attached patch (git am
>> >>> 0001-hid-multitouch-Introduce-Elo-TouchSystems-2515-Intel.patch)
>> >>> - get your config from your current kernel (check that hid-multitouch
>> >>> is enabled as a module)
>> >>> - compile, install, reboot
>> >>
>> >> That's where I hit a problem. It seems that the kernel on which that
>> >> branch is based has broken cgroups support (it panics on startup).
>> >>
>> >> Would your patch, or a patchset be available to apply to the close to
>> >> Linus tree Fedora rawhide kernel?
>> >
>> > Hi Bastien,
>> >
>> > Sorry for that. Attached a new version that bumps a Linus' 2.6.38-rc2
>> > or 2.6.38-rc3 to Jiri's tree and applies the patch above.
>> >
>> > If it's still not working, I'll send you the files directly ;)
>
> The instructions didn't quite work (the PCI ID seems to be in
> upper-case, and the tail command wasn't producing any output). I used
> good ol' 'cat' instead. Attached is what it produced.

oops... When you say "the PCI ID seems to be in upper-case", you means
the path of the events file, or you had to modify the patch?

>
> The cursor actually follows the touch, but it seems I need to press
> quite hard to make it work.

Is this the same with a Windows system? I don't think we made any
assumption on the pressure.

> Touch with 2 fingers doesn't do anything
> different from single finger.

This is quite normal: Linux is not ready for multitouch right now ;)
Only the kernel is ready. People are working on x.org' XInput 2.1 to
enable multitouch in X.org, and the toolkits are following this
development.

If you want to give a try, you can download our mt-diagnostic software
at:  http://lii-enac.fr/en/architecture/linux-input/mtdiag.html .

>
> Let me know if you want me to test anything else. I'll try not to take
> as long to do the testing next time, but we were working on our first
> GNOME 3 test day.

Well, the device does not sends much relevant informations: we have to
rebuild some informations, so the final patch will be really close to
the one I sent last week. Once I made it, I'll ask you to test it
before submitting it for 2.6.38 (if it's still possible).

Cheers,
Benjamin
