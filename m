From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Wed, 10 Jun 2009 10:55:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906101053490.7457@wotan.suse.de>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com> <49E4E7E1.7040109@gmail.com> <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de> <4A2ED39B.30100@gmail.com> <alpine.LNX.2.00.0906101020400.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60366 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758228AbZFJIzS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 04:55:18 -0400
In-Reply-To: <alpine.LNX.2.00.0906101020400.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org, locoxella@gmail.com

On Wed, 10 Jun 2009, Jiri Kosina wrote:

> > > According to hid-ids.h, the ID 0x030c is a TDK mighty mouse. On my
> > > Alu-iMac (last year edition), it's a Apple's owned mighty mouse (vendor
> > > 0x05ac, ID 0x1000), which is not currently listed in hid-ids.h. My
> > > mighty mouse anyway runs o.k. with the "wrong" ID, but since the start
> > > withouth the mouse-wheel.
> > > It did not help when I changed the ID's accordingly. So my question is:
> > > Is there anything to be done in bluetooth driver area too to get this
> > > mighty mouse fully supported (some quirks needed)?
> Yes, 0x1000 is a different problem, the scrollwheel doesn't work there at 
> all (it isn't even described in the report descriptor).
> I currently have 0x05ac/0x1000 on my desk, I will look into it.

Unfortunately I don't have, it's a slightly different model, for which the 
scrollwheel works nicely.

So HID debugging output from 0x1000, both from the time the mouse is 
probed and when the non-working wheel is used would be welcome.

Thanks,

-- 
Jiri Kosina
SUSE Labs
