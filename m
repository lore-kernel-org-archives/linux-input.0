From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch for 2.6.29? 3/3] psmouse/synaptics: ensure we reset the
	device on resume
Date: Wed, 4 Mar 2009 22:31:33 -0800
Message-ID: <20090305063129.GA14884@dtor-d630.eng.vmware.com>
References: <200903042010.n24KAu9G029857@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:55584 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbZCEGbu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Mar 2009 01:31:50 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2427727yxm.1
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2009 22:31:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200903042010.n24KAu9G029857@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, apw@canonical.com, arjan@infradead.org, jkosina@suse.cz

On Wed, Mar 04, 2009 at 12:10:55PM -0800, akpm@linux-foundation.org wrote:
> From: Andy Whitcroft <apw@canonical.com>
> 
> When resuming from suspend newer Synaptics touchpads do not recover
> correctly.  Analysis of the resume sequence as applied in Linux was
> compared to that of other operating systems.  This indicated that the
> other OSs were resetting the mouse before attempting to detect it (for
> all Synaptics touchpads, old and new).  Applying this same modification
> fixes these newer Synaptics touchpads and brings the driver into line
> with common OS reset behaviour.
> 
> This patch adds this reset by default providing a module option to
> restore the previous non-reset behaviour:
> 
> 	psmouse.synaptics_resume_reset=N
> 
> Also a message is emmitted on resume hinting as to how to fix a broken
> touchpad.
> 
> [akpm@linux-foundation.org: make message more informative, fix 80-cols]

Andrew,

Please drop this one. I have committed a bit different version of the
same and it is now in mainline.

Thanks.

-- 
Dmitry
