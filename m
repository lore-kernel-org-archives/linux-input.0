From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Device driver for Atmel
	integratedtouchscreencontroller
Date: Sun, 20 Jul 2008 23:19:14 -0400
Message-ID: <20080721031913.GA14432@anvil.corenet.prv>
References: <0F5F73E36031FD46AD3F2E6948F0C0A020866D@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A0208916@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com> <20080719043440.GC29551@anvil.corenet.prv> <0F5F73E36031FD46AD3F2E6948F0C0A023EB9F@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:35738 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbYGUDTR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 23:19:17 -0400
Received: by py-out-1112.google.com with SMTP id p76so918034pyb.10
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2008 20:19:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0F5F73E36031FD46AD3F2E6948F0C0A023EB9F@frimb01.corp.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Liang, Dan" <Dan.Liang@atmel.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za

On Mon, Jul 21, 2008 at 04:12:35AM +0200, Liang, Dan wrote:
> Hi Dmitry,
> 
> >  - The device does not seem to support pressure reading so I will drop
> >    ABS_PRESSURE reporting.
> 
> I tried to remove the faked pressure report and tested with tslib. But there is an error message:
> "selected device is not a touchscreen I understand". And the touch screen seems not to work properly.
> 
> 

This is the problem with tslib and I am hoping that someone will find
the time to fix it there.

-- 
Dmitry
