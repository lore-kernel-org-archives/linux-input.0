From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] goldfish: Enable ACPI-based enumeration for goldfish
 events
Date: Fri, 26 Feb 2016 12:06:13 -0800
Message-ID: <20160226200613.GC3769@dtor-ws>
References: <20160226184908.3539.48691.stgit@localhost.localdomain>
 <20160226184944.3539.14655.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35163 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcBZUGQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 15:06:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so57595717pac.2
        for <linux-input@vger.kernel.org>; Fri, 26 Feb 2016 12:06:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160226184944.3539.14655.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 26, 2016 at 06:49:56PM +0000, Alan wrote:
> From: Jason Hu <jia-cheng.hu@intel.com>
> 
> Add ACPI binding to the goldfish events driver.
> 
> Signed-off-by: Jason Hu <jia-cheng.hu@intel.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Alan <alan@linux.intel.com>
> ---
>  drivers/input/keyboard/goldfish_events.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
> index b11d218..c7e308a 100644
> --- a/drivers/input/keyboard/goldfish_events.c
> +++ b/drivers/input/keyboard/goldfish_events.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/acpi.h>
>  
>  enum {
>  	REG_READ        = 0x00,
> @@ -184,11 +185,18 @@ static const struct of_device_id goldfish_events_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, goldfish_events_of_match);
>  
> +static const struct acpi_device_id goldfish_events_acpi_match[] = {
> +	{ "GFSH0002", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, goldfish_events_acpi_match);

I believe this can we guarded by #ifdef CONFIG_ACPI, I'll add it.

> +
>  static struct platform_driver events_driver = {
>  	.probe	= events_probe,
>  	.driver	= {
>  		.name	= "goldfish_events",
>  		.of_match_table = goldfish_events_of_match,
> +		.acpi_match_table = ACPI_PTR(goldfish_events_acpi_match),
>  	},
>  };
>  
> 

Thanks.

-- 
Dmitry
