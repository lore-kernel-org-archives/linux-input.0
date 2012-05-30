From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: Re: Input: ads7846 - sampling logic issues with AD7873
Date: Wed, 30 May 2012 19:53:11 +0200
Message-ID: <4FC65E87.1040805@tqsc.de>
References: <4FC4A93E.9040305@tqsc.de> <4FC4C042.5060100@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:34942 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab2E3RxS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 May 2012 13:53:18 -0400
In-Reply-To: <4FC4C042.5060100@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Am 29.05.2012 14:25, wrote Michael Hennerich:
> On 05/29/2012 12:47 PM, Markus Niebel wrote:
>> Hi,
>>
>> we use the AD7873 controller with internal reference. The current implementation for AD7873 in the ads7846 driver forces the vref to switch off after every sample. So measurements especially in the edge of the screen become unreliable due to the settling time for the internal reference (I guess). Is there a special reason to override the "keep_vref_of" setting of the platform data for the AD7873 in ads7846_setup_spi_msg?
>>
>> We did already some tests and found out, that leaving vref on makes out system usable with AD7873.
>>
>> Markus
>>
>>
> Hi Markus,
> 
> from top of my head - I don't remember why I forced Vref OFF for the AD7873.
> Looking at the datasheet doesn't refresh my memory either.
> I know there are some minor differences with respect to the PENIRQ behavior in one
> PD bits combination - but that doesn't explain why we force it off.
> 
> From a power savings aspect Vref should be turned off, but if
> settling time worsens your results, then leaving Vref ON is the way to go.
> 
> Feel free to submit a patch.
> 
Hi Michael,

did some research in the datasheet for AD7873 and ADS7846 together with collegues from the hardware and also in the history for the driver.

1) in principal the initial support for AD7873 is correct. Vref is not needed for ratiometric measurement.
2) there was a patch (commit	de2defd96d7d92fe8b5f9cf2bfd385d8d4819923, "Input: ads7846 - optionally leave Vref on during differential measurements" which states, that leaving vref on can result in much improved measurement results.

I will change the patch as you suggested in your comment and refer the above fact in the patch comment.

Markus
