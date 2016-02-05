From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: uinput: How to use force feedback?
Date: Fri, 5 Feb 2016 16:54:50 +0100
Message-ID: <n92gka$1fj$1@ger.gmane.org>
References: <n7g4s1$i1l$1@ger.gmane.org>
 <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52243 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073AbcBEPy7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 10:54:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aRiio-0004Ow-Ap
	for linux-input@vger.kernel.org; Fri, 05 Feb 2016 16:54:58 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 16:54:58 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 16:54:58 +0100
In-Reply-To: <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 01/17/2016 04:46 PM, Elias Vanderstuyft wrote:
> Concerning this,
> the following may give you an example how to read incoming FF events on uinput:
> https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341

Tried that and I'm pretty close to giving up...

I've added the following to my uinput init function:

   // Set up force feedback parameters
   ret = ioctl(fd, UI_SET_EVBIT, EV_FF);

   ret = ioctl(fd, UI_SET_FFBIT, FF_PERIODIC);
   ret = ioctl(fd, UI_SET_FFBIT, FF_RUMBLE);
   ret = ioctl(fd, UI_SET_FFBIT, FF_GAIN);
   ret = ioctl(fd, UI_SET_FFBIT, FF_SQUARE);
   ret = ioctl(fd, UI_SET_FFBIT, FF_TRIANGLE);
   ret = ioctl(fd, UI_SET_FFBIT, FF_SINE);

 From my device handling thread, I'm starting a separate thread to 
handle the opposite direction of communication. Plan is to do blocking 
read from the open uinput device. I open the device with O_RDWR to be 
able to read and write. The "rumble thread" starts with:

   pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
   pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

   struct input_event event;

   while (1) {
     ssize_t n = read(args->fduinput, &event, sizeof(event));
     printf("n: %d\n", n);

Everything beyond this never executes. The read blocks forever.

And even worse: If the read blocks, my "driver", and all programs 
connected to my input device, are deadlocked. No chance to kill them.

And to be honest: After three hours of debugging I'm kind of sick of 
rebooting my machine over and over again.

Any chance to get some hint?

Thanks in advance

Manuel

