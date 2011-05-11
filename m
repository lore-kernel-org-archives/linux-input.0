From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] input: misc: AD714x: The interrupt status registers
 should be read in row.
Date: Wed, 11 May 2011 14:15:41 -0700
Message-ID: <20110511211541.GB11178@core.coreip.homeip.net>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59728 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab1EKVPs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 17:15:48 -0400
Received: by pwi15 with SMTP id 15so425855pwi.19
        for <linux-input@vger.kernel.org>; Wed, 11 May 2011 14:15:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

Hi Michael,

On Tue, May 10, 2011 at 01:35:05PM +0200, michael.hennerich@analog.com wrote:
> 
> +static int ad714x_i2c_read_seq(struct device *dev, unsigned short reg,
> +				unsigned short *data, unsigned len)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret = 0, i;
> +	u8 *_reg = (u8 *)&reg;
> +
> +	u8 tx[2] = {
> +		_reg[1],
> +		_reg[0]
> +	};

Eww... I think this will also break on arches with different endianness.
Can we pass the commands to be sent to the device as u8 array?

-- 
Dmitry
