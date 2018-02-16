From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v1] i2c-hid: Use ACPI_COMPANION() directly
Date: Fri, 16 Feb 2018 13:21:49 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1802161321390.13621@cbobk.fhfr.pm>
References: <20180119143504.16684-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965852AbeBPMVv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Feb 2018 07:21:51 -0500
In-Reply-To: <20180119143504.16684-1-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 19 Jan 2018, Andy Shevchenko wrote:

> Instead of doing additional checks and functional calls,
> just get ACPI companion device directly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 7230243b94d3..0d3ca542e987 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -891,10 +891,10 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
>  
>  static void i2c_hid_acpi_fix_up_power(struct device *dev)
>  {
> -	acpi_handle handle = ACPI_HANDLE(dev);
>  	struct acpi_device *adev;
>  
> -	if (handle && acpi_bus_get_device(handle, &adev) == 0)
> +	adev = ACPI_COMPANION(dev);
> +	if (adev)
>  		acpi_device_fix_up_power(adev);
>  }

Applied to for-4.17/hid-i2c. Thanks,

-- 
Jiri Kosina
SUSE Labs

