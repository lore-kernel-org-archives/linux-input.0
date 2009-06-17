From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 16:47:53 -0400
Message-ID: <4A395679.1070607@seas.upenn.edu>
References: <4A385751.8000904@seas.upenn.edu> <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:55886 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbZFQUr5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 16:47:57 -0400
In-Reply-To: <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, brysgo@gmail.com, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

> TBH, this is not a big loss to me personally, because:
>  - so far I had not been able to give the appropriate Xmax and Ymax
> parameters to the Wacom Xorg driver, so the pointer was badly warped and
> this was pretty useless anyway.

Certainly early on, I was not able to get the wacom to accept the the ranges for the touch device, so I just put the values in my
xorg.conf and have not looked back.  I think the limitation was in the userspace driver, not the device or kernel space.  It was
getting the correct parameters for the pen input device.

> I guess the whole issue is to try and understand what will be the most
> popular uses of this device:
>  - with which version of the firmware? the one with stylus and single
> touch? the one with multitouch but no stylus?
>  - as a touch screen? as a pen computer?

It would be really nice if we could get ntrig to weigh in on the firmwares.  At this point we have no way to know what the real
limitations are.  It would be really nice of them to provide a firmware that gives maximal functionality.  Perhaps they ran into
some design flaws which they are still trying to work around.

Anyone out there have any experience extracting firmware from windows drivers?  And if we do get the raw firmware, how do we load it?

> Leaving aside the pain of having incompatible versions of the firmware
> around, it looks this type of dual device (stylus + finger) challenges
> the way linux-hid, linux-input and Xorg regard touch devices: yes,
> something that looks like a touchscreen can be a digitizer too... Maybe
> we should create two Linux devices, one for the stylus and one for fingers?

On the surface, I like the idea of separate devices.  But if we still have to deal with the different fingers in user space, does it
make more sense to just use the same code to differentiate the pen?
