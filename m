From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 20/20] HID: hid-multitouch: Add missing contact count
 detection
Date: Mon, 3 Sep 2012 19:07:16 +0200
Message-ID: <20120903170716.GA811@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-21-git-send-email-rydberg@euromail.se>
 <CAN+gG=FwXaSWN_AYnU7Vpxn4GcWYG3Bf100P0QD_8cQfEnGc7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:59971 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2ICRBF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Sep 2012 13:01:05 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=FwXaSWN_AYnU7Vpxn4GcWYG3Bf100P0QD_8cQfEnGc7A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Unfortunately, this is not working. We have bad devices that present either:
> - a null logical_maximum (some Stantum do) -> the value 1 is assigned
> to maxcontacts, and the device is turned into a mono touch....
> - an obviously wrong value (with respect to the current state of the
> devices) -> Quanta devices report 255 there.... and they support only
> 2 touches....

This is really terrible :-) Ok, so let's set maxcontacts to 60 on the
3M class, that ought to work for all present devices, right?

> And of course, 3M decided to stop sending 60 touches on their recent
> devices: we have here a 0x506 device that present a contact_count of
> max 60, a maximum contact feature of max 60, but whatever I'm doing,
> it does not want to send more than 10 touches....

Odd indeed. Speaking of oddness, I have two patches for the Flatfrog
MT 3200, which 1) Uses more then 128 fields in the report descriptor
(ever seen that before?), and 2) Advertises axes that are not
used. But it does give 40 touches worth of awesomeness once quirked
properly. Will send shortly.

Thanks,
Henrik
