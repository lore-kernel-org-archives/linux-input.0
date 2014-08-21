From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [RESEND PATCH 4/7] mfd: cros_ec: move locking into cros_ec_cmd_xfer
Date: Thu, 21 Aug 2014 12:24:53 +0200
Message-ID: <53F5C8F5.9030100@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>	<1408536812-7836-5-git-send-email-javier.martinez@collabora.co.uk> <CAD=FV=WAMKrmDTQbDrjR2XtFcNVUuzJfWspN5a7nE7kLWS9=4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43758 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbaHUKZB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 06:25:01 -0400
In-Reply-To: <CAD=FV=WAMKrmDTQbDrjR2XtFcNVUuzJfWspN5a7nE7kLWS9=4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hello Doug,

On 08/21/2014 12:36 AM, Doug Anderson wrote:
> Javier,
> 
> On Wed, Aug 20, 2014 at 5:13 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> From: Andrew Bresticker <abrestic@chromium.org>
>>
>> Now that there's a central cros_ec_cmd_xfer(), move the locking
>> out of the SPI and LPC drivers.
> 
> Slight nit that the LPC driver doesn't exist upstream.  This is in
> prep for adding the LPC driver, though.
> 

Right, the downstream commit was also touching the LPC driver and I
stripped that part but forget to update the commit message, sorry about
that. I'll fix it and do a re-spin.

> 
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  drivers/mfd/cros_ec.c     | 10 +++++++++-
>>  drivers/mfd/cros_ec_spi.c | 11 -----------
>>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> After comment nitfix:
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 

Thanks and best regards,
Javier
