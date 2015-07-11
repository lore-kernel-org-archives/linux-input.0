From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Sat, 11 Jul 2015 15:05:23 +0200
Message-ID: <1436619923.2679.5.camel@tiscali.nl>
References: <1436541064-13381-1-git-send-email-robert.dolca@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:55638 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750701AbbGKNF0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 09:05:26 -0400
In-Reply-To: <1436541064-13381-1-git-send-email-robert.dolca@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On vr, 2015-07-10 at 18:11 +0300, Robert Dolca wrote:
> +static struct i2c_driver silead_ts_driver = {
> +	[...]
> +	.driver = {
> +		[...]
> +#ifdef CONFIG_ACPI
> +		.acpi_match_table = ACPI_PTR(silead_ts_acpi_match),
> +#endif

A nit: for the !CONFIG_ACPI case include/linux/acpi.h contains
    #define ACPI_PTR(_ptr)  (NULL)

So I think the above CONFIG_ACPI guard is superfluous and can be dropped.

> +[...]
> +	},
> +};

Thanks,


Paul Bolle
