From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: HID: hid-multitouch: Switch to device groups
Date: Wed, 8 Aug 2012 21:07:58 +0300
Message-ID: <20120808180758.GC3734@mwanda>
References: <20120808134408.GA25857@elgon.mountain>
 <20120808172829.GA1001@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:28829 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030507Ab2HHSIN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 14:08:13 -0400
Content-Disposition: inline
In-Reply-To: <20120808172829.GA1001@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Wed, Aug 08, 2012 at 07:28:29PM +0200, Henrik Rydberg wrote:
> Hi Dan,
> 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 4fa3a5837b84: "HID: hid-multitouch: Switch to device 
> > groups" from May 1, 2012, leads to the following Smatch complaint:
> > 
> > drivers/hid/hid-multitouch.c:735 mt_probe()
> > 	 error: we previously assumed 'id' could be null (see line 694)
> 
> Yes, and the same patch also removes the reason 'id' could be null.

Great.  Could you remove the unneeded check in mt_probe() and give
me a Reported-by: tag?

regards,
dan carpenter

