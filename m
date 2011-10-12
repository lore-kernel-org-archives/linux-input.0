From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 17:16:51 +0100
Message-ID: <20111012161651.GA28601@srcf.ucam.org>
References: <201110121637.22442.oliver@neukum.org>
 <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36363 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab1JLQQz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 12:16:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, Oct 12, 2011 at 11:28:06AM -0400, Alan Stern wrote:

> Well, if the usage counter is 0 then you wouldn't want to call
> usb_put_interface_async().  On the other hand, if the usage counter is
> 0 then by definition the device isn't in use, so you shouldn't need to
> fail an autosuspend request -- not unless it races with an I/O event.

Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
than set flags that block suspend, it might make more sense to take 
references. It'd complicate things a little, in that we'd have to take 
more care in terms of keeping track of the state.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
