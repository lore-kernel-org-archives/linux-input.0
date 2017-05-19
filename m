From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] input: axp20x-pek: Switch to acpi_dev_present and
 check for ACPI0011 too
Date: Fri, 19 May 2017 16:13:27 +0200
Message-ID: <1b959e8c-2a76-6824-a44b-98115091681c@redhat.com>
References: <20170519140626.31757-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbdESON3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 10:13:29 -0400
In-Reply-To: <20170519140626.31757-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

Note this series is v2, something went wrong causing that to
not show in the Subject, sorry.

Regards,

Hans

On 19-05-17 16:06, Hans de Goede wrote:
> acpi_dev_found checks that there is a matching ACPI node, but it
> may be disabled (_STA method returns 0) in which case the
> soc_button_array driver will not bind to it and axp20x-pek should
> handle the power-button.
> 
> This commit switches from acpi_dev_found to acpi_dev_present to
> avoid not registering an input-dev for the powerbutton when there
> is a disabled PNP0C40 device.
> 
> The ACPI-6.0 standard defines a standard gpio button device using
> the ACPI0011 HID replacing the custom PNP0C40 gpio device, many
> newer devices define both PNP0C40 and ACPI0011 devices enabling one
> or the other depending on whether the BIOS thinks it is going to boot
> Android or Windows.
> 
> This commit adds a check for the ACPI0011 device, so that if
> either device is present *and* enabled we don't register an input-dev
> for the powerbutton.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Switch from acpi_dev_found to acpi_dev_present
> ---
>   drivers/input/misc/axp20x-pek.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index 7ac790b94392..3f1f9434eb9a 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -280,11 +280,12 @@ static int axp20x_pek_probe(struct platform_device *pdev)
>   
>   		/*
>   		 * On Cherry Trail platforms (hrv == 3), do not register the
> -		 * input device if there is an "INTCFD9" gpio
> +		 * input device if there is an "INTCFD9" or "ACPI0011" gpio
>   		 * button ACPI device, as that handles the power button too,
>   		 * and otherwise we end up reporting all presses twice.
>   		 */
> -		if (hrv == 3 && acpi_dev_found("INTCFD9"))
> +		if (hrv == 3 && (acpi_dev_present("INTCFD9", NULL, -1) ||
> +				 acpi_dev_present("ACPI0011", NULL, -1)))
>   			register_input_device = false;
>   	}
>   #endif
> 
