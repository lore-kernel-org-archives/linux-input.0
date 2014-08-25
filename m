From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Mon, 25 Aug 2014 12:21:27 +0200
Message-ID: <1408962087.10300.15.camel@linux-fkkt.site>
References: <Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43211 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbaHYKV3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 06:21:29 -0400
In-Reply-To: <Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: vichy <vichy.kuo@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, 2014-08-22 at 14:23 -0400, Alan Stern wrote:
> On Sat, 23 Aug 2014, vichy wrote:
> 
> > from your patch, I have some questions:
> > a. in Alan's version, if both HID_CLEAR_HALT and HID_RESET_PENDING are
> > set, hid_reset will both "clear ep halt" and "reset devcie".
> > But in original one, even HID_CLEAR_HALT and HID_RESET_PENDING are
> > both set, hid_reset only do one of them.
> 
> Yes.  In my patch, the clear-halt handler will turn on the
> HID_RESET_PENDING bit if something goes wrong.  In that case we want to
> do both things.

Why? If we reset, why bother clearing a halt? Especially as this
may mean waiting the full 5 seconds for a timeout.

> > is there any special reason in original hid_reset to use below flow?
> >     if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
> >             xxxxx
> >     } else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
> >             xxxxxx
> >     }
> 
> No special reason.  We probably never thought that both flags would be
> set.

Yes. And I'd say if this ever happens HID_RESET_PENDING must have
priority and implicitly clears a halt.

	Regards
		Oliver



