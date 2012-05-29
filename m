From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: Input: ads7846 - sampling logic issues with AD7873
Date: Tue, 29 May 2012 14:25:38 +0200
Message-ID: <4FC4C042.5060100@analog.com>
References: <4FC4A93E.9040305@tqsc.de>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:6660
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750797Ab2E2M0D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 May 2012 08:26:03 -0400
In-Reply-To: <4FC4A93E.9040305@tqsc.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Niebel <list-09_linux_input@tqsc.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On 05/29/2012 12:47 PM, Markus Niebel wrote:
> Hi,
>
> we use the AD7873 controller with internal reference. The current implementation for AD7873 in the ads7846 driver forces the vref to switch off after every sample. So measurements especially in the edge of the screen become unreliable due to the settling time for the internal reference (I guess). Is there a special reason to override the "keep_vref_of" setting of the platform data for the AD7873 in ads7846_setup_spi_msg?
>
> We did already some tests and found out, that leaving vref on makes out system usable with AD7873.
>
> Markus
>
>
Hi Markus,

from top of my head - I don't remember why I forced Vref OFF for the AD7873.
Looking at the datasheet doesn't refresh my memory either.
I know there are some minor differences with respect to the PENIRQ 
behavior in one
PD bits combination - but that doesn't explain why we force it off.

 From a power savings aspect Vref should be turned off, but if
settling time worsens your results, then leaving Vref ON is the way to go.

Feel free to submit a patch.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


