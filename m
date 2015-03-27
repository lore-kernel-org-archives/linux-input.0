From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: proposal for deletion of drivers/hid/hid-ids.h
Date: Fri, 27 Mar 2015 15:57:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503271554410.6781@pobox.suse.cz>
References: <1427370288.2075.19.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38514 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198AbbC0O5f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 10:57:35 -0400
In-Reply-To: <1427370288.2075.19.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, pavel@ucw.cz

On Thu, 26 Mar 2015, Oliver Neukum wrote:

> I would like to kill drivers/hid/hid-ids.h and replace it
> with numerical IDs in the files using it.
> 
> There are two reasons for that.
> 
> 1. It is a layering violation. There should not be a private
> data base for USB IDs in HID.

Not really; it's not limited to USB IDs.

> 2. It serves no purpose and adds work. Anyone who adds a quirk or a 
> special case for devices needs to operate on the numbers, as those are 
> what he gets from the descriptors. Looking up or adding a symbolic name 
> for a device is just more work without a benefit. These numbers have no 
> intrinsic meaning beyond being unique and it rarely matters (and should 
> not matter) for which vendor a particular fix is intended.
> 
> In the rare cases it does matter when it does matter searching the 
> official list of USB IDs is less work.
> 
> So let's kill this utterly useless step of indirection.

I know that there are some really useless cases (e.g. the ones which don't 
add any extra information, and just do "VENDOR_<PID>" to construct the 
string). But I personally like to see at least the vendor IDs as a string, 
so that I am immediately identify behavior for particular vendors when 
looking at the code.

I am not *forcing* everybody to add entry to hid-ids.h for each and every 
quirk he is adding, but I guess I'd rather insist to have at least vendor 
IDs there.

Thanks,

-- 
Jiri Kosina
SUSE Labs
