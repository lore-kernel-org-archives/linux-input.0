From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Mon, 16 Jul 2012 21:35:02 +0200
Message-ID: <20120716193502.GA617@polaris.bitmath.org>
References: <20120716184530.GA407@polaris.bitmath.org>
 <CANq1E4Q2AoA7JP9rL39gEkyMCy+-a3vcysn_kWOdB8Z4okAf+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:34435 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2GPTeS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 15:34:18 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 6203BD656
	for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 21:34:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANq1E4Q2AoA7JP9rL39gEkyMCy+-a3vcysn_kWOdB8Z4okAf+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, Jul 16, 2012 at 09:08:47PM +0200, David Herrmann wrote:
> Hi Henrik
> 
> On Mon, Jul 16, 2012 at 8:45 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> > Hi David,
> >
> > Perhaps one should make hid-core warn instead of bailing out instead?
> > Something may need to be done to make sure everything works smoothly,
> > but really, why would hid-core mind keeping a device on the bus with a
> > non-standard io driver?
> 
> No, I think bailing out is the correct thing to do. If we emit a
> warning but leave the device on the bus, the device will have no
> driver loaded and idling in background. Hence, dropping the device is
> the best solution for 99% of the devices.

If the driver that picks up the device (wiimote for instance) decides
it does not want to use any of the io drivers (HID_CONNECT*) by
calling hid_hw_start(hdev, 0), in what way is that different from
calling it with, say, hid_hw_start(hdev, HID_CONNECT_TO_OTHER)?  (The
latter would be an equivalent (but cleaner) way of setting your
HID_CLAIMED_OTHER flag).

To catch possible mistakes, one could check for the presence of
raw_event() instead, for instance.

What I am getting at is that we really do not need to create any more
backdoors into the hid core - on the contrary, we can most likely
easily remove some of them instead.

> However, devices that explicitly do not require the generic drivers
> (like picolcd and wiimote) should be able to stay on the bus. We could
> of course put them out of the HID subsystem as they have very little
> in common with the other HID drivers, but that wouldn't make the
> situation any better. It would mean writing transport-level drivers
> for picolcd and wiimote which are exactly the same as USBHID and HIDP.
> Hence, I think allowing non-standard drivers on the BUS is ok as long
> as they explicitly request it.

Yes, the question is only what that request looks like. The simpler
the better, don't you agree?

Thanks,
Henrik
