From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Thu, 21 Jul 2011 10:56:56 +0100
Message-ID: <20110721105656.1d579b0b@lxorguk.ukuu.org.uk>
References: <1311203359-23779-1-git-send-email-eric.andersson@unixphere.com>
	<1311203359-23779-2-git-send-email-eric.andersson@unixphere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45580 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318Ab1GUJyD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 05:54:03 -0400
In-Reply-To: <1311203359-23779-2-git-send-email-eric.andersson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Andersson <eric.andersson@unixphere.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, Albert Zhang <xu.zhang@bosch-sensortec.com>

Only detail thing I see is this trivial one:

> +static int bma150_open(struct bma150_data *bma150)
> +{
> +	int ret = bma150_set_mode(bma150->client, BMA150_MODE_NORMAL);
> +	msleep(2);
> +	return ret;

Does the msleep here need to be inside the mutex lock for the IRQ
case ?

Otherwise it looks good except that the lack of runtime pm means it'll
stop the rest of the bus heirarchy from suspending and breaks
suspend/resume on runtime_pm based systems. I think we still need runtime
pm taking the pm reference on the input open dropping it on the close and
that's about it ? That will be sufficient to let the i2c bus controller
also runtime suspend/resume.

Not so sure about the sysfs drop - but I think its probably the right
thing for upstream and any long term 'we need a fancy driver' would be
via IIO which would sort all the interface problems.

Alan
