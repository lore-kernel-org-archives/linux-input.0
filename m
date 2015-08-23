From: maitysanchayan@gmail.com
Subject: Re: [PATCH v4 3/3] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Sun, 23 Aug 2015 21:01:48 +0530
Message-ID: <20150823153148.GB3935@Sanchayan-Arch>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
 <915c9122cfba83c6fbbc519c10ae2d101e27bc5b.1440162473.git.maitysanchayan@gmail.com>
 <c5cd11ba9b5c3ec228a120e0f1c3c156@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33023 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbbHWPfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Aug 2015 11:35:09 -0400
Content-Disposition: inline
In-Reply-To: <c5cd11ba9b5c3ec228a120e0f1c3c156@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, shawnguo@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 15-08-22 18:52:28, Stefan Agner wrote:
> Hi Sanchayan,
> 
> On 2015-08-21 06:26, Sanchayan Maity wrote:
> > +static int vf50_ts_probe(struct platform_device *pdev)
> > +{
> > +	struct input_dev *input;
> > +	struct iio_channel *channels;
> > +	struct device *dev = &pdev->dev;
> > +	struct vf50_touch_device *touchdev;
> > +	int error;
> > +
> > +	channels = iio_channel_get_all(dev);
> > +	if (IS_ERR(channels))
> > +		return PTR_ERR(channels);
> 
> Hm, we expect here that four channels are returned, however a faulty
> device tree could contain less. Access to the fourth channel above would
> lead to a bug.
> 
> Can you check the amount of channels returned? The returned list is
> explicitly terminated with a null entry, you can rely on that. Something
> similar to hwmon should do the job.
> http://lxr.free-electrons.com/source/drivers/hwmon/iio_hwmon.c#L86

I agree. It did be nice to have this error check. Thanks. I will add
this check so we can bail out if less channels are specified.

- Sanchayan.

> 
> 
> Otherwise, Acked-by: Stefan Agner <stefan@agner.ch>
> 
> --
> Stefan
