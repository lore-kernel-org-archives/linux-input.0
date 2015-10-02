From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH] input: gpio_keys: Make pdev vs dev usage more consistent
Date: Fri, 2 Oct 2015 12:07:41 -0700
Message-ID: <20151002190741.GY24668@usrtlx11787.corpusers.net>
References: <1438048218-742-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151002174708.GE8437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:16771 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbbJBTHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Oct 2015 15:07:46 -0400
Content-Disposition: inline
In-Reply-To: <20151002174708.GE8437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri 02 Oct 10:47 PDT 2015, Dmitry Torokhov wrote:

> On Mon, Jul 27, 2015 at 06:50:18PM -0700, Bjorn Andersson wrote:
> > As gpio_keys_setup_key() only operates on the device, pass a pointer to
> > this from the probe instead of a platform_device and make the usage
> > consistent. Also make probe() more consistent by dropping the local copy
> > of the device pointer.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> Don't really see the difference either way... We trade &pdev->dev for
> dev in one place and trade dev for &pdev->dev in another. I'd rather
> skip it.
> 
> Thanks.
> 

No worries, my dislike of the mixing of the two uses within the first
function was enough to hack up a patch - feel free to drop it as you
don't think it's worth the churn.


Thanks for merging the error handling patch though.

Regards,
Bjorn
