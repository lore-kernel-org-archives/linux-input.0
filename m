From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input: add driver for EETI touchpanels [v4]
Date: Sat, 16 May 2009 19:32:26 +0200
Message-ID: <20090516173226.GA1448@buzzloop.caiaq.de>
References: <1242466042-6749-1-git-send-email-daniel@caiaq.de> <20090516175716.7dc22580@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:49348 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZEPRca (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2009 13:32:30 -0400
Content-Disposition: inline
In-Reply-To: <20090516175716.7dc22580@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@vger.kernel.org

Hi Jean,

thanks for your input.

On Sat, May 16, 2009 at 05:57:16PM +0200, Jean Delvare wrote:
> > +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> > +	struct eeti_ts_priv *priv;
> > +	struct input_dev *input;
> > +	int err = -ENOMEM;
> > +
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> 
> This functionality does not correspond to the I2C access method your
> code uses. You must check for I2C_FUNC_I2C instead (if you want to
> check at all - it's essentially optional with the new binding model.)

Yes, I though so too and removed the check for now.
New version coming up.

Thanks,
Daniel

