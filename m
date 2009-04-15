From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Wed, 15 Apr 2009 10:23:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca> <200904140945.14652.dmitry.torokhov@gmail.com> <49E4C9CF.5060504@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43514 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131AbZDOIXv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 04:23:51 -0400
In-Reply-To: <49E4C9CF.5060504@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 14 Apr 2009, Mark Lord wrote:

> > I think if you take drivers/hid/hid-belkin.c as a template the 
> > conversion will take you no time.
> Okay, I can have a look at that one.  Thanks.

Yes, hid-belking is a good example of trivial driver that sits on a HID 
bus for you, as it utilizes the ->input_mapping() callback, which is 
probably the only callback from HID core you'd need.

If you encounter any difficulties implementing your driver as a HID bus 
driver, please let me know.

-- 
Jiri Kosina
SUSE Labs
