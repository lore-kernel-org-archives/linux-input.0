From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add Microchip AR1021 i2c touchscreen
Date: Wed, 8 Oct 2014 10:56:49 -0700
Message-ID: <20141008175649.GB14423@dtor-ws>
References: <1412779518-16712-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43683 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaJHR44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 13:56:56 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so9368422pad.41
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2014 10:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412779518-16712-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Christian,

On Wed, Oct 08, 2014 at 04:45:18PM +0200, Christian Gmeiner wrote:
> +static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
> +{
> +	struct ar1021_i2c *ar1021 = dev_id;
> +	struct input_dev *input = ar1021->input;
> +	u8 *data = ar1021->data;
> +	unsigned int x, y, button;
> +	int error;
> +
> +	error = i2c_master_recv(ar1021->client,
> +				ar1021->data, sizeof(ar1021->data));
> +	if (error < 0)

I think this check should be "if (retval != sizeof(ar1021->data))" to
avoid using garbage data in case of short read. I'll change it locally
and apply the patch.

-- 
Dmitry
