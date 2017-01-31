From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
Date: Tue, 31 Jan 2017 00:14:33 -0800
Message-ID: <20170131081433.GB8311@dtor-ws>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
 <20170110104333.GB18258@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32860 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdAaIOg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 03:14:36 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so26575734pfg.0
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 00:14:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170110104333.GB18258@kuha.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, Joseph Lai <joseph_lai@wistron.com>

On Tue, Jan 10, 2017 at 12:43:33PM +0200, Heikki Krogerus wrote:
> On Tue, Jan 10, 2017 at 09:31:41AM +0100, Linus Walleij wrote:
> > The MPU3050 driver in the input subsystem has been superceded
> > by a proper IIO driver found in drivers/iio/gyro/mpu3050*.
> > 
> > Patches have been submitted to remove all defconfig and related
> > references to the old driver and replace this input driver
> > with the IIO driver. commit 634b847b6d23
> > ("x86/platform/intel-mid: Switch MPU3050 driver to IIO")
> > is already upstream.
> > 
> > So delete the input driver. Input was never a good fit for
> > sensors anyway.
> > 
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> OK by me. FWIW:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

OK, since nobody yelled that they need it I applied the patch.

-- 
Dmitry
