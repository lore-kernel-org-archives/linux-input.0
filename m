From: Russell King <rmk@arm.linux.org.uk>
Subject: USB interrupt times
Date: Tue, 14 Aug 2012 11:39:36 +0100
Message-ID: <20120814103936.GA7105@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35188 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2HNKjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 06:39:44 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I've been trying to track down where all the CPU time goes while
processing USB interrupts for HID devices.  At the moment, out of
everything on the cubox, moving the mouse or even pressing a key
on the keyboard just once is far more expensive than processing an
interrupt for the network interface or handling the SDHCI port.
Handing HID actions weigh in at around 300-400us per USB interrupt.

Around two-thirds of the time for a USB HID device interrupt is
spent in the HID layer, currently tracked down to:

	for (a = 0; a < report->maxfield; a++)
		hid_input_field(hid, report->field[a], cdata, interrupt);

in hid_report_raw_event().

However, looking at hid_input_report() and its use of down_trylock(),
I'm wondering why we're trying to run this chunk of code in IRQ
context anyway?  Why not a tasklet or workqueue?

Any suggestions on why processing a key press or mouse movement is soo
expensive?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
