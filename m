From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Device driver for Atmel integrated
	touchscreencontroller
Date: Sat, 19 Jul 2008 00:34:40 -0400
Message-ID: <20080719043440.GC29551@anvil.corenet.prv>
References: <0F5F73E36031FD46AD3F2E6948F0C0A020866D@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A0208916@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:39228 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYGSEeo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2008 00:34:44 -0400
Received: by py-out-1112.google.com with SMTP id p76so532501pyb.10
        for <linux-input@vger.kernel.org>; Fri, 18 Jul 2008 21:34:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Liang, Dan" <Dan.Liang@atmel.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za

Hi Dan,

On Tue, Jul 15, 2008 at 12:06:22PM +0200, Liang, Dan wrote:
> Sorry again, the previous [PATCH 1/2] still has some formatting problems.
> 
> Now finally I fixed it.
> 
> The AT91SAM9RL SoC integrates a Touchscreen Controller which can trigger ADC conversion periodically.
> 

Overall looks good, just a couple of comments:

 - The device does not seem to support pressure reading so I will drop
   ABS_PRESSURE reporting.
 - The header file - is it needed? If there are no other users of this
   file expected I will fold it into the driver.

Thanks!

-- 
Dmitry
