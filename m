From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/24] input/keyboard: fix dangling pointers
Date: Sat, 20 Mar 2010 12:20:07 -0700
Message-ID: <20100320192007.GA28402@core.coreip.homeip.net>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
 <1269094385-16114-7-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:59480 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab0CTTUN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 15:20:13 -0400
Content-Disposition: inline
In-Reply-To: <1269094385-16114-7-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Wolfram,

On Sat, Mar 20, 2010 at 03:12:47PM +0100, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 

I am not sure if setting clientdata to NULL before freeing the data is
that important; we really want to be sure that we don't leave clientdata
dangling when we finish unbinding the driver. If there are another
thread the change will not really help the problem of accessing
non-existing client data.

I will apply lm8323 portion of the patch but leave qt2160 as is.

Thanks.

-- 
Dmitry
