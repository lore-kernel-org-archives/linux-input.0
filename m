From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/6] iio: adc: fsl,imx25-gcq driver
Date: Mon, 23 Jun 2014 19:13:14 +0100
Message-ID: <53A86E3A.6000400@kernel.org>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com> <1402910933-20534-3-git-send-email-denis@eukrea.com> <53A563B0.60708@kernel.org> <53A85922.1000209@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60664 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaFWSLP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 14:11:15 -0400
In-Reply-To: <53A85922.1000209@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>

On 23/06/14 17:43, Denis Carikli wrote:
> On 06/21/2014 12:51 PM, Jonathan Cameron wrote:
>>> +static irqreturn_t mx25_gcq_irq(int irq, void *data)
>>> +{
>>> +    struct mx25_gcq_priv *priv = data;
>>> +    u32 stats;
>> Not that much in here, but perhaps still makes sense for this to be a
>> threaded
>> irq?
> What would be the advantage of converting it to be a threaded IRQ?
>
> I guess that there will be no use of IRQF_SHARED and that only this driver will have to handle the GCQ IRQ in the future.
>
Fair enough.  Was more of an idle thought that anything else!




