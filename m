From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add mpr121 capacitive touchkey driver
Date: Mon, 11 Apr 2011 23:01:53 -0700
Message-ID: <20110412060153.GB1854@core.coreip.homeip.net>
References: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
 <20110411232010.GC3579@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54232 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1DLGB6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:01:58 -0400
Received: by iyb14 with SMTP id 14so6313363iyb.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 23:01:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110411232010.GC3579@lovely.krouter>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Jiejing Zhang <kzjeef@gmail.com>, linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>

On Tue, Apr 12, 2011 at 01:20:11AM +0200, Christoph Fritz wrote:
> On Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
> > +
> > +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
> > +
> > +static struct i2c_driver mpr_touchkey_driver = {
> > +	.driver = {
> > +		.name	= "mpr121",
> > +		.owner	= THIS_MODULE,
> > +		.pm	= &mpr121_touchkey_pm_ops,
> 
> I would add a ifdef CONFIG_PM_SLEEP
> 

No, since we could try supporting CONFIG_PM_RUNTIME for example (not
necessarily in this driver, but in general case). dev_pm_ops structire
is defined always but it contents change de3pending on CONFIG_PM_SLEEP.
CONFIG_PM_RUNTILE and so forth. At a minium it is an empty structure,
but it woudl still be defined.

Thanks.

-- 
Dmitry
