From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Mon, 14 Mar 2011 18:24:56 +0000
Message-ID: <20110314182456.33a591dc@lxorguk.ukuu.org.uk>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
	<4D7E36BA.2010007@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32799 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053Ab1CNSZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 14:25:10 -0400
In-Reply-To: <4D7E36BA.2010007@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Torokhov <dmitry.torokhov@gmail.com>

> It is a slim sysfs interface so for once I'm not going to moan  (much...)
> I'd prefer something with actual units rather than adc
> counts but can live with having this interface alongside something more
> generalizable.

It's not even ADC counts - the mpu3050 has its own processing.


> > +/* Methods for the sysfs attributes */
> > +static ssize_t mpu3050_show_power_mode(struct device *dev,
> > +		struct device_attribute *att, char *buf)
> > +{
> > +	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
> > +	int is_suspended = mpu3050_get_power_mode(sensor->client);
> 
> !is_suspended is cleaner.

Agreed - fixed

> > +	return sprintf(buf, "%d\n", is_suspended ? 0 : 1);
> > +}
> > +
> > +static ssize_t mpu3050_store_power_mode(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
> > +
> > +	if (!count || !(buf[0] == '1' || buf[0] == '0'))
> > +		return count;
> > +
> > +	mutex_lock(&sensor->lock);
> Could use the sysfs_streq function to deal with leading white space
> and other fun.  Also do we need the trinary operator?

Or just use strict_strtoul like other methods - Done


> > +static int mpu3050_runtime_resume(struct device *dev)
> > +{
> > +	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
> > +	mpu3050_set_power_mode(sensor->client, 1);
> > +	msleep(100);  /* wait for gyro chip resume */
> Could perhaps make the obvious connection between this and the non runtime
> versions more explicit? Just a thought...

I'll have a think about that at some point. There are some further long
term tweaks and those are probably going to make the two diverge however.

I'll post either a new driver or patches for the other tidying up
depending upon whether Dmitry merges the current submission.

Alan
