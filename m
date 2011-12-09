From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/2] Input: keyboard: Staticise non-exported symbols
Date: Fri, 9 Dec 2011 09:16:36 +0100
Message-ID: <4EE1C3E4.2060703@analog.com>
References: <1323394677.3740.2.camel@phoenix> <1323394752.3740.3.camel@phoenix>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:8382 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751855Ab1LIIZX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Dec 2011 03:25:23 -0500
In-Reply-To: <1323394752.3740.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Hennerich <hennerich@blackfin.uclinux.org>, Naveen Kumar G <naveen.gaddipati@stericsson.com>, Sundar Iyer <sundar.iyer@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 12/09/2011 02:39 AM, Axel Lin wrote:
> These symbols are not used outside it's driver so no need to
> make the symbol global.
>
> Signed-off-by: Axel Lin<axel.lin@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>   drivers/input/keyboard/bf54x-keys.c         |    2 +-
>   drivers/input/keyboard/nomadik-ske-keypad.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
> index 683e314..8eb9116 100644
> --- a/drivers/input/keyboard/bf54x-keys.c
> +++ b/drivers/input/keyboard/bf54x-keys.c
> @@ -384,7 +384,7 @@ static int bfin_kpad_resume(struct platform_device *pdev)
>   # define bfin_kpad_resume  NULL
>   #endif
>
> -struct platform_driver bfin_kpad_device_driver = {
> +static struct platform_driver bfin_kpad_device_driver = {
>   	.driver		= {
>   		.name	= DRV_NAME,
>   		.owner	= THIS_MODULE,
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> index 6c4828f..5a71e55 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -379,7 +379,7 @@ static const struct dev_pm_ops ske_keypad_dev_pm_ops = {
>   };
>   #endif
>
> -struct platform_driver ske_keypad_driver = {
> +static struct platform_driver ske_keypad_driver = {
>   	.driver = {
>   		.name = "nmk-ske-keypad",
>   		.owner  = THIS_MODULE,


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


