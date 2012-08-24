From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [PATCH 1/4] Input: cyttsp4 - bus driver for Cypress TMA4XX touchscreen
 devices
Date: Fri, 24 Aug 2012 16:06:40 +0300
Message-ID: <50377C60.4020008@cypress.com>
References: <Ferruh Yigit <fery@cypress.com> <1344344978-30453-1-git-send-email-fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.ihostexchange.net ([66.46.182.55]:42974 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2HXNGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Aug 2012 09:06:55 -0400
In-Reply-To: <1344344978-30453-1-git-send-email-fery@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin McNeely <kev@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, Shawn Landden <shawnlandden@gmail.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Olivier Sobrie <olivier@sobrie.be>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 08/07/2012 04:09 PM, Ferruh Yigit wrote:
> From: Ferruh YIGIT <fery@cypress.com>
>
> This driver is for Cypress TrueTouch(tm) Standard Product controllers,
> Generation4 devices.
>
> Driver consist of four main modules:
>
> Bus driver: Linux bus driver implementation, binds other modules.
> Core driver: Core module that communicate with TTSP controller.
> MT driver: MultiTouch driver, converts touch information to host specific
> touch events
> Adapter driver: Communication adapter between host and controller, like
> I2C or SPI.
>
> This is Cyttsp4 TTSP Bus Driver,
> Provides binding between Adapter, Core, and TTSP Modules.
>
> A complete set of corresponding Adapter, Core, and TTSP module
> devices and drivers must be registered with the TTSP Bus handler

Hi Henrik,

Is driver reviewed and is there anything we can help on it?

--

Thanks and Regards,
ferruh


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
