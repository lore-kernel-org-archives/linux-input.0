From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] input: silead: Add MSSL0017 to acpi_device_id.
Date: Wed, 22 May 2019 12:12:47 +0200
Message-ID: <6c18472f-bedd-6e6d-121c-8a311495c3c3@redhat.com>
References: <20190522045455.15769-1-danct12@disroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522045455.15769-1-danct12@disroot.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Danct12 <danct12@disroot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 22-05-19 06:54, Danct12 wrote:
> On Chuwi Hi10 Plus, the Silead device id is MSSL0017.
> 
> Signed-off-by: Danct12 <danct12@disroot.org>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/touchscreen/silead.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 09241d4cdebc..06f0eb04a8fd 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -617,6 +617,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>   	{ "MSSL1680", 0 },
>   	{ "MSSL0001", 0 },
>   	{ "MSSL0002", 0 },
> +	{ "MSSL0017", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
> 
