From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port
 =?iso-8859-15?q?should=09psmouse=5Fprobe=09fail=09before=09retrying?=
Date: Fri, 23 Apr 2010 09:53:51 -0700
Message-ID: <201004230953.52447.dmitry.torokhov@gmail.com>
References: <1271723857.6652.6.camel@lovely> <20100422215517.GB28213@core.coreip.homeip.net> <1271983668.16254.44.camel@lovely>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48934 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0DWQyB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Apr 2010 12:54:01 -0400
Received: by pxi17 with SMTP id 17so940140pxi.19
        for <linux-input@vger.kernel.org>; Fri, 23 Apr 2010 09:54:00 -0700 (PDT)
In-Reply-To: <1271983668.16254.44.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
> Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
> > On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> > > Hi,
> > > 
> > > This one is a winner. with regards to your follow up. I wouldn't
> > > want to reset something unless we have cause to. This code
> > > seems to be doing the right thing e.g. I see "unable to query
> > > synaptics hardware" followed by it's (re)discovery on return
> > > from S3.
> > > 
> > > When it's fully supported by the Synaptics driver, the initial
> > > reconnect will succeed and we'll never get to this additional
> > > failsafe code which is essentially a catch all for the bleeding
> > > edge.
> > 
> > I am confused here... what protocol does the kernel select upon fresh
> > boot?
> 
> Peter's dmesg:
> 
> [    7.428561] Unable to query Synaptics hardware.
> 
>  It's plain PS/2 or IMPS/2 because this bleeding edge device fails
> somewehre in synaptics_query_hardware(). Most likely the test on
> priv->identity.

Ah, I missed that. Peter, could you boot with i8042.debug so we could see 
where exactly Synaptics detection fails?

> 
> [    8.239494] input: PS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input12
> 
> This is the normal KERN_INFO printk of input_register_device() which does
> not mean that it's using the synaptics driver. "PS/2 Synaptics TouchPad"
> is just the name of the device.
> 
> in conclusion:
>  If a Synaptics touchpad can't be initialized (synaptics_init) and falls
> back to PS/2, it doesn't get a psmouse_reset() after resuming from
> suspend as it would get with a synaptics driver.

Yes, you are right. Maybe we should just reset psmouse unconditionally in 
psmouse_reconnect() before actually doing any protocol reconnect/reprobe. That 
should help in cases when users not enable Synaptics support; also it is 
probably unlikely that mouse that was there gets unplugged after resume.

-- 
Dmitry
