From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Thu, 13 Feb 2014 10:32:03 +0800
Message-ID: <CAGsJ_4wzQYmNkd421vzau5BiTyewRX=vzEiy=BiSnttb+rEC8Q@mail.gmail.com>
References: <1392026859-4977-1-git-send-email-21cnbao@gmail.com> <20140212231131.GA29769@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56659 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaBMCcY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 21:32:24 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so10164107pad.27
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 18:32:23 -0800 (PST)
In-Reply-To: <20140212231131.GA29769@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-02-13 7:11 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Barry,
>
> On Mon, Feb 10, 2014 at 06:07:39PM +0800, Barry Song wrote:
>>
>>  static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>>  {
>> +     struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(&pdev->dev);
>> +
>>       device_init_wakeup(&pdev->dev, 0);
>>
>> +     cancel_delayed_work_sync(&pwrcdrv->work);
>> +
>
> This is racy: interrupt is freed later and can schedule work again.

thanks, Dmitry. i will do a manual devm_free_irq() before cancelling
the work and before devres removes the resources.

>
> Thanks.
>
> --
> Dmitry

-barry
