From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [V4] Input: Add MELFAS MIP4 Touchscreen driver
Date: Tue, 23 Feb 2016 15:18:19 -0800
Message-ID: <20160223231819.GE30638@dtor-ws>
References: <1455543645-7156-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34830 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbcBWXSW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 18:18:22 -0500
Received: by mail-pf0-f181.google.com with SMTP id c10so879681pfc.2
        for <linux-input@vger.kernel.org>; Tue, 23 Feb 2016 15:18:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455543645-7156-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Feb 15, 2016 at 10:40:45PM +0900, Sangwon Jee wrote:
> This is an input driver for MELFAS MIP4 Touchscreen devices,
> made by the original vendor, MELFAS.
> 
> MIP4 means MELFAS Interface Protocol Version 4.
> MELFAS MMS400, MMS500, MCS8000, MIT200, MIT300, MIT400, MFS10 and other
> recent touchscreen devices are using MIP4 and supported by this driver.
> 
> There are two MELFAS touchscreen drivers(mcs5000_ts, mms114) in the kernel.
> But those drivers are for discontinued models and not supported by MELFAS.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

As you may have noticed I ended up applying the previous version of the
driver. Any additional changes should be made against the version in my
'next' branch or linux-next.

> +static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mip4_ts *ts = i2c_get_clientdata(client);
> +	size_t count;
> +
> +	/* Take lock to prevent racing with firmware update */
> +	mutex_lock(&ts->input->mutex);
> +
> +	count = snprintf(buf, PAGE_SIZE, "%s\n", "MIT400");
> +
> +	mutex_unlock(&ts->input->mutex);
> +
> +	return count;
> +}

It is unclear why we need basically a constant attribute.

Thanks.

-- 
Dmitry
