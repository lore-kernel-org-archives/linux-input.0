Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE347274B3A;
	Tue,  3 Feb 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118908; cv=none; b=YZ2PEc3UqVTtZr+/w0Vp2a7rTq/ZCHDy1AFdFnyvwJwQUn1JdVlu2vxkOXnx8NPuUj0crRWi+RS+F75xxaszJzkCaYzDs8AkcV8cZESjqN7qxtYut2DGRn+BbpTV7CSOyfvMVQNrWqYbQDTedjMaKVq8y77xt94Tmx1dSge4hQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118908; c=relaxed/simple;
	bh=fYkxphING3HIWpahK7YJFEmJeYTWB272iYkC8ckgea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P++8MBeS5K4GlqSkVjqAcKkYtUSGJGiPq18CMmtV5UiYnAzLpoKnLdjJ3AxEvdvRxw17h66xYmFpGtEm5OOZYajgFM5uo6tA8dZpbp3IhyXwSqnPSytsgrkqn+TtD0csoSi5Swf0rhyBWCDG2/TuF7AQsgIASGrukRIuzaMBSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pkuNahVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pkuNahVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98607C116D0;
	Tue,  3 Feb 2026 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770118907;
	bh=fYkxphING3HIWpahK7YJFEmJeYTWB272iYkC8ckgea0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkuNahVCVhXg8U7s5K+OS6Rfz1S+aJIbGe0kwTYFbUuxeuvnLL3eNwaPwuWOJRcAV
	 O0r1AX2Z6io52JATFp/rhLKCVOVmziBoGnMMfCTSL9S98QOHeb9pQhgQ+cL/yXdH7k
	 OZfapOlE5prWQMqftIHk3CbWswyvUFzIGwW+jYkE=
Date: Tue, 3 Feb 2026 12:41:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
Message-ID: <2026020350-unrevised-humming-7a42@gregkh>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201104343.79231-3-clamor95@gmail.com>

On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> --- /dev/null
> +++ b/drivers/misc/asus-dockram.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ASUS EC: DockRAM
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/asus-ec.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +struct dockram_ec_data {
> +	struct mutex ctl_lock; /* prevent simultaneous access */
> +	char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> +};
> +
> +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> +{
> +	int rc;
> +
> +	memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> +	rc = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> +		dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d\n",
> +			DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> +		return -EPROTO;
> +	}
> +
> +	dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> +		DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(asus_dockram_read);

No documentation for these new public symbols?


> +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> +static DEVICE_ATTR_RW(control_reg);

You did not document your new sysfs files in Documentation/ABI/ which is
required.

Also, why do you need a brand new user/kernel api at all?  Who is going
to use this and for what?

thanks,

greg k-h
