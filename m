From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Thu, 03 Dec 2009 13:15:23 +0100
Message-ID: <87zl60s17o.fsf@macbook.be.48ers.dk>
References: <20091203050810.GA26595@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:44608 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZLCMWO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 07:22:14 -0500
In-Reply-To: <20091203050810.GA26595@barra.bne.redhat.com> (Peter Hutterer's
	message of "Thu, 3 Dec 2009 15:08:10 +1000")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Hutterer <peter.hutterer@redhat.com> writes:

 Peter> These touchscreens are mounted onto HP TouchSmart and the Dell
 Peter> Studio One 19. Without a quirk they report a wrong button set
 Peter> and the x/y coordinates through ABS_Z/ABS_RX, confusing the
 Peter> higher levels (most notably X.Org's evdev driver).

What exactly does this fix? I've been using NW touchscreens for a while
and don't recall any issues (admittedly only used it with evtouch).

-- 
Bye, Peter Korsgaard
