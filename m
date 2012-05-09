From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/14 v3] Input: atmel_mxt_ts - refactor
 mxt_read/write_reg to take a length
Date: Tue, 8 May 2012 22:54:11 -0700
Message-ID: <20120509055411.GG10514@core.coreip.homeip.net>
References: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
 <1334755319-21365-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1334755319-21365-4-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, khali@linux-fr.org
List-Id: linux-input@vger.kernel.org

Hi Daniel,

On Wed, Apr 18, 2012 at 09:21:48PM +0800, Daniel Kurtz wrote:
> +	ret = i2c_transfer(client->adapter, xfer, 2);
> +	if (ret != 2) {
> +		dev_err(&client->dev, "i2c read reg failed (%d)\n", ret);
> +		if (ret >= 0)
> +			ret = -EIO;
>  	}
>  
> -	return 0;
> +	return (ret == 2) ? 0 : ret;
>  }

Would prefer:

	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
	if (ret != ARRAY_SIZE(xfer)) {
		if (ret >= 0)
			ret = -EIO;
		dev_err(&client->dev, "i2c read reg failed (%d)\n", ret);
		return ret;
	}

	return 0;


Or maybe we need i2c_transfer_exact() wrapper? Jean?

Thanks.

-- 
Dmitry
