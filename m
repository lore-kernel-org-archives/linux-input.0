From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 2 Dec 2007 23:07:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712022300490.13260@jikos.suse.cz>
References: <4752DB8C.50608@rtr.ca> <4752E432.10504@rtr.ca>
 <Pine.LNX.4.64.0712021903460.12208@twin.jikos.cz> <4752F6C7.4040904@rtr.ca>
 <Pine.LNX.4.64.0712021918500.13260@jikos.suse.cz> <4752FE11.2050200@rtr.ca>
 <4752FEFE.3000600@rtr.ca> <Pine.LNX.4.64.0712022007360.13260@jikos.suse.cz>
 <47530680.6020206@rtr.ca> <Pine.LNX.4.64.0712022025250.13260@jikos.suse.cz>
 <47530B32.7080502@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58477 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751103AbXLBWH1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 17:07:27 -0500
In-Reply-To: <47530B32.7080502@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rubini@vision.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-usb-devel@lists.sourceforge.net

[ linux-usb-devel added to CC ]

On Sun, 2 Dec 2007, Mark Lord wrote:

> Okay.  I've got to leave the computer for a while now, so I'll post 
> again whenever I have something new here.

Thanks. To sum up this longish thread:

- 2.6.24-rcX exposes the problem with sometimes multiple clicks being 
  generated as a response for one click on USB mouse (evtest shows that 
  really mutliple LeftBtn events arrive). 2.6.23 behaves correctly
- reverting the state of drivers/hid to 2.6.23 state doesn't make the 
  problem go away, so the problem is elsewhere (Input? USB?)
- Mark seems to be able to reproduce the problem quite easily; I was not 
  successful reproducing this no matter how hard I tried, and I also 
  didn't receive any similar bugreports from anyone else
- we are currently waiting for Mark to provide HID_DEBUG (and preferably
  also usbmon) output from the situation where multiple clicks are 
  being generated incorrectly

-- 
Jiri Kosina
SUSE Labs
