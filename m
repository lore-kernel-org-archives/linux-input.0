From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Tue, 29 Mar 2016 18:48:19 +0200
Message-ID: <56FAB1D3.5020003@m-reimer.de>
References: <56F82C42.6020002@m-reimer.de>
 <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
 <56F8F107.3050906@m-reimer.de>
 <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:33636 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757744AbcC2QsX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 12:48:23 -0400
In-Reply-To: <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=c3=a9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 03/29/2016 12:21 PM, Cl=C3=A9ment VUCHENER wrote:
> This looks fine to me (maybe you should make sure upload.retval is
> correctly set before calling UI_END_FF_UPLOAD, but that is not relate=
d
> to your problem).

Thanks for the hint. I guess I should do that in the erase handler, too=
=2E

> I am using uinput with multiple threads without problems (one in a
> reading loop like yours, others writing events). You must be doing
> something wrong with that file descriptor in that other thread.

I also think so, but I don't see the mistake...

As the idea was to publish this under GPL3 anyway, I've uploaded my=20
early development state:

https://github.com/M-Reimer/pspaddrv

To give a short overview:

The relevant ones are:

device-handler.c
----------------
contains the actual handling thread functions

  > DeviceHandlerThreadUSB
      is called from main.c. Contains the "Sending main loop"
      and starts a second thread in
  > DeviceHandlerThreadRumble
      which actually does the rumble stuff and contains the
      "Receiving main loop"

uinput.c
--------
contains the uinput init function and the sending function which sends=20
one block of xbox button data at once without any prefiltering.


The code files, probably not relevant for this problem are:

main.c
------
starts the device handling threads (probably not relevant for my proble=
ms)

ps[34]-device.c
---------------
contain the gamepad interaction

usb.c
-----
some libusb helper functions


Would be great if someone could have a look at this and maybe give me a=
=20
hint about what could be the problem.

To test the code, an PS3 or PS4 gamepad is needed and the rumble stuff=20
actually needs to be commented out. If done so, this driver can be used=
=20
to emulate an XBox 360 gamepad with an PS3 or PS4 gamepad.

Thanks in advance

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
