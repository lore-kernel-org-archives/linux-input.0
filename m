From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Mon, 16 Jul 2012 21:08:47 +0200
Message-ID: <CANq1E4Q2AoA7JP9rL39gEkyMCy+-a3vcysn_kWOdB8Z4okAf+A@mail.gmail.com>
References: <20120716184530.GA407@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46430 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab2GPTIt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 15:08:49 -0400
Received: by weyx8 with SMTP id x8so4167825wey.19
        for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 12:08:47 -0700 (PDT)
In-Reply-To: <20120716184530.GA407@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Henrik

On Mon, Jul 16, 2012 at 8:45 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi David,
>
> Perhaps one should make hid-core warn instead of bailing out instead?
> Something may need to be done to make sure everything works smoothly,
> but really, why would hid-core mind keeping a device on the bus with a
> non-standard io driver?

No, I think bailing out is the correct thing to do. If we emit a
warning but leave the device on the bus, the device will have no
driver loaded and idling in background. Hence, dropping the device is
the best solution for 99% of the devices.

However, devices that explicitly do not require the generic drivers
(like picolcd and wiimote) should be able to stay on the bus. We could
of course put them out of the HID subsystem as they have very little
in common with the other HID drivers, but that wouldn't make the
situation any better. It would mean writing transport-level drivers
for picolcd and wiimote which are exactly the same as USBHID and HIDP.
Hence, I think allowing non-standard drivers on the BUS is ok as long
as they explicitly request it.

Thanks
David
