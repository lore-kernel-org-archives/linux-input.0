From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/7] Second batch of cleanups for cros_ec
Date: Mon, 25 Aug 2014 10:05:34 -0700
Message-ID: <20140825170533.GA29350@core.coreip.homeip.net>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41598 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbaHYRFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 13:05:42 -0400
Content-Disposition: inline
In-Reply-To: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Mon, Aug 25, 2014 at 03:40:01PM +0200, Javier Martinez Canillas wrote:
> This is a second batch of cleanups patches for the mfd cros_ec
> driver and its subdevices drivers. The first batch of cleanups
> was posted by Doug Anderson [0] and have already been merged.
> The patches were picked from the ChromeOS 3.8 kernel and after
> these no cleanups patches for cros_ec are left, only commits
> that add cros ec support not yet available in mainline.
> 
> This is a second version of the patch series that addresses
> issues pointed out by Doug Anderson and Lee Jones on v1 [1].
> 
> There is almost no functionality added on this series but the
> idea is to reduce the delta between the mainline drivers and
> the ones in the downstream Chrome OS 3.8 kernel so the missing
> functionality can be added on top once these cleanups patches
> are merged. The missing functionlity currently in mainline is:
> 
> - Chrome OS Embedded Controller userspace device interface
> - Chrome OS Embedded Controller Low Pin Count (LPC) inteface
> - Access to vboot context stored on a block device
> - Access to vboot context stored on EC's nvram
> 
> The patches in this series are authored by different people
> (all on cc) and consist of the following:
> 
> Andrew Bresticker (3):
>   mfd: cros_ec: stop calling ->cmd_xfer() directly
>   mfd: cros_ec: move locking into cros_ec_cmd_xfer
>   mfd: cros_ec: wait for completion of commands that return IN_PROGRESS
> 
> Derek Basehore (1):
>   i2c: i2c-cros-ec-tunnel: Set retries to 3
> 
> Doug Anderson (1):
>   mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
> 
> Todd Broch (2):
>   mfd: cros_ec: Instantiate sub-devices from device tree
>   Input: cros_ec_keyb: Optimize ghosting algorithm.
> 
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c |  5 +-
>  drivers/input/keyboard/cros_ec_keyb.c   | 94 ++++++++++++++++++---------------
>  drivers/mfd/cros_ec.c                   | 78 ++++++++++++++++++++-------
>  drivers/mfd/cros_ec_spi.c               | 20 ++++---
>  include/linux/mfd/cros_ec.h             | 24 ++++++---
>  5 files changed, 141 insertions(+), 80 deletions(-)
> 
> Patches #1, #2, #6 and #7 do not depend of others so they can be
> merged independently but patches #3, #4 and #5 have to be merged
> in that specific order since they depend on the previous one. 

#7 does not apply to my tree (I guess it depends on the 1st batch which I
expect will go through MFD tree?). Maybe you could rebase it on top of my next
so it can be applied sooner? Or it really needs parts of patchset #1?

Thanks.

-- 
Dmitry
