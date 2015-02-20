From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 3/6] thinkpad_acpi: Add adaptive_kbd_mode sysfs attr
Date: Thu, 19 Feb 2015 21:28:31 -0800
Message-ID: <20150220052831.GD790@fury.dvhart.com>
References: <1424292824.32581.47.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46123 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbBTF2f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 00:28:35 -0500
Content-Disposition: inline
In-Reply-To: <1424292824.32581.47.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Feb 18, 2015 at 09:53:44PM +0100, Bastien Nocera wrote:

Commit message please.

> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 71 +++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index a6dd017..562d958 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c

...

> +static struct device_attribute dev_attr_adaptive_kbd_mode =
> +	__ATTR(adaptive_kbd_mode, S_IWUSR | S_IRUGO,
> +		adaptive_kbd_mode_show, adaptive_kbd_mode_store);
> +

Please use DEVICE_ATTR_RW() macros for new sysfs files.

I'd very much like to see a cleanup of the driver to use these as well.

Henrique, your thoughts / preference?

-- 
Darren Hart
Intel Open Source Technology Center
