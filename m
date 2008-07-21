From: "Liang, Dan" <Dan.Liang@atmel.com>
Subject: RE: [PATCH 1/2] Device driver for Atmelintegratedtouchscreencontroller
Date: Mon, 21 Jul 2008 11:55:35 +0200
Message-ID: <0F5F73E36031FD46AD3F2E6948F0C0A023ED7C@frimb01.corp.atmel.com>
References: <0F5F73E36031FD46AD3F2E6948F0C0A020866D@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A0208916@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com> <20080719043440.GC29551@anvil.corenet.prv> <0F5F73E36031FD46AD3F2E6948F0C0A023EB9F@frimb01.corp.atmel.com> <20080721031913.GA14432@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:62670 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbYGUJ5j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 05:57:39 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080721031913.GA14432@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za, Justin Waters <justin.waters@timesys.com>



Dmitry Torokhov wrote:
> > Hi Dmitry,
> >
> > >  - The device does not seem to support pressure reading so I will drop
> > >    ABS_PRESSURE reporting.
> >
> > I tried to remove the faked pressure report and tested with tslib. But there is an error message:
> > "selected device is not a touchscreen I understand". And the touch screen seems not to work properly.
> >
> >
> 
> This is the problem with tslib and I am hoping that someone will find
> the time to fix it there.

Hi Dmitry,

To make the driver to work properly before someone fixs tslib, I wonder if the ABS_PRESSURE reporting could be kept for the moment. Other driver like "drivers/input/touchscreen/ads7846.c" also fakes the pressure value for ads7843 chip.

And another issue, could you please add the copyright in "drivers/input/touchscreen/atmel_tsadcc.c":
 * Copyright (c) 2008 TimeSys Corporation
 * Copyright (c) 2008 Justin Waters


Best regards
Dan

