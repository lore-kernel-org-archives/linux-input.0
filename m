From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Pull USB plug while fftest on PS4 pad --> Kernel panic
Date: Sun, 7 Feb 2016 15:08:08 +0100
Message-ID: <n97j48$219$1@ger.gmane.org>
References: <n932md$odm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48420 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbcBGOIP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Feb 2016 09:08:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aSQ0b-0001OP-OS
	for linux-input@vger.kernel.org; Sun, 07 Feb 2016 15:08:13 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2016 15:08:13 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2016 15:08:13 +0100
In-Reply-To: <n932md$odm$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I did some more testing (now with a virtual machine).

I've updated to Kernel version 4.4.1. The problem stays the same.

Then I tried with a PS3 controller and (as somehow expected, as the same 
driver is involved), I have the same problem.

The kernel panic, directly after unplugging, only occured once, but the 
following is 100% reproducible:

- Open fftest and run some effect on the controller.
- Unplug the controller while fftest is still running. It doesn't matter 
if an effect is still playing.
- After doing so, plug *any* USB HID game controller, you like. I used 
some cheap noname controller. For me plugging whatever USB HID game 
controller finally crashes the kernel with 100% success rate.

So it seems to be the case, that the hid-sony module somehow breaks 
parts deeper in the USB HID stack in the kernel.

This problem doesn't occur with the xpad driver and a Xbox 360 gamepad, 
so it is no general problem which happens with every supported game 
controller.

Any feedback would be nice. Am I in the right mailing list for bug reports?

Thanks in advance.

Best regards,

Manuel


On 02/05/2016 10:03 PM, Manuel Reimer wrote:
> Hello,
>
> I'm currently using the following Kernel version:
> Linux manuelspc 4.3.3-3-ARCH #1 SMP PREEMPT Sun Jan 24 10:28:30 CET 2016
> x86_64 GNU/Linux
>
> While testing with force feedback, I found the following bug which makes
> it impossible to disconnect the PS4 controller while some "force
> feedback user" (may also be a game) is still running.
>
> To reproduce, connect a PS4 controller via USB. Now run "fftest" on it
> and choose effect number "0".
>
> While the effect still runs, pull the USB plug.
>
> Result: The kernel panics. Had to hard-reset the machine.
>
> Is it OK to just report this here or should I open a bug on Bugzilla for
> that?
> If more information is needed, just ask.
>
> Best regards,
>
> Manuel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


