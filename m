From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID Output and Feature Reports
Date: Fri, 8 Jun 2012 10:26:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206081024000.12208@pobox.suse.cz>
References: <CAAngNMZDfgcaf+pO+Lx=c+BLYCXKWP5k4bUKhmTyiiheiUH+3A@mail.gmail.com> <CANq1E4RhVzukWTTQLykSa9aMCNuUkOk6BBKYu5jhOTHtDX8EqQ@mail.gmail.com> <CAAngNMa1EZN-U5MZ6kwMJbUs0F2v-3A3UyaSz8+v1Uy6+BMLrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57918 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab2FHI0k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jun 2012 04:26:40 -0400
In-Reply-To: <CAAngNMa1EZN-U5MZ6kwMJbUs0F2v-3A3UyaSz8+v1Uy6+BMLrg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org, Claudio Takahasi <claudio.takahasi@openbossa.org>, Andre Guedes <andre.guedes@openbossa.org>

On Tue, 29 May 2012, Joao Paulo Rechi Vita wrote:

> > I think the new generic HID battery-detection code uses the
> > feature-reports. However, its disabled by default if I remember
> > correctly.
> 
> I will check this out, thanks for the hint.

Yes, battery power level is one place where feature reports are currently 
being used.

There are also several devices that need specific feature report to be 
sent to them in order to be able to use them at all (initialization). 
Magicmouse, to name another example, uses feature report to switch it 
between singletouch and multitouch modes. Etc.

-- 
Jiri Kosina
SUSE Labs
