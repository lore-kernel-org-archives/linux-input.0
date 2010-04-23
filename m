From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port
	should	psmouse_probe	fail	before	retrying
Date: Fri, 23 Apr 2010 02:47:48 +0200
Message-ID: <1271983668.16254.44.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <4BCE17CC.8020804@canonical.com>
	 <20100421063328.GJ4364@core.coreip.homeip.net>
	 <4BCF2263.40306@canonical.com>
	 <20100421171055.GB10566@core.coreip.homeip.net>
	 <4BCF5453.5060703@canonical.com>
	 <20100421195238.GA10641@core.coreip.homeip.net>
	 <4BCF69CB.7010000@canonical.com> <1271953731.4566.27.camel@lovely>
	 <4BD0C425.5030609@canonical.com>
	 <20100422215517.GB28213@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:55273 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0DWAmS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 20:42:18 -0400
Received: by bwz25 with SMTP id 25so10396053bwz.28
        for <linux-input@vger.kernel.org>; Thu, 22 Apr 2010 17:42:16 -0700 (PDT)
In-Reply-To: <20100422215517.GB28213@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>

Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
> On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> > Hi,
> > 
> > This one is a winner. with regards to your follow up. I wouldn't
> > want to reset something unless we have cause to. This code
> > seems to be doing the right thing e.g. I see "unable to query
> > synaptics hardware" followed by it's (re)discovery on return
> > from S3.
> > 
> > When it's fully supported by the Synaptics driver, the initial
> > reconnect will succeed and we'll never get to this additional
> > failsafe code which is essentially a catch all for the bleeding
> > edge.
> >
> 
> I am confused here... what protocol does the kernel select upon fresh
> boot?

Peter's dmesg:

[    7.428561] Unable to query Synaptics hardware.

 It's plain PS/2 or IMPS/2 because this bleeding edge device fails somewehre
in synaptics_query_hardware(). Most likely the test on priv->identity.

[    8.239494] input: PS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input12

This is the normal KERN_INFO printk of input_register_device() which does
not mean that it's using the synaptics driver. "PS/2 Synaptics TouchPad"
is just the name of the device.

in conclusion:
 If a Synaptics touchpad can't be initialized (synaptics_init) and falls
back to PS/2, it doesn't get a psmouse_reset() after resuming from
suspend as it would get with a synaptics driver.




