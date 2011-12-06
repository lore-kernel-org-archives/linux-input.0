From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()
Date: Tue, 6 Dec 2011 12:58:36 +0800
Message-ID: <CAN1soZwuTqiPC1wof6PfeLb3zhzm+w1WSUsJJQWmCS-3ECxTJw@mail.gmail.com>
References: <1323083592.6763.5.camel@phoenix>
	<20111205115054.GH11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37292 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389Ab1LFE6i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2011 23:58:38 -0500
In-Reply-To: <20111205115054.GH11150@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Dec 5, 2011 at 7:50 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Dec 05, 2011 at 07:13:12PM +0800, Axel Lin wrote:
>> Since commit 6384fd "ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ",
>> I got below buid errors due to implicit declaration of function 'IRQ_GPIO'.
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> I guess that for bisection this should go via Eric's tree as it
> introduced the issue.
> --
Sure. We'll handle it.

Best Regards
Haojian
