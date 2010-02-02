From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [RFC][PATCH] HID: add NOGET quirk for Prodige Cordless Combo
Date: Tue, 2 Feb 2010 21:49:36 +0200
Message-ID: <20100202194936.GA14134@shisha.kicks-ass.net>
References: <1265129012-6023-1-git-send-email-virtuoso@slind.org>
 <alpine.LNX.2.00.1002022033340.15395@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:58022 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495Ab0BBT6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Feb 2010 14:58:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002022033340.15395@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Feb 02, 2010 at 08:34:04 +0100, Jiri Kosina wrote:
> On Tue, 2 Feb 2010, Alexander Shishkin wrote:
> 
> > I happen to own a keyboard identified as 05af:3062 which is labeled as
> > "FlatX Coldless Combo" by "Prodige", which exhibits input problems without
> > NOGET quirk. For some reason, lsusb reports this device as "Jing-Mold
> > Enterprise Co., Ltd", which is not mentioned anywhere on the package.
> > A quick search on the intenet shows that there a other people who have
> > this in their lsusb output, but apparently they don't have the problem
> > I am seeing (or they are not such furious typists as myself).
> 
> Out of curiosity, what behavior does the device in question exhibit 
> without the quirk?

The "0" key does not send anything, but instead, when I press "P" or "S"
and then without releasing press any other key, it sends that letter and
then a keypress for "0", which stays on up until I press something else.
Also, when I plug the receiver in, it immediately sends the same keypress
for "0" until the first actual keystroke. Or at least that's how I see it
in console or X (checked with xev).

Regards,
--
Alex
