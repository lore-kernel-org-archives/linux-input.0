From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Thu, 13 Feb 2014 14:48:09 +0800
Message-ID: <CAGsJ_4wzZFbw=+=sfMSGd0x2hitUYHoiuy_UZN9oTv7QfrZ=yw@mail.gmail.com>
References: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
 <20140212231131.GA29769@core.coreip.homeip.net> <CAGsJ_4wzQYmNkd421vzau5BiTyewRX=vzEiy=BiSnttb+rEC8Q@mail.gmail.com>
 <892ec8be-638e-48d6-9e7d-5175694a7eaf@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60842 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaBMGsa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:48:30 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so10329762pab.30
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:48:29 -0800 (PST)
In-Reply-To: <892ec8be-638e-48d6-9e7d-5175694a7eaf@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-02-13 11:41 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On February 12, 2014 6:32:03 PM PST, Barry Song <21cnbao@gmail.com> wrote:
>>2014-02-13 7:11 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>> Hi Barry,
>>>
>>> On Mon, Feb 10, 2014 at 06:07:39PM +0800, Barry Song wrote:
>>>>
>>>>  static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>>>>  {
>>>> +     struct sirfsoc_pwrc_drvdata *pwrcdrv =
>>dev_get_drvdata(&pdev->dev);
>>>> +
>>>>       device_init_wakeup(&pdev->dev, 0);
>>>>
>>>> +     cancel_delayed_work_sync(&pwrcdrv->work);
>>>> +
>>>
>>> This is racy: interrupt is freed later and can schedule work again.
>>
>>thanks, Dmitry. i will do a manual devm_free_irq() before cancelling
>>the work and before devres removes the resources.
>
> Another option would be to use devm custom action to ensure that work is canceled after freeing IRQ.

yes. you did a great job to have a devm_add_action() API.

>
>
> --
> Dmitry

-barry
