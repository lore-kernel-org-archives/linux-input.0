From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 23:34:29 +0800
Message-ID: <1311608069.3262.8.camel@Allen>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com>
	 <20110725083048.GD22937@core.coreip.homeip.net>
	 <4E2D33E3.9090408@cn.fujitsu.com>  <20110725152106.GB23356@suse.de>
Reply-To: wanlong.gao@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36328 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1GYPen (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 11:34:43 -0400
Received: by pzk37 with SMTP id 37so8681593pzk.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2011 08:34:42 -0700 (PDT)
In-Reply-To: <20110725152106.GB23356@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 2011-07-25 at 08:21 -0700, Greg KH wrote:
> On Mon, Jul 25, 2011 at 05:14:11PM +0800, Wanlong Gao wrote:
> > On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:
> > >On Wed, Jul 20, 2011 at 11:34:28PM +0800, Wanlong Gao wrote:
> > >>It's better to set the device's driver data to NULL
> > >>when remove it.
> > >>
> > >
> > >I'd rather have platform devices core clean up this pointer, then we
> > >could stop caring about it in all drivers...
> > But the platform devices core just call the method of each own.
> > And don't care about the details like pdata, etc.
> > 
> > Meanwhile, I think the platform core need not care about these details.
> > 
> > and Greg, what do you think about this?
> 
> I don't understand what you are asking me.
Sorry, that's below:
firt for this patch:

> It's better to set the device's driver data to NULL
> when remove it.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  drivers/input/misc/pcap_keys.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/misc/pcap_keys.c
> b/drivers/input/misc/pcap_keys.c
> index 99335c2..6c670f5 100644
> --- a/drivers/input/misc/pcap_keys.c
> +++ b/drivers/input/misc/pcap_keys.c
> @@ -114,6 +114,8 @@ static int __devexit pcap_keys_remove(struct
> platform_device *pdev)
>         input_unregister_device(pcap_keys->input);
>         kfree(pcap_keys);
>  
> +       platform_set_drvdata(pdev, NULL);
> +
>         return 0;
>  }
> 
then, Dmitry said that:

> I'd rather have platform devices core clean up this pointer, then we
> could stop caring about it in all drivers...
> 

then I said:

> But the platform devices core just call the method of each own.
> And don't care about the details like pdata, etc.
> 
> Meanwhile, I think the platform core need not care about these
> details.
> 
> and Greg, what do you think about this?
> 
this is the thread, Greg, understand now?

For short, it's all about the platform driver data. Since many drivers
set the platform driver data to NULL when it is removed, then Dmitry
think it should be done in the platform driver core instead.
So, I asked you for this.

It's clear now?

Thanks a lot

