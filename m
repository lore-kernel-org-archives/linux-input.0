From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 0/4] input adxl34x: give a little love to the driver
Date: Thu, 20 Dec 2012 15:00:21 +0100
Message-ID: <50D319F5.8040705@analog.com>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:15422
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751882Ab2LTOBS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 09:01:18 -0500
In-Reply-To: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 12/20/2012 02:51 PM, Wolfram Sang wrote:
> Hi,
>
> I needed this driver in a project and there were some minor hurdles in getting
> it to run smoothly. These four patches are fixing them.
>
> Kind regards,
>
>     Wolfram
>
>
> Wolfram Sang (4):
>    input: adxl34x: consistently use read/write encapsulation
>    input: adxl34x: don't set THRESH_TAP twice
>    input: adxl34x: make platform_data include self contained
>    input: adxl34x: default platform_data should not use defines from
>      driver
>
>   drivers/input/misc/adxl34x.c  |    7 +++----
>   include/linux/input/adxl34x.h |    2 ++
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
looks good to me -

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


