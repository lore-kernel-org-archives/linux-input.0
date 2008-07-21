From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Device driver for
	Atmelintegratedtouchscreencontroller
Date: Mon, 21 Jul 2008 09:00:45 -0400
Message-ID: <20080721130045.GC19464@anvil.corenet.prv>
References: <0F5F73E36031FD46AD3F2E6948F0C0A020866D@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A0208916@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com> <20080719043440.GC29551@anvil.corenet.prv> <0F5F73E36031FD46AD3F2E6948F0C0A023EB9F@frimb01.corp.atmel.com> <20080721031913.GA14432@anvil.corenet.prv> <0F5F73E36031FD46AD3F2E6948F0C0A023ED7C@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:43734 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYGUNAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 09:00:49 -0400
Received: by an-out-0708.google.com with SMTP id d40so364032and.103
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2008 06:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0F5F73E36031FD46AD3F2E6948F0C0A023ED7C@frimb01.corp.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Liang, Dan" <Dan.Liang@atmel.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za, Justin Waters <justin.waters@timesys.com>

Hi Dan,

On Mon, Jul 21, 2008 at 11:55:35AM +0200, Liang, Dan wrote:
> 
> 
> Dmitry Torokhov wrote:
> > > Hi Dmitry,
> > >
> > > >  - The device does not seem to support pressure reading so I will drop
> > > >    ABS_PRESSURE reporting.
> > >
> > > I tried to remove the faked pressure report and tested with tslib. But there is an error message:
> > > "selected device is not a touchscreen I understand". And the touch screen seems not to work properly.
> > >
> > >
> > 
> > This is the problem with tslib and I am hoping that someone will find
> > the time to fix it there.
> 
> Hi Dmitry,
> 
> To make the driver to work properly before someone fixs tslib,
> I wonder if the ABS_PRESSURE reporting could be kept for the
> moment.

Then nobody will ever fix it ;)

> Other driver like "drivers/input/touchscreen/ads7846.c" also fakes
> the pressure value for ads7843 chip.
> 

I will take patches correcting this.

> And another issue, could you please add the copyright in
> "drivers/input/touchscreen/atmel_tsadcc.c":
>  * Copyright (c) 2008 TimeSys Corporation
>  * Copyright (c) 2008 Justin Waters
> 

Will do.

-- 
Dmitry
