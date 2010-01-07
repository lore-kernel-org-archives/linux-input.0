From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ad7879: support auxiliary GPIOs via gpiolib
Date: Wed, 6 Jan 2010 23:31:14 -0800
Message-ID: <20100107073114.GC2314@core.coreip.homeip.net>
References: <1262848702-24968-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47588 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab0AGHbV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 02:31:21 -0500
Received: by pzk1 with SMTP id 1so2751495pzk.33
        for <linux-input@vger.kernel.org>; Wed, 06 Jan 2010 23:31:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262848702-24968-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Michael,

On Thu, Jan 07, 2010 at 02:18:22AM -0500, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Drop the simple fancy sysfs hooks for the aux GPIOs and expose these via
> the gpiolib interface so that other drivers can use them.
> 

Would not that mess up current users (if any) that may rely on the
existing sysfs attributes?

Also I do no see you removing the chip when unbinding the driver.

Thanks.

-- 
Dmitry
