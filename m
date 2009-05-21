From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: A tablet driver question
Date: Thu, 21 May 2009 10:33:35 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905211029230.29030@twin.jikos.cz>
References: <7f83a3ba0905192149k338f3932u25e2d0f1b2d70e2f@mail.gmail.com>  <20090520051222.GA11638@kroah.com>  <7f83a3ba0905192316u4753fbefi37257a7e3d20f3ef@mail.gmail.com>  <4A13AEEC.7010707@gmail.com> <7f83a3ba0905200858l7f78e5c7s675fea46b4ceb1c5@mail.gmail.com>
 <4A142EC4.70202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44744 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbZEUIdi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 04:33:38 -0400
In-Reply-To: <4A142EC4.70202@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Steven Hunt <srhlefty@gmail.com>, Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org, linux-input@vger.kernel.org

On Wed, 20 May 2009, Jiri Slaby wrote:

> >>> Full output from 2.6.28-11-generic at device connect:
> >>> [ 1673.776066] usb 2-2: new low speed USB device using uhci_hcd and address 5
> >>> [ 1673.961620] usb 2-2: configuration #1 chosen from 1 choice
> >>> [ 1673.982901] generic-usb 0003:0B57:8019.0005: hiddev96,hidraw1: USB
> >>> HID v1.00 Device [HanWang co. HW Micro Drawing Tablet] on
> >>> usb-0000:00:1d.0-2/input0
> >> Hmm, It looks like it is a standard HID device and got registered in the
> >> input layer. Could you attach lsusb -v of that device and
> >> /proc/bus/input/devices?
> Actually I missed there is no "input" at 1673.982901, so the input is 
> not claimed. You still can read the events through hidraw (or via 
> deprecated hiddev).
> Jiri, any ideas? Looks like there are no useful applications. A report
> dump will tell us whether we can handle it through standard path (with
> forced connect) or it has to be handled by hidraw, am I correct?

Exactly. The device probably doesn't provide any applications that would 
pass through IS_INPUT_APPLICATION() macro (see include/linux/hid.h).

We might well be extending this definition, as it is quite outdated (and 
doesn't for example deal with new digitizers very well).

Report descriptor dump would absolutely be necessary (i.e. compiling the 
kernel with CONFIG_HID_DEBUG and modprobing the 'hid' module with 
'debug=2' parameter).

-- 
Jiri Kosina
SUSE Labs

