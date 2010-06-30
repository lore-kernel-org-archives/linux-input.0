From: Alan Ott <alan@signal11.us>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 08:54:03 -0400
Message-ID: <4C2B3E6B.7060703@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>	<4C2A1FA0.6020704@signal11.us>	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz> <AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:50250 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab0F3MyG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 08:54:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 5C7781CCA9D4
	for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 08:54:04 -0400 (EDT)
In-Reply-To: <AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On 06/30/2010 07:14 AM, Amit Nagal wrote:
>
> sorry my mistake :
>
> what i wanted to ask was ioctl with which application can get
> input / output / feature<REPORT ID>  and<  REPORT LEN>  .
>
> Thanx&  Regards
> Amit Nagal
Amit,

There is a new ioctl() staged for the new merge window which will get 
and set feature reports. It is used like this:

         /* Set Feature */
         buf[0] = 0x9; /* Report Number */
         buf[1] = 0xff; /* data */
         buf[2] = 0xff;
         buf[3] = 0xff;
         res = ioctl(fd, HIDIOCSFEATURE(4), buf);

Is that what you're asking for, or are you asking for something which 
will tell you which reports are _available_ on the device, and what 
their lengths are? There is currently no way to report which reports are 
_available_. As Jiri said, HIDRAW does not do any parsing of the report 
descriptor. All data is passed "raw" from the user application to the 
device.

If you know what type of device you are talking to, then you shouldn't 
really need to parse the descriptor in software, because you'll know 
what the device supports, right?

Alan.

