From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 08/14] input: PCAP2 based touchscreen driver
Date: Fri, 21 Nov 2008 12:05:20 -0500
Message-ID: <20081121170518.GA4416@USFSHXP-002051>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org> <20081121160521.959037675@dodger.lab.datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:50245 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYKURF1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2008 12:05:27 -0500
Received: by yw-out-2324.google.com with SMTP id 9so459345ywe.1
        for <linux-input@vger.kernel.org>; Fri, 21 Nov 2008 09:05:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081121160521.959037675@dodger.lab.datenfreihafen.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stefan@datenfreihafen.org
Cc: eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Ribeiro <drwyrm@gmail.com>

On Fri, Nov 21, 2008 at 05:04:11PM +0100, stefan@datenfreihafen.org wrote:
> Touchscreen driver based on the PCAP2 multi function device.
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> 
> +
> +static int __devexit pcap_ts_remove(struct platform_device *pdev)
> +{
> +	ezx_pcap_unregister_event(PCAP_IRQ_TS);
> +
> +	del_timer_sync(&pcap_ts->timer);
> +
> +	input_unregister_device(pcap_ts->input);
> +	kfree(pcap_ts);
> +

Could pcap_ts->work be still running at this point?

> +	return 0;
> +}
> +
> +}
> +#else
> +
> +#define pcap_ts_suspend NULL
> +#define pcap_ts_resume  NULL
> +
> +#endif
> +
> +static struct platform_driver pcap_ts_driver = {
> +	.probe		= pcap_ts_probe,
> +	.remove		= __devexit_p(pcap_ts_remove),
> +	.suspend	= pcap_ts_suspend,
> +	.resume		= pcap_ts_resume,

I think it is preferred that .suspend and .resume assigments are
guarded by #ifdef CONFIG_PM, not creating NULL stubs as this will
(theoretically) allow removing .suspend and .resume pointers from
driver stucture when compiling without PM support.

Also try running through checkpatch.pl - there are a few warnings I'd
like to be fixed as well. Otherwise looks pretty good.

Oh, and you need to add your sign-off please. Thanks!

-- 
Dmitry
