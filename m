From: Greg KH <greg@kroah.com>
Subject: Re: Logitech G13 driver + user-space libraries available
Date: Fri, 11 Dec 2009 11:04:30 -0800
Message-ID: <20091211190430.GB22482@kroah.com>
References: <d4690bfe19cee0dc8c5355a684fa7e09.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60677 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761133AbZLKTFE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 14:05:04 -0500
Content-Disposition: inline
In-Reply-To: <d4690bfe19cee0dc8c5355a684fa7e09.squirrel@intranet.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Linux <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

On Fri, Dec 11, 2009 at 10:24:52AM -0700, Rick L. Vinyard, Jr. wrote:
> Here's a first look at the G13 driver I've been playing around with:
>      git://g13.git.sourceforge.net/gitroot/g13/g13
> 
> I've been building the driver out-of-tree and this is my first (untested)
> shot at moving it in-tree. There are still a number of things to do (and
> clean up) in the driver but it is rather functional.
> 
> I'll test it later today and update the repo as necessary, but I thought
> I'd throw it out there now.

Nice, but sending a patch to review it is best, don't point people at a
random git tree and expect they will look at the code.

Also, please run the driver through the scripts/checkpatch.pl script,
and fix all of the things it reports, before submitting it.

thanks,

greg k-h
