From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 11:20:58 -0800
Message-ID: <20111115192058.GA13065@core.coreip.homeip.net>
References: <4EC10878.20109@edigma.com>
 <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com>
 <4EC15CD1.2010409@edigma.com>
 <201111141057.42310.dmitry.torokhov@gmail.com>
 <4EC23252.8030003@edigma.com>
 <20111115182331.GA6410@core.coreip.homeip.net>
 <4EC2B271.90209@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54186 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab1KOTVJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 14:21:09 -0500
Received: by eye27 with SMTP id 27so6068698eye.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 11:21:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC2B271.90209@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Tue, Nov 15, 2011 at 06:41:53PM +0000, Nuno Santos wrote:
> Generally we restrict access to sysfs attributes to root since they
> control behavior for all users, not only one why is changin sysfs
> attribute.
> 
> 
> Hummm... that leads me to a question. How can I make use of such
> attributes inside an application without having root access? Imagine
> that I open the control panel of the device in a user account, the
> contol panel itself will not have access to the attributes and it will
> not work. How do I overcome this problem?

Applications could register with ConsoleKit to elevate their privileges
if needed if they are running in a context of user logged onto local
console as opposed to someone logging in removely.

> 
> Imagine that my device is a soundcard and it has a beautifull control
> panel to control non general parameters. What would be the interface
> used by the control panel to access the kernel driver and modify the
> soundcard parameters?
> 

Beautful control panel does not normally even talk to sound card
directly but rather plugs into desktop environment infrastructure which
plugs into sound server inforastructure which in turn knows how to talk
to the hardware. Take a look at the sound mixer applet. As you can see
it actually exports only standard parameters and is pretty bland in this
regard (and this is a good thing - it supposed to work uniformly on all
hardware). The best way if advanved parameters have sensible defaults and
need not to be touched at all.

I guess here you see the difference between Linux and Windows views
because we actually do not want vendor-specific applets/tray
icons/utilities/etc but rather unified interface working for all
hardware in a given class.

Thanks.

-- 
Dmitry
