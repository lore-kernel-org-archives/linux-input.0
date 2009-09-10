From: Max Sivkov <maxsivkov@gmail.com>
Subject: Re: input subsystem question
Date: Thu, 10 Sep 2009 18:15:18 +0000 (UTC)
Message-ID: <loom.20090910T195819-563@post.gmane.org>
References: <loom.20090910T101706-918@post.gmane.org> <20090910165628.CA47F526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46464 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbZIJSPk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2009 14:15:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MloBK-0002gF-Hk
	for linux-input@vger.kernel.org; Thu, 10 Sep 2009 20:15:42 +0200
Received: from 212.90.160.210 ([212.90.160.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 20:15:42 +0200
Received: from maxsivkov by 212.90.160.210 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 20:15:42 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov <at> gmail.com> writes:

> 
> Hi Max,
> 
> On Thursday 10 September 2009 01:20:02 am Max Sivkov wrote:
> > Hello!
> > I have a question about using of the input subsystem.
> > Is there any way to filter input messages from a device (keyboard). I.e. I
> > need to have ability to pass some messages from the device, and block
> > others. Could community point me to the right place where I can find how to
> > do that?
> 
> There are different options, we'd need more context...
> 


Dmitry,

Thanks for the response.

Driver/user mode daemon should get scancodes (events) from the input device
(keyboard), detect particular scancodes and put them to the internal buffer to
send to the user space later time.

I'm stucked here, because after getting event from the input subsystem I will
need to remove the event from the input queue. 
As I understood events mechanism is useful if one needs to gather input event's
(keylogger) w/o modifying input queue.

Currently my driver for 2.6.x kernels is based on a atkbd driver with some
modifications, but this method has one big disadvantage: when input subsystem
developers change something in the input subsystem I have to do the annoying job
once again (take atkbd.c, add my functionality, rebuild kernel, etc, etc).



