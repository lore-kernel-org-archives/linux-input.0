From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: i2c-hid: The interrupt should be level sensitive
Date: Thu, 29 Jan 2015 15:09:50 -0500
Message-ID: <20150129200950.GC27265@mail.corp.redhat.com>
References: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926AbbA2UKN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 15:10:13 -0500
Content-Disposition: inline
In-Reply-To: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jan 26 2015 or thereabouts, Mika Westerberg wrote:
> The Microsoft HID over I2C specification says two things regarding the
> interrupt:
> 
>  1) The interrupt should be level sensitive
>  2) The device keeps the interrupt asserted as long as it has more reports
>     available.
> 
> We've seen that at least some Atmel and N-Trig panels keep the line low as
> long as they have something to send. The current version of the driver only
> detects the first edge but then fails to read rest of the reports (as the
> line is still asserted).
> 
> Make the driver follow the specification and configure the HID interrupt to
> be level sensitive.
> 
> The Windows HID over I2C driver also seems to do the same.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

FWIW, this one is
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

looks like we are going to drop 2/2, but this one is still valid.

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index d43e967e7533..8f1dfc5c5d9c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -785,7 +785,7 @@ static int i2c_hid_init_irq(struct i2c_client *client)
>  	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
>  
>  	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
> -			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  			client->name, ihid);
>  	if (ret < 0) {
>  		dev_warn(&client->dev,
> -- 
> 2.1.4
> 
