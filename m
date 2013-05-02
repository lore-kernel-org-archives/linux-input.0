From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 17:10:42 -0400
Message-ID: <CAFmpkyhhCyFU=MsjD+=7fPmmWNinGZ9GzfHUfn0fJqivWWPV4A@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	<20130502170103.GC28625@core.coreip.homeip.net>
	<CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
	<CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
	<CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
	<20130502204503.GF28625@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:55067 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758797Ab3EBVKn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 17:10:43 -0400
Received: by mail-qe0-f49.google.com with SMTP id 7so544964qeb.8
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 14:10:42 -0700 (PDT)
In-Reply-To: <20130502204503.GF28625@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 2, 2013 at 4:45 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

>>     I'd far rather the games with special needs had to do heavy
>> lifting than have the common case be complicated just because someone
>> might want to use a wiimote with a balance board plugged in though a
>> motion plus.
>>
>>     If there was good support for racing wheels, kinect-like
>> controllers and so forth, that would be nice too.  But 99% of games
>> will have their input needs met just fine by the standard controller
>> I'm proposing, the standard keyboard and standard mouse.
>
> So are you arguing for /dev/input/wheel as well? And for applications
> that are a bit more advanced /dev/input_wheel_with_pedals? This is not
> really sustainable when we can already deliver all data through existing
> interface.

    No, I'm arguing the opposite.  I want a canonical mapping for
standard controllers.  Anything that wants more than that can deal
with having to understand specific devices.  What I'm saying is that a
vanishingly small number of games actually care about more than the
standard gamepad.

> And this is better then cherry pick commit 1765326732afd763876348 from
> next branch of input tree, recompile the kernel and see if that fixes
> your issue?

    "Make sure you're running the latest kernel." beats the hell out
of "Make sure you've installed the latest FixLegacyGamepads package.
If your distro doesn't support FixLegacyGamepads or has a version
older than 1.2.62104, you'll need to install git...".

> Again, the kernel will try to do the right thing and produce the correct
> events for new input devices, but we are not going to introduce a copy
> of evdev protocol that limits the events to "standard gamepad" ones.

    Ok.  I can see there's no point arguing this.  What can I do to at
least make sure future devices behave?  Is there anything that can be
done about current devices other than translate in userspace?

                                       Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
