From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] Input: force feedback - potential integer wrap in
 input_ff_create()
Date: Mon, 10 Oct 2011 23:48:30 +0300
Message-ID: <20111010204830.GV30887@longonot.mountain>
References: <20111009162524.GA14049@elgon.mountain>
 <20111010050852.GA18794@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:33965 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1JJUvU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 16:51:20 -0400
Content-Disposition: inline
In-Reply-To: <20111010050852.GA18794@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Oct 09, 2011 at 10:08:52PM -0700, Dmitry Torokhov wrote:
> Instead of doing this why don't we mark all relevant fields as unsigned
> int?
> 

Sure.  We'd still have to check for wrapping on 32bit I think...

I'll sent a patch for this tomorrow.

regards,
dan carpenter

