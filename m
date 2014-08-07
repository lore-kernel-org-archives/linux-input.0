From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 05/06] input synaptics-rmi4: Add firmware update
 support
Date: Wed, 6 Aug 2014 23:42:51 -0700
Message-ID: <20140807064251.GE651@core.coreip.homeip.net>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
 <1394675637-23853-5-git-send-email-cheiny@synaptics.com>
 <20140731175323.GB5631@core.coreip.homeip.net>
 <53DAAE5E.7030708@synaptics.com>
 <20140731211921.GA36491@core.coreip.homeip.net>
 <53DAB893.2070308@synaptics.com>
 <20140731215852.GB36491@core.coreip.homeip.net>
 <53E2BA1A.7000204@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36328 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaHGGm4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Aug 2014 02:42:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so4868025pad.11
        for <linux-input@vger.kernel.org>; Wed, 06 Aug 2014 23:42:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53E2BA1A.7000204@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Aug 06, 2014 at 04:28:26PM -0700, Christopher Heiny wrote:
> [I sent this last Thursday, but it never showed up on the input
> list. I'm assuming nobody else saw it.]
> 
> 
> On 07/31/2014 02:58 PM, Dmitry Torokhov wrote:
> >On Thu, Jul 31, 2014 at 02:43:47PM -0700, Christopher Heiny wrote:
> >>On 07/31/2014 02:19 PM, Dmitry Torokhov wrote:
> >>>On Thu, Jul 31, 2014 at 02:00:14PM -0700, Christopher Heiny wrote:
> >>>>>On 07/31/2014 10:53 AM, Dmitry Torokhov wrote:
> >>>>>>>Hi Christopher,
> >>>>>>>
> >>>>>>>On Wed, Mar 12, 2014 at 06:53:56PM -0700, Christopher Heiny wrote:
> >>>>>>>>>Add support for updating firmware on RMI4 devices with V5 bootloader.
> >>>>>>>
> >>>>>>>I am wondering why F34 is not following the staindard RMI function
> >>>>>>>implementation. By that I mean that it does not declare itself as struct
> >>>>>>>rmi_function_handler and does not rely on RMI core to bind itself to the device
> >>>>>>>if device supports it.
> >>>>>
> >>>>>Hi Dmitry,
> >>>>>
> >>>>>We originally had an F34 implementation that followed the RMI4
> >>>>>function standard and exposed most of the basic F34 operations via
> >>>>>sysfs. However, we got feedback (both on LKML and offline) (a)
> >>>>>recommending to use request_firmware, and (b) improve reflash times
> >>>>>while (c) reducing impact on boot time, and (d) "get rid of all that
> >>>>>sysfs crap" (paraphrased, but close to it).
> >>>>>
> >>>>>So after looking at how some other drivers use request_firmware, we
> >>>>>came up with the current approach.  Switching to request_firmware
> >>>>>definitely sped up the reflash times!  Including a check to see if
> >>>>>firmware update is required before setting up the RMI4
> >>>>>sensor/function structures also significantly reduced boot times.
> >>>
> >>>I am not suggesting you stop using request-firmware or introduce
> >>>bazillion of new sysfs attributes. I just wondered why you have manual
> >>>"binding" of F34 functionality instead of standrad RMI4 function
> >>>binding, liek you do for F01, F11 and so forth.
> >>
> >>Sorry!  My answer wasn't very clear on that part, was it?
> >>
> >>The manual binding gets the reflash (if required) done very early in
> >>the boot/probe process.  This eliminates the need to set up the
> >>whole sensor + functions structure, tear it down in order to
> >>reflash, and then build it all back up again.  It is felt that the
> >>time savings is significant, especially on highly featured products.
> >
> >I am sorry but I have hard time accepting this argument. How often do
> >you reflash devices during normal operation and how long does it take to
> >initialize the device compared to getting entire userspace up and
> >running to be able to actually supply or serve flash data (even without
> >using usermode helper to flash you need filesystem with the firmware to
> >be mounted)?
> 
> That was my argument exactly, but that was the direction we were
> pushed.  I'd much rather implement it as we discussed offline
> earlier this week.  If you were to say: "I'm sorry, but this simply
> can't be merged as it stands." you wouldn't get any argument from me
> on technical grounds. There might be people who will argue about the
> additional calendar time it would take to restructure it, though.

OK, then I will just say this: "I'm sorry, but this simply can't be merged as
it stands."

Now, I am talking about mainline here, I am fairly certain we can resolve
scheduling issues between what you currently have and what is needed in the
end.

Thanks.

-- 
Dmitry
