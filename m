From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
Date: Sat, 21 Jun 2014 16:55:52 -0300
Message-ID: <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
	<1402672899-6995-1-git-send-email-denis@eukrea.com>
	<1402672899-6995-3-git-send-email-denis@eukrea.com>
	<53A55BD8.7030905@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:51535 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbaFUTzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Jun 2014 15:55:54 -0400
In-Reply-To: <53A55BD8.7030905@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Carikli <denis@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>

On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> Could this not in theory fail?

Yes, but devm_ioremap_resource will take care of it, so we don't need
to check for error here.

>
>> +       mem = devm_ioremap_resource(dev, res);
>> +       if (!mem)
>> +               return -ENOMEM;
