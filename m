Return-Path: <SRS0=dHTn=4P=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BCCC4BA06
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBBA2467F
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 08:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgB0IUk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:20:40 -0500
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:58162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgB0IUk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 03:20:40 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 03:20:39 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 0EB26800BE66
        for <linux-input@vger.kernel.org>; Thu, 27 Feb 2020 08:12:38 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 40496A8D1;
        Thu, 27 Feb 2020 08:12:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: air39_164c43472a863
X-Filterd-Recvd-Size: 3870
Received: from XPS-9350 (47-209-22-207.mmlkcmtc01.res.dyn.suddenlink.net [47.209.22.207])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Feb 2020 08:12:33 +0000 (UTC)
Message-ID: <3ec7521233aed6e1c2d27f387b7b2d2b55694e84.camel@perches.com>
Subject: Re: [V1,1/1] Input/misc: add support for Advantech software defined
 button
From:   Joe Perches <joe@perches.com>
To:     ycho1399@gmail.com, linux-input@vger.kernel.org
Cc:     voyandrea@gmail.com, andrea.ho@advantech.com.tw,
        oakley.ding@advantech.com.tw,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Date:   Thu, 27 Feb 2020 00:11:02 -0800
In-Reply-To: <20200227031721.17703-1-Andrea.Ho@advantech.com.tw>
References: <20200227031721.17703-1-Andrea.Ho@advantech.com.tw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2020-02-27 at 03:15 +0000, ycho1399@gmail.com wrote:
> From: "Andrea.Ho" <Andrea.Ho@advantech.com.tw>
> 
> Advantech sw_button is a ACPI event trigger button.
> 
> With this driver, we can report KEY_EVENTs on the
> Advantech Tabletop Network Appliances products and it has been
> tested in FWA1112VC.
> 
> Add the software define button support to report KEY_EVENTs by
> different acts of pressing button (like double-click, long pressed
> and tick) that cloud be get on user interface and trigger the
> customized actions.
[]
> diff --git a/drivers/input/misc/adv_swbutton.c b/drivers/input/misc/adv_swbutton.c
> new file mode 100644

mostly trivia:

> +/*
> + * Switch two elements in array.
> + *
> + * @param xp, yp The array elements need to swap.
> + */
> +void array_swap(unsigned int *xp, unsigned int *yp)
> +{
> +	int temp = *xp;
> +	*xp = *yp;
> +	*yp = temp;
> +}

kernel.h has swap

> +/*
> + * Sorting an array in ascending order
> + *
> + * @param arr The array for sorting.
> + * @param n The array size
> + */
> +void sort_asc(unsigned int arr[], int n)
> +{
> +	int i, j, min_idx;
> +
> +	for (i = 0; i < n - 1; i++) {
> +		min_idx = i;
> +		for (j = i + 1; j < n; j++)
> +			if (arr[j] < arr[min_idx])
> +				min_idx = j;
> +
> +		array_swap(&arr[min_idx], &arr[i]);
> +	}
> +}

sort.h has a generic sort too

> +
> +/*
> + * initial software button timer to check tick or double click
> + *
> + * @param btn Struct of acpi_button that should be required.
> + */ 
> +static void swbtn_init_timer(struct acpi_button *btn)
> +{
> +	pr_info(PREFIX "swbtn timer start\n");

Many of these printks should be removed and ftrace used
when necessary.

> +static int acpi_button_add(struct acpi_device *device)
> +{
> +	struct acpi_button *button;
> +	struct input_dev *input;
> +	const char *hid = acpi_device_hid(device);
> +	char *name, *class;
> +	int error, i;
> +
> +	pr_info(PREFIX "%s\n",  __func__);
> +	button = kzalloc(sizeof(*button), GFP_KERNEL);
> +	if (!button) {
> +		pr_err(PREFIX "alloc acpi_button failed\n");

alloc failure messages aren't really necessary
as a dump_stack() is already done on failure.

[]

> +		for (i = (!swbtn_cfg.dclick_enabled);
> +		     i < (swbtn_cfg.lkey_number + 2); i++) {
> +			pr_info(PREFIX "%d. Enabled keycode[0x%x]\n",
> +				i, swbtn_keycodes[i]);

Is it really useful to print all enabled keycodes?


