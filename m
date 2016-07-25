From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Mon, 25 Jul 2016 13:05:47 +0200
Message-ID: <20160725130547.6c9b80c23fef6dfe50ad9979@ao2.it>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
	<20160718142837.GK4663@mail.corp.redhat.com>
	<78cafd15-850f-3110-f63e-bb41f6b69c5c@kapsi.fi>
	<20160721183439.3edddbc6312555afda517f8c@ao2.it>
	<20160725091404.GD19383@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ao2.it ([92.243.12.208]:51256 "EHLO ao2.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcGYLFy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 07:05:54 -0400
In-Reply-To: <20160725091404.GD19383@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On Mon, 25 Jul 2016 11:14:04 +0200
Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> On Jul 21 2016 or thereabouts, Antonio Ospite wrote:
[...]
> > It would be interesting to understand why some (supposedly) compatible
> > devices break, maybe they rely on the fact that the PS3 would use the
> > original report?
> 
> [just speculating]
> I would be *really* surprised if the Sony software were to overwrite the
> report descriptor of their own sony controllers. My guess is that their
> HID stack or their Playstation driver is compatible with the original
> report descriptors and so they can handle the differences between
> original and weirdo controllers.
> 

That's basically what I was thinking too, in my last sentence I meant
to write report _descriptor_ :)

Mikko, if you have some time, could you post the original report
descriptor for your device?

$ hexdump /sys/bus/hid/devices/XXXX\:YYYY\:ZZZZ.0001/report_descriptor

or

$ hidrd-convert -i natv -o code /sys/bus/hid/devices/XXXX\:YYYY\:ZZZZ.0001/report_descriptor

You can also find out the length of the raw output report with trial and
error, start with a line like this:

$ sudo hexdump -v -e '49/1 "%02x " "\n"' /dev/hidraw0

and increase/decrease the value (49 works with original controllers)
until you see a regular pattern when comparing lines.

Anyways this is just for curiosity, we are not going to spend too much
time on that... or are we? :)

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
