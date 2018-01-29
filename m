From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] i2c-hid: Use ACPI_COMPANION() directly
Date: Mon, 29 Jan 2018 17:48:04 +0200
Message-ID: <1517240884.7000.1304.camel@linux.intel.com>
References: <20180119143504.16684-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:51582 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbeA2P5h (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 10:57:37 -0500
In-Reply-To: <20180119143504.16684-1-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 2018-01-19 at 16:35 +0200, Andy Shevchenko wrote:
> Instead of doing additional checks and functional calls,
> just get ACPI companion device directly.
> 

Any comments on this? The rationale is to prevent people copy'n'paste
current approach instead of better one which is presented by this
change.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-
> hid.c
> index 7230243b94d3..0d3ca542e987 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -891,10 +891,10 @@ static int i2c_hid_acpi_pdata(struct i2c_client
> *client,
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
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
