From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: PS4 controller with Bluetooth: Only the touch pad sends events?
Date: Sat, 23 Jan 2016 18:26:23 +0100
Message-ID: <n80d3v$qcj$1@ger.gmane.org>
References: <n8097h$uek$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34322 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcAWR0g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jan 2016 12:26:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aN1xK-0002X8-NO
	for linux-input@vger.kernel.org; Sat, 23 Jan 2016 18:26:34 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 23 Jan 2016 18:26:34 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 23 Jan 2016 18:26:34 +0100
In-Reply-To: <n8097h$uek$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

just a short follow up.

I've tested the controller directly on the PS3 console (don't own a PS4 
yet) and it works well there, which confirms that the controller is OK.

Then I searched around a bit and found:
https://bugzilla.kernel.org/show_bug.cgi?id=107081

Did this patch ever land here on the mailing list?

If not, I'll take over, have a look at reformatting the patch, test it 
with my PC and my PS4 controller and then send it to the list.

Thanks in advance

Manuel


On 01/23/2016 05:20 PM, Manuel Reimer wrote:
> Hello,
>
> I'm currently trying to get my PS4 controller to work via Bluetooth.
>
> My kernel is:
> $ uname -a
> Linux manuelspc 4.3.3-3-ARCH #1 SMP PREEMPT Wed Jan 20 08:12:23 CET 2016
> x86_64 GNU/Linux
>
> If I run "evtest" on the event device, created by the controller, then I
> only get events if the touch pad is touched. Even pressing the touch pad
> doesn't create a event and all other buttons and sticks don't send
> events either.
>
> What's the reason for this? If I connect via USB, I don't have any
> issues and all buttons and axis work well...
>
> Thank you very much in advance.
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


