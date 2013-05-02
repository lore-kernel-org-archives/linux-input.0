From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 09:38:24 -0700
Message-ID: <20130502163824.GA28625@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
 <CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33002 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760791Ab3EBQi2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 12:38:28 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so439127pbc.2
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 09:38:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 02, 2013 at 11:58:08AM -0400, Todd Showalter wrote:
> Webmail makes it too easy to fat-finger "send".
> 
> On Thu, May 2, 2013 at 10:09 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> 
> > So if you want reliable gamepads, the easiest way is a user-space
> > mapping based on device-names. This guarantees you get the expected
> > buttons. Adding support for new devices is a matter of few lines of
> > code. And it normally takes >1 month for a device driver gets included
> > in the kernel, so you have enough time adding the support to your
> > user-space side.
> > This also allows you to easily support devices that are no gamepads,
> > but would make sense with your applications.
> 
>     User-space mapping sucks.
> 
>     It means we can't just ship a game and have it work with new
> hardware; every time someone adds a new controller to the kernel, we
> have to patch the game to support it.  Or else the mapping has to
> happen in a shared library, and someone has to patch that to match the
> kernel.
> 
>     It means that things that should just work (like OEM 360
> controllers) may well not work because EVIOCGNAME returns a string
> that isn't in our table, so we don't know what to do with the data.

I agree here, mapping sucks. But sometimes it is necessary.

I wish we have gotten all the mappings correct from the get go, but that
did not happen, so now we need to move forward. That means that we can
establish the canonical mapping and try to follow it for the new
devices, but you still need to support older devices and for that you
will still need mapping.

> 
>     I love developing on Linux; it's the lead platform for our game
> engine and has been since I wrote the first line of code in 2003, but
> from a game development standpoint gamepad input is one of the real
> friction points on the platform.  As a game developer, I don't want a
> universe of possible controllers each subtly different from the other.
>  I want the player to be able to plug in a gamepad and know that if
> they push the bottom face button on the right hand side of the pad,
> their character will jump.  If they plug in a racing wheel or a
> wiimote plugged into a balance board, I'm ignoring it and giving them
> keyboard controls.
> 
>     Really, what I want is roughly what /dev/input/js* has, but as
> /dev/input/gamepad* with standardized mapping.

This is understandable but I do not believe this should be done in
kernel, but rather in userspace.

-- 
Dmitry
