From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V4] input: add EETI eGalax I2C capacitive multi touch
 driver.
Date: Sat, 12 Nov 2011 00:02:06 -0800
Message-ID: <20111112080206.GB20411@core.coreip.homeip.net>
References: <20111110183819.GB18002@core.coreip.homeip.net>
 <1321078357-19317-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42487 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab1KLICN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 03:02:13 -0500
Received: by gyc15 with SMTP id 15so3600727gyc.19
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2011 00:02:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1321078357-19317-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Sat, Nov 12, 2011 at 02:12:37PM +0800, Zhang Jiejing wrote:
> This patch adds the EETI eGalax serial multi touch controller driver.
> 
> EETI eGalax serial touch screen controller is a I2C based multiple
> capacitive touch screen controller, it can support 5 touch events maximum.
> 
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> 
> ---
> V1 changes:
> * use mt protocol B for report pointer.
> * get the pressure value from pointer.
> * use macro to define X,Y max value.
> 
> V2 changes:
> * change MODE_SINGLE to a meanful name MODE_MOUSE
> * add some comment on each mode to avoid misunderstand
> 
> V3 changes:
> * some typo fix
> * remove MODE_MOUSE, since it can't support both mode 100% well.
>  also use this chip as MODE_MOUSE is very rare case.
> 
> V4 changes:
> * fix some typo
> * don't let i2c_master_recv spin indefinitely
> * clean up the bit set of probe function
> * clean up egalax_ts_remove  input_unregister_device order

No, it is not the order I complained about, input_free_device() shoudl
not be called at all after calling input_unregister_device().

Fixed up locally and applied.

-- 
Dmitry
