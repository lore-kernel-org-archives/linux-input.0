From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: cyttsp - Fix check after pointer dereferencing
Date: Sun, 4 Mar 2012 07:41:40 -0800
Message-ID: <20120304154140.GA27647@core.coreip.homeip.net>
References: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:46055 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab2CDWJf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Mar 2012 17:09:35 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4191532dad.11
        for <linux-input@vger.kernel.org>; Sun, 04 Mar 2012 14:09:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329302572-1651-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@euromail.se>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <martinez.javier@dowhile0.org>

Hi Javier,

On Wed, Feb 15, 2012 at 11:42:52AM +0100, Javier Martinez Canillas wrote:
> From: Javier Martinez Canillas <martinez.javier@dowhile0.org>
> 
> In the cyttsp_probe() function the struct device *dev pointer was
> dereferenced before checking if it was NULL.
> 
> Now dev is never NULL since both I2C and SPI bus drivers pass a pointer to a
> member of an previously allocated structure. But others bus drivers can do
> it differently so is better to sanity check instead of trust in the callers.
> 

I already have a patch that simply removes the checks ofr dev and
bus_ops - cyttsp_probe is only called by bus-specific code and they are
not coming form platform data so there is no chance they will be NULL.
And anyone writing a new bus intefcae will get a nice oops first time
they try loading the module so they'll see the problem right away too.

Thanks.

-- 
Dmitry
