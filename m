From: Denis Carikli <denis@eukrea.com>
Subject: Re: [PATCH v3 3/6] iio: adc: fsl,imx25-gcq driver
Date: Mon, 23 Jun 2014 18:43:14 +0200
Message-ID: <53A85922.1000209@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com> <1402910933-20534-3-git-send-email-denis@eukrea.com> <53A563B0.60708@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:45533 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbaFWQnR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 12:43:17 -0400
In-Reply-To: <53A563B0.60708@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>

On 06/21/2014 12:51 PM, Jonathan Cameron wrote:
>> +static irqreturn_t mx25_gcq_irq(int irq, void *data)
>> +{
>> +    struct mx25_gcq_priv *priv = data;
>> +    u32 stats;
> Not that much in here, but perhaps still makes sense for this to be a
> threaded
> irq?
What would be the advantage of converting it to be a threaded IRQ?

I guess that there will be no use of IRQF_SHARED and that only this 
driver will have to handle the GCQ IRQ in the future.

Denis.
