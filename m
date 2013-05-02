From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 10:01:03 -0700
Message-ID: <20130502170103.GC28625@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:38433 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211Ab3EBRBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 13:01:07 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so393989dad.23
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 10:01:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-input@vger.kernel.org

On Thu, May 02, 2013 at 09:46:44AM -0400, Todd Showalter wrote:
> 
> left stick: ABS_X, ABS_Y
> right stick: ABS_RX, ABS_RY

Not sure about this one. Originally RX, RY and RZ were introduces for
device having more than 3 degress of freedom; and RX is used by many
joystick devices. We'd ether need a property bit to distinguish gamepad
from a joystick or simply ass ABS_X2, ABS_Y2 etc for the second stick.

> dpad: ABS_HAT0X, ABS_HAT0Y
> left trigger: ABS_Z

Huh?

> right trigger: ABS_RZ

Not at all. These are not absolute events but rather buttons, so let's
define them as such.

> start button: BTN_START
> system button: BTN_SYSTEM
> four face buttons: BTN_NORTH, BTN_EAST, BTN_SOUTH, BTN_WEST
> two shoulder buttons: BTN_TL, BTN_TR
> two stick click buttons: BTN_THUMBL, BTN_THUMBR

Thanks.

-- 
Dmitry
