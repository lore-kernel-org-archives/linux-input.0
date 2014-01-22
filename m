From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] ims-pcu: Add commands supported by the new version of
 the FW
Date: Wed, 22 Jan 2014 08:47:50 -0800
Message-ID: <20140122164750.GA5080@core.coreip.homeip.net>
References: <1390396825-10255-1-git-send-email-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48772 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbaAVQr4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 11:47:56 -0500
Content-Disposition: inline
In-Reply-To: <1390396825-10255-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 22, 2014 at 05:20:25AM -0800, Andrey Smirnov wrote:
> +static int ims_pcu_write_ofn_config(struct ims_pcu *pcu, u8 addr, u8 data)
> +{
> +	u8 buffer[] = { addr, data };
> +	int error;
> +	u16 result;
> +
> +	error = ims_pcu_execute_command(pcu, OFN_SET_CONFIG,
> +					&buffer, sizeof(buffer));
> +	if (error)
> +		return error;
> +
> +	result = (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET);
> +	if ((result < 0)

I am fairly certain this does not even compile, but even if it did,
result is declared u16 so even if you do the cast above the comparison
will always be false.

Thanks.

-- 
Dmitry
