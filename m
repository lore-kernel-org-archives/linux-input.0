From: =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>
Subject: Re: [PATCH] input: elan_i2c: Add ACPI ID for touchpad in Lenovo
 V130-15IGM
Date: Sat, 26 Jan 2019 21:46:23 +0100
Message-ID: <7a392798-0c21-a44b-6964-0ba511324fff@voegeli.com>
References: <20190126154856.14060-1-tobias@voegeli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190126154856.14060-1-tobias@voegeli.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Forget this patch, I did some further testing and even though the touchpad works, it generates some dmesg messages. I have to take a closer look into this.

Sorry for the spam.

Tobias

  

> From: Tobias Vögeli <tobias@voegeli.com>
>
> Add ELAN061A to the ACPI table to support the touchpad of the Lenovo V130-15IGM.
>
> Signed-off-by: Tobias Vögeli <tobias@voegeli.com>
> ---
>   drivers/input/mouse/elan_i2c_core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index f322a1768fbb..4998b7007201 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1347,6 +1347,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>   	{ "ELAN0611", 0 },
>   	{ "ELAN0612", 0 },
>   	{ "ELAN0618", 0 },
> +	{ "ELAN061A", 0 },
>   	{ "ELAN061C", 0 },
>   	{ "ELAN061D", 0 },
>   	{ "ELAN061E", 0 },
