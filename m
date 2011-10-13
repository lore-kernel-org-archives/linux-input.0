From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch v2] Input: force feedback - potential integer wrap in
 input_ff_create()
Date: Wed, 12 Oct 2011 21:36:07 -0700
Message-ID: <20111013043607.GC11763@core.coreip.homeip.net>
References: <20111009162524.GA14049@elgon.mountain>
 <20111010050852.GA18794@core.coreip.homeip.net>
 <20111010204830.GV30887@longonot.mountain>
 <20111011211949.GB30887@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63097 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab1JMEgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 00:36:14 -0400
Content-Disposition: inline
In-Reply-To: <20111011211949.GB30887@longonot.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Oct 12, 2011 at 12:19:49AM +0300, Dan Carpenter wrote:
> The problem here is that max_effects can wrap on 32 bits systems.
> We'd allocate a smaller amount of data than sizeof(struct ff_device).
> The call to kcalloc() on the next line would fail but it would write
> the NULL return outside of the memory we just allocated causing data
> corruption.
> 
> The call path is that uinput_setup_device() get ->ff_effects_max from
> the user and sets the value in the ->private_data struct.  From there
> it is:
> -> uinput_ioctl_handler()
>    -> uinput_create_device()
>       -> input_ff_create(dev, udev->ff_effects_max);
> 
> I've also changed ff_effects_max so it's an unsigned int instead of
> a signed int as a cleanup.

Applied (adding a temp to hold the size), thanks.

-- 
Dmitry
