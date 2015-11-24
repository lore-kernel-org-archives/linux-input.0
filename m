From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add generic platform data for
 Chromebooks
Date: Tue, 24 Nov 2015 16:18:05 -0300
Message-ID: <5654B7ED.9080107@osg.samsung.com>
References: <20151124185810.GA18357@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:50317 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbbKXTSM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 14:18:12 -0500
In-Reply-To: <20151124185810.GA18357@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org

Hello Dmitry,

On 11/24/2015 03:58 PM, Dmitry Torokhov wrote:
> Apparently people are installing generic Linux distributions not only on
> Pixels but also on other Chromebooks. Unfortunately on all of them Atmel
> parts assigned names ATML0000 and ATML0001, and do not carry any other
> configuration data. So let's create generic instance of platform data that
> should cover most of them (we assume that they will not be using T100
> objects, since with those Google mapped BTN_LEFT onto a different GPIO, so
> slightly different keymap would be needed, but I think we used parts with
> T100 on ARM devices where we thankfully have DTS and can describe the
> devices better).
> 

That is correct, an example of an ARM based Chromebook that has an Atmel chip
with a T100 object is the Exynos5800 Peach Pi Chromebook and as you correctly
said, the buttons to GPIO mapping is described in the DTS, i.e:

	/* Atmel mXT540S */
	trackpad@4b {
		compatible = "atmel,maxtouch";
		reg = <0x4b>;
		interrupt-parent = <&gpx1>;
		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
		wakeup-source;
		pinctrl-names = "default";
		pinctrl-0 = <&trackpad_irq>;
		linux,gpio-keymap = <KEY_RESERVED
				     KEY_RESERVED
				     KEY_RESERVED	/* GPIO 0 */
				     KEY_RESERVED	/* GPIO 1 */
				     BTN_LEFT		/* GPIO 2 */
				     KEY_RESERVED>;	/* GPIO 3 */
	};

> Tested-by: Rich K <rgkirch@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index c562205..159120b 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2487,6 +2487,31 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
>  	{ }
>  };
>  
> +static unsigned int chromebook_tp_buttons[] = {

Maybe naming it chromebook_t19_buttons instead to make it clear that the
mapping is specific to the T19 object or at least document that assumption?

Although is mentioned in the commit message so I don't have a strong
preference and the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
