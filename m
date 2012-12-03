From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Mon, 3 Dec 2012 14:17:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com> <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57451 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab2LCNR3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2012 08:17:29 -0500
In-Reply-To: <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Linux Input <linux-input@vger.kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Mon, 26 Nov 2012, Benjamin Tissoires wrote:

> It is clear that the goal is to make commit
> 4ea5454203d991ec85264f64f89ca8855fce69b0 less restrictive.
> The problem is that this commit stops any communication with the
> device, even configuration communication.
> 
> Logitech devices use their own protocol on top of the HID standard
> protocol. For touch devices, this proprietary protocol requires to ask
> the device for axis ranges, etc...
> 
> So here, the idea is not to open the can of worm for every hid devices
> through hw_start() / hw_stop() calls, I think the idea of Andrew is
> just to allow hid-logitech-dj to get rid of this restriction in some
> particular circumstances.
> Consider this as a controlled backdoor of the can of worms :)

I have been thinking for this for a while, and I wasn't able to come up 
with anything I'd personally consider substantially better aproach than 
splitting the lock. So I don't have strong objections at the very moment.

This will also allow us to get rid of what commit 596264082f introduced in 
unifying driver, right? (adding Nestor to CC).

-- 
Jiri Kosina
SUSE Labs
