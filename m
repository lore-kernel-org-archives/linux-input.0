From: Eric Andersson <eric.andersson@unixphere.com>
Subject: Re: [PATCH v5 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Mon, 25 Jul 2011 12:38:26 +0200
Message-ID: <20110725103826.GA8594@scully.xfiles.lan>
References: <1311281268-9498-1-git-send-email-eric.andersson@unixphere.com>
 <1311281268-9498-2-git-send-email-eric.andersson@unixphere.com>
 <20110722051617.GB16040@core.coreip.homeip.net>
 <20110722094521.GB710@scully.xfiles.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:3321 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab1GYKip (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 06:38:45 -0400
Content-Disposition: inline
In-Reply-To: <20110722094521.GB710@scully.xfiles.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, alan@lxorguk.ukuu.org.uk, Albert Zhang <xu.zhang@bosch-sensortec.com>

Ping.

> > > +static int bma150_open(struct bma150_data *bma150)
> > > +{
> > > +#ifdef CONFIG_PM_RUNTIME
> > > +	return pm_runtime_get_sync(&bma150->client->dev);
> > > +#else
> > > +	return bma150_set_mode(bma150->client, BMA150_MODE_NORMAL);
> > 
> > Hmm, this is kind of weird. I'd expect you want to try waking up the
> > parent in both cases (if no runtime pm then call to pm_runtime_get_sync
> > is basically a noop) and then wake up your device.
> 
> I am not sure what you mean? Are you suggesting something like:
> 	bma150_set_mode(bma150->client, BMA150_MODE_NORMAL);
> 	return pm_runtime_get_sync(&bma150->client->dev);
> 
> That would cause multiple bma150_set_mode() calls since
> pm_runtime_get_sync() will trigger one if needed.

Dmitry, do you have any comments on the above? Just wanted to know
before I submit the next version.

-- 
Best regards,
 Eric

 http://www.unixphere.com
