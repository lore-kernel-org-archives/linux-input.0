From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: TOUCHSCREEN: S3C24XX touchscreen driver from Arnaud Patard.
Date: Mon, 23 Nov 2009 09:59:58 -0800
Message-ID: <20091123175958.GF17813@core.coreip.homeip.net>
References: <20091123150556.908236267@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46012 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZKWSAC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 13:00:02 -0500
Received: by pzk1 with SMTP id 1so4119525pzk.33
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2009 10:00:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091123150556.908236267@fluff.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-input@vger.kernel.org, arnaud.patard@rtp-net.org, Simtec Linux Team <linux@simtec.co.uk>

On Mon, Nov 23, 2009 at 03:05:57PM +0000, Ben Dooks wrote:
> From: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> S3C24XX touchscreen driver, originally written by Arnaud Patard and
> other contributors. This driver is the version from the Simtec Electronics
> tree, and as such is the best place to start and thus proposed to be
> merged into the linux input system.
> 
> The driver has had substantial testing as well as a number of tidying
> up passes done by Ben Dooks, as noted:
> 
> - added kernel-doc comments to most of the routines
> - removed old code from pre adc framework days
> - updated device probe code to use platform id list matching
> - cleaned up debug, since printk() now has timestamp feature
> - ensure code uses dev_() reporting macros where necessary
> - remove ABS_PRESSURE reporting, tslib can be fixed
> - ensure timer is removed on driver exit
> - move to using dev_pmops for power management
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
> 

Applied, thank you Ben.

-- 
Dmitry
