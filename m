From: Tommy Will <tommywill2011@gmail.com>
Subject: Fwd: FW: Dell Latitude E7440 - ALPS touchpad keeps having state reset
Date: Fri, 7 Feb 2014 15:46:48 +0800
Message-ID: <CA+F6ckMmWEikbm=chDSqPQp7TfL8bYi8rKwdA40eLbxq7FQxog@mail.gmail.com>
References: <373dee7dc0664723a28e543c240fdce1@SINPR04MB282.apcprd04.prod.outlook.com>
	<CA+F6ckM4gTBAE5Z3ymc=V8Oo73CV4p5tRTCZYMMVi2+3SK+U6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:58031 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaBGHqt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Feb 2014 02:46:49 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so2361806lbv.34
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 23:46:48 -0800 (PST)
In-Reply-To: <CA+F6ckM4gTBAE5Z3ymc=V8Oo73CV4p5tRTCZYMMVi2+3SK+U6g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: allan@amcone.net
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Allan,

This is Tommy from ALPS. Thanks for your contact and so sorry for my
overlooking your last week's mail.

> I've reported the problem I'm having in more detail here:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1258837
>
> In summary - I keep suffering from the mouse pointer jumping around erratically, with the following messages output to syslog:
>  psmouse serio1: DualPoint TouchPad at isa0060/serio1/input0 lost sync at byte 1  psmouse serio1: DualPoint TouchPad at isa0060/serio1/input0 - driver resynced.
>
> Other people have reported the same problem in that bug report.
> Bisecting the kernel, the problem seems to have always been in place as soon as the touchpad was correctly identified; according to xinput
> - it's a "AlpsPS/2 ALPS DualPoint TouchPad". When it was being identified as a generic PS/2 mouse, there's no problem (though of course, there's also no touchpad functionality available either).
>

It seems that with the latest kernel, your touchpad became crazy
erratically and almost cannot use?
It looks like that our kernel driver did not let touchpad enter the
correct mode or did not use the correct way to decode the raw data.

>From another mail sent by Vasily, he met the same issue with touchpad
on Dell E7440 as yours.
According to his touchpad info "E7: 73-03-0A EC: 88-08-22", I think we
can start the investigation.
Please give me some time and I'll feedback you later. Thanks!

--
Best Regards,
Tommy
