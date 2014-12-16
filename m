From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v15 09/12] input: cyapa: add gen5 trackpad device
 firmware update function support
Date: Tue, 16 Dec 2014 05:56:39 -0800
Message-ID: <20141216135639.GA1238@hudson.localdomain>
References: <1418624603-19054-1-git-send-email-dudley.dulixin@gmail.com>
 <1418624603-19054-10-git-send-email-dudley.dulixin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45353 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaLPN4n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 08:56:43 -0500
Content-Disposition: inline
In-Reply-To: <1418624603-19054-10-git-send-email-dudley.dulixin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudley.dulixin@gmail.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Mon, Dec 15, 2014 at 02:23:20PM +0800, Dudley Du wrote:
> Add firmware image update function supported for gen5 trackpad device,
> it can be used through sysfs update_fw interface.
> TEST=test on Chromebooks.
> 
> Signed-off-by: Dudley Du <dudley.dulixin@gmail.com>
> ---
>  drivers/input/mouse/Kconfig      |   1 +
>  drivers/input/mouse/cyapa_gen5.c | 292 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 292 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index d8b46b0..728490e 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -206,6 +206,7 @@ config MOUSE_BCM5974
>  config MOUSE_CYAPA
>  	tristate "Cypress APA I2C Trackpad support"
>  	depends on I2C
> +	select CRC_ITU_T
>  	help

Just found out that if I2C_DESIGNWARE_PCI isn't enabled the touchpad
won't work.  Verify this on your machines.  Then perhaps add a depends
for I2C_DESIGNWARE_PCI instead of I2C since it would include the former.

[...]

-- 
- Jeremiah Mahler
