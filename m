From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Fri, 3 May 2013 08:50:00 -0700
Message-ID: <20130503155000.GA5567@core.coreip.homeip.net>
References: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <20130502170103.GC28625@core.coreip.homeip.net>
 <CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
 <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
 <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
 <20130502204503.GF28625@core.coreip.homeip.net>
 <CAFmpkyhhCyFU=MsjD+=7fPmmWNinGZ9GzfHUfn0fJqivWWPV4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65061 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459Ab3ECPuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 11:50:07 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so993046pab.32
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 08:50:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyhhCyFU=MsjD+=7fPmmWNinGZ9GzfHUfn0fJqivWWPV4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>

On Thu, May 02, 2013 at 05:10:42PM -0400, Todd Showalter wrote:
> On Thu, May 2, 2013 at 4:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > Again, the kernel will try to do the right thing and produce the correct
> > events for new input devices, but we are not going to introduce a copy
> > of evdev protocol that limits the events to "standard gamepad" ones.
> 
>     Ok.  I can see there's no point arguing this.  What can I do to at
> least make sure future devices behave?  Is there anything that can be
> done about current devices other than translate in userspace?

Please post the patches for discussion and keep en eye on changes going
into drivers/input/joystick and drivers/hid as you have a vested
interest of everyone getting it right.

I am not sure about status of PS3 controller, I think Bastien was
working on supporting it from userspace?

-- 
Dmitry
