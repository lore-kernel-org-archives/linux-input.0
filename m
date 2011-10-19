From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: keyboard: adp5589-keys: Add support for
 the ADP5585 derivatives
Date: Tue, 18 Oct 2011 21:26:13 -0700
Message-ID: <20111019042613.GA3077@core.coreip.homeip.net>
References: <1318486726-6425-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40977 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab1JSE0V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Oct 2011 00:26:21 -0400
Received: by iaek3 with SMTP id k3so1631922iae.19
        for <linux-input@vger.kernel.org>; Tue, 18 Oct 2011 21:26:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1318486726-6425-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com

Hi Michael,

On Thu, Oct 13, 2011 at 08:18:46AM +0200, michael.hennerich@analog.com wrote:
>  static void __devinit adp5589_report_switch_state(struct adp5589_kpad *kpad)
>  {
> -	int gpi_stat1 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_A);
> -	int gpi_stat2 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_B);
> -	int gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);
> -	int gpi_stat_tmp, pin_loc;
> +	int gpi_stat_tmp, pin_loc, gpi_stat3;
>  	int i;
> +	int gpi_stat1 = adp5589_read(kpad->client,
> +				     kpad->var->reg(ADP5589_GPI_STATUS_A));
> +	int gpi_stat2 = adp5589_read(kpad->client,
> +				     kpad->var->reg(ADP5589_GPI_STATUS_B));
> +	if (!kpad->is_adp5585)
> +		gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);

This cause my compiler to complain that gpi_stat3 might be used
uninitialized; I changed it to

	int gpi_stat3 = !kpad->is_adp5585 ?
			adp5589_read(kpad->client, ADP5589_GPI_STATUS_C) : 0;

and applied.

Thanks.

-- 
Dmitry
