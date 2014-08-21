From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [RESEND PATCH 1/7] mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
Date: Thu, 21 Aug 2014 15:49:31 +0200
Message-ID: <53F5F8EB.1020408@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk> <1408536812-7836-2-git-send-email-javier.martinez@collabora.co.uk> <20140821133747.GJ4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43881 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018AbaHUNti (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 09:49:38 -0400
In-Reply-To: <20140821133747.GJ4266@lee--X1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hello Lee,

On 08/21/2014 03:37 PM, Lee Jones wrote:
> On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:
>> From: Doug Anderson <dianders@chromium.org>
>> 
>> If someone sends a EC_CMD_REBOOT_EC to the EC, the EC will likely be
>> unresponsive for quite a while.  Add a delay to the end of the command
>> to prevent random failures of future commands.
>> 
>> NOTES:
>> * This could be optimized a bit by simply delaying the next command
>>   sent, but EC_CMD_REBOOT_EC is such a rare command that the extra
>>   complexity doesn't seem worth it.
>> * This is a bit of an "ugly hack" since the SPI driver is effectively
>>   snooping on the communication and making a lot of assumptions.  It
>>   would be nice to architect in some better solution long term.
> 
> Are you planning on doing that?
> 

Yes, I'll add to my TO-DO list to look how better solve this after the
remaining functionality that is present in downstream but is still not in
mainline gets merged.

>> * This same logic probably needs to be applied to the i2c driver.
>> 
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Reviewed-by: Randall Spangler <rspangler@chromium.org>
>> Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  drivers/mfd/cros_ec_spi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
> 
> I'm willing to accept this as a stand-in.
> 

Thanks.

> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Best regards,
Javier
