From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input: add maxim max11801 resistance touchscreen
 controller driver.
Date: Mon, 11 Apr 2011 23:49:25 -0700
Message-ID: <20110412064925.GA9566@core.coreip.homeip.net>
References: <1302239702-29905-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41185 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1DLGtb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:49:31 -0400
Received: by iyb14 with SMTP id 14so6341266iyb.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 23:49:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302239702-29905-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, kzjeef@gmail.com

On Fri, Apr 08, 2011 at 01:15:02PM +0800, Zhang Jiejing wrote:
> +
> +static __devexit int max11801_ts_remove(struct i2c_client *client)
> +{
> +	struct max11801_data *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	input_free_device(data->input_dev);

You should not call input_free_device() after input_unregister_device().
Otherwise queued for .40 (witho some minor edits).

Thanks.

-- 
Dmitry
