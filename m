From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC PATCH] input: Add wiichuck driver
Date: Sat, 14 May 2011 21:17:50 +0200
Message-ID: <201105142117.50529.oliver@neukum.org>
References: <20110512042218.12859.66600.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:43554 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1ENTP7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 15:15:59 -0400
In-Reply-To: <20110512042218.12859.66600.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Am Donnerstag, 12. Mai 2011, 06:29:44 schrieb Grant Likely:
> +static void wiichuck_poll(struct input_polled_dev *poll_dev)
> +{
> +       struct wiichuck_device *wiichuck = poll_dev->private;
> +       struct i2c_client *i2c = wiichuck->i2c_client;
> +       static uint8_t cmd_byte = 0;
> +       struct i2c_msg cmd_msg =
> +               { .addr = i2c->addr, .len = 1, .buf = &cmd_byte };
> +       uint8_t b[6];
> +       struct i2c_msg data_msg =
> +               { .addr = i2c->addr, .flags = I2C_M_RD, .len = 6, .buf = b };


Do you need these buffers to be capable of DMA?

	Regards
		Oliver
