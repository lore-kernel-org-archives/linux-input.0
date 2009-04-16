From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Thu, 16 Apr 2009 11:24:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904161123180.13028@wotan.suse.de>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca> <200904140945.14652.dmitry.torokhov@gmail.com> <49E4C9CF.5060504@rtr.ca> <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
 <49E5EAD7.7000309@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36138 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZDPJYo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 05:24:44 -0400
In-Reply-To: <49E5EAD7.7000309@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 15 Apr 2009, Mark Lord wrote:

> > Yes, hid-belking is a good example of trivial driver that sits on a HID bus
> > for you, as it utilizes the ->input_mapping() callback, which is probably
> > the only callback from HID core you'd need.
> Actually, the input-mapping() alone won't do the job here.
> This Twinhan remote control sends single-byte codes for most buttons, 
> but some buttons send multi-byte codes, and we have to discard the 
> extraneous bytes somehow.

If the usages make it through the generic HID layer (depends on the report 
descriptor of the device), then just registering hid_driver with ->event() 
set to your callback and fixing this on the fly could be enough.

-- 
Jiri Kosina
SUSE Labs
