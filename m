From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick: make USB drivers depend on USB
Date: Thu, 18 Jan 2018 10:54:05 -0800
Message-ID: <20180118185405.gd4ynka2o5fhovhy@dtor-ws>
References: <20180117213010.810-1-marcus.folkesson@gmail.com>
 <20180117215316.7qe5o2pspb3dqgny@dtor-ws>
 <bbdfcd99-8a2b-d04a-ae3f-a0cac50d312a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42954 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeARSyI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 13:54:08 -0500
Content-Disposition: inline
In-Reply-To: <bbdfcd99-8a2b-d04a-ae3f-a0cac50d312a@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 10:25:21AM -0800, Randy Dunlap wrote:
> On 01/17/2018 01:53 PM, Dmitry Torokhov wrote:
> > On Wed, Jan 17, 2018 at 10:30:10PM +0100, Marcus Folkesson wrote:
> >> A driver should not enable an entire subsystem.
> > 
> > I disagree. As you go through menuconfig and you encounter this option
> > and you have the hardware and you want to enable it, you should be able
> > to do so. Otherwise you enable bunch of functionality, then go back,
> > see what new options appeared, enable them, go back, see if any more new
> > options appeared, and so on.
> 
> I've been thinking about this.  If a user is using a distro .config file,
> it most likely has USB support already enabled, so the description above will
> not apply to them.  If they are using some kernel-supplied defconfig file,
> I still think that the description above will not apply to them since those
> defconfig file will most likely have USB enabled if the target platform supports
> USB.  And if they are using some .config file that does not have USB support
> enabled, it could be that way for a very good reason.  If the target platform
> does not support USB but the user enables (sets) JOYSTICK_XPAD (which selects
> USB) but then their device does not work, they will be both disappointed and
> confused.

You mean their system has USB ports to plug in the XPAD but the target
platform does not support USB? I doubt that happens, but it is supposed
to be handled by "depends on USB_ARCH_HAS_HCD". If platform definitely
does not have a host controller, then we'll hide drivers for USB
devices.

> 
> Anyway, I don't think that users will face the problem that you described
> very often.  But I understand what you are saying also.

Yeah, I do not think we have a good config language/tools that allows
easily turn on/off features, it's all different tradeoffs. Given that we
had this "select USB/depends on USB_ARCH_HAS_HCD" for close to 10 years
now, I'd prefer leaving it alone.

Thanks.

> 
> 
> > What exactly prompted this change?
> > 
> >>
> >> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >> ---
> >>  drivers/input/joystick/Kconfig | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> >> index 332c0cc1b2ab..4a199cff8c68 100644
> >> --- a/drivers/input/joystick/Kconfig
> >> +++ b/drivers/input/joystick/Kconfig
> >> @@ -279,8 +279,7 @@ config JOYSTICK_JOYDUMP
> >>  
> >>  config JOYSTICK_XPAD
> >>  	tristate "X-Box gamepad support"
> >> -	depends on USB_ARCH_HAS_HCD
> >> -	select USB
> >> +	depends on USB
> >>  	help
> >>  	  Say Y here if you want to use the X-Box pad with your computer.
> >>  	  Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYDEV)
> >> -- 
> >> 2.15.1
> >>
> > 
> 
> 
> -- 
> ~Randy

-- 
Dmitry
