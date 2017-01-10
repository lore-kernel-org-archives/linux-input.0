From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
Date: Tue, 10 Jan 2017 12:43:33 +0200
Message-ID: <20170110104333.GB18258@kuha.fi.intel.com>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14087 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765516AbdAJKps (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 05:45:48 -0500
Content-Disposition: inline
In-Reply-To: <20170110083141.4103-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Joseph Lai <joseph_lai@wistron.com>

On Tue, Jan 10, 2017 at 09:31:41AM +0100, Linus Walleij wrote:
> The MPU3050 driver in the input subsystem has been superceded
> by a proper IIO driver found in drivers/iio/gyro/mpu3050*.
> 
> Patches have been submitted to remove all defconfig and related
> references to the old driver and replace this input driver
> with the IIO driver. commit 634b847b6d23
> ("x86/platform/intel-mid: Switch MPU3050 driver to IIO")
> is already upstream.
> 
> So delete the input driver. Input was never a good fit for
> sensors anyway.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

OK by me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
