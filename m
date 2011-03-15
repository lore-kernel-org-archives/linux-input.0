From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Tue, 15 Mar 2011 11:59:30 +0000
Message-ID: <4D7F54A2.2020501@cam.ac.uk>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk> <20110315060203.GF1046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56405 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab1COL62 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 07:58:28 -0400
In-Reply-To: <20110315060203.GF1046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-input@vger.kernel.org

On 03/15/11 06:02, Dmitry Torokhov wrote:
> Hi Alan,
> 
> On Wed, Mar 09, 2011 at 01:47:51PM +0000, Alan Cox wrote:
>> From: Joseph Lai <joseph_lai@wistron.com>
>>
>> This driver is registered as an input device with sysfs control
>> interface, but it still can output 3 axes data in non-interrupt mode.
>>
>> This is primarily an input device but can also be used as for other things.
>> It thus exposes the power control (so you can keep power on when you want) and
>> x/y/z co-ordinates directly.
> 
> I'd be more happy if it was just an input device. If non-wired interrupt
> is a common case then we should probably add polled input device mode,
> but we certainly should not register completely non-functional input
> device as the driver does now.
> 
> We also have a way of retrieving current (or rather most recent)
> coordinates via EVIOCGABS so I am not sure why we want the sysfs way of
> retrieving coordinates as well.
> 
> Regarding power mode - I really believe that this should be done on the
> driver core level instead of implementing "manual off" in every single
> driver out there.
definitely.  Know anyone with the time / inclination to get that added?
