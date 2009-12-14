From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Logitech G13 driver against torvalds/linux-2.6.git
Date: Mon, 14 Dec 2009 11:48:40 -0800
Message-ID: <20091214194840.GA7033@kroah.com>
References: <376bcd26469b6af1d9dda57fd9a1de19.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757405AbZLNTtM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <376bcd26469b6af1d9dda57fd9a1de19.squirrel@intranet.cs.nmsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Linux <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


Great first cut, but please:
	- your patch was linewrapped, please fix your email client to
	  not do that.
	- You did not provide a signed-off-by: line as required by the
	  file Documentation/SubmittingPatches
	- You did not provide a good changelog entry in the body of the
	  email explaining what this patch is, and what it does.
	- you did not cc: the HID maintainer, who is the proper person
	  to apply this patch.  Try using the script,
	  scripts/get_maintainer.pl to figure out who to send patches
	  to.
	- Can you run your patch through the scripts/checkpatch.pl
	  script and fix the errors and warnings it reports?  It would
	  have caught many of the above mentioned things.

Care to try again?

thanks,

greg k-h
