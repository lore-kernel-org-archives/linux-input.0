From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [appleir] BUG: unable to handle kernel NULL pointer dereference
Date: Wed, 06 Nov 2013 18:13:13 +0100
Message-ID: <1383757993.2554.0.camel@nuvo>
References: <20131029145139.GA2788@hercules>
	 <alpine.LNX.2.00.1311061635160.835@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47902 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3KFRNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Nov 2013 12:13:18 -0500
In-Reply-To: <alpine.LNX.2.00.1311061635160.835@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Luis Henriques <luis.henriques@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, James Henstridge <james.henstridge@canonical.com>, Fabien =?ISO-8859-1?Q?Andr=E9?= <fabien.andre@gmail.com>

On Wed, 2013-11-06 at 16:38 +0100, Jiri Kosina wrote:
> On Tue, 29 Oct 2013, Luis Henriques wrote:
> 
> > James has reported a NULL pointer dereference[1] on the appleir
> > driver.  From the bug report[2] it looks like it is 100%
> > reproducible using a 3.12-rc6 kernel simply by pressing any button on
> > the IR remote.
> > 
> > >From the stack trace, it looks like input_event is invoked with the
> > input_dev parameter set to NULL, which seems to indicate that
> > appleir_input_configured is never invoked.
> > 
> > Any ideas?
> > 
> > [1] https://launchpadlibrarian.net/154942024/macmini-oops.jpg
> > [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1244505
> 
> [ adding some more CCs ]
> 
> Okay, so apparently we didn't register with input, but only hiddev / 
> hidraw.
> 
> appleir 0003:05AC:8240.0005: hiddev0,hidraw4: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.3-2/input0
> 
> Therefore ->input_configured() callback has never been called, and thus we 
> oops due to appleir->input_dev being NULL when the first raw event is 
> reported.
> 
> Could you please provide report descriptor of the device?
> 
> The driver apparently relies on it being registered with hid-input, but 
> for some reason that doesn't happen.

FWIW, my original patch (and driver) was an input driver, not a hid one.
I'm not sure either how the new driver got tested.


