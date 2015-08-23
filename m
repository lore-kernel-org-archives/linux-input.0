From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v4 3/3] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Sat, 22 Aug 2015 18:52:28 -0700
Message-ID: <c5cd11ba9b5c3ec228a120e0f1c3c156@agner.ch>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
 <915c9122cfba83c6fbbc519c10ae2d101e27bc5b.1440162473.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:40875 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbHWBwn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 21:52:43 -0400
In-Reply-To: <915c9122cfba83c6fbbc519c10ae2d101e27bc5b.1440162473.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, shawnguo@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sanchayan,

On 2015-08-21 06:26, Sanchayan Maity wrote:
> +static int vf50_ts_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *input;
> +	struct iio_channel *channels;
> +	struct device *dev = &pdev->dev;
> +	struct vf50_touch_device *touchdev;
> +	int error;
> +
> +	channels = iio_channel_get_all(dev);
> +	if (IS_ERR(channels))
> +		return PTR_ERR(channels);

Hm, we expect here that four channels are returned, however a faulty
device tree could contain less. Access to the fourth channel above would
lead to a bug.

Can you check the amount of channels returned? The returned list is
explicitly terminated with a null entry, you can rely on that. Something
similar to hwmon should do the job.
http://lxr.free-electrons.com/source/drivers/hwmon/iio_hwmon.c#L86


Otherwise, Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan
