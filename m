From: "Liang, Dan" <Dan.Liang@atmel.com>
Subject: RE: [PATCH 1/2] Device driver for Atmel integratedtouchscreencontroller
Date: Mon, 21 Jul 2008 04:12:35 +0200
Message-ID: <0F5F73E36031FD46AD3F2E6948F0C0A023EB9F@frimb01.corp.atmel.com>
References: <0F5F73E36031FD46AD3F2E6948F0C0A020866D@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A0208916@frimb01.corp.atmel.com> <0F5F73E36031FD46AD3F2E6948F0C0A02089F8@frimb01.corp.atmel.com> <20080719043440.GC29551@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:56704 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758671AbYGUCNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 22:13:04 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080719043440.GC29551@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux@maxim.org.za

Hi Dmitry,

>  - The device does not seem to support pressure reading so I will drop
>    ABS_PRESSURE reporting.

I tried to remove the faked pressure report and tested with tslib. But there is an error message:
"selected device is not a touchscreen I understand". And the touch screen seems not to work properly.


>  - The header file - is it needed? If there are no other users of this
>    file expected I will fold it into the driver.

Currently the header file is used only by this touch screen driver although the peripheral can also work as a general ADC. The most common usage will be as a touch screen controller.


Thanks!

--
Dan

