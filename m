From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Tue, 29 Jun 2010 15:51:11 +0200
Message-ID: <201006291551.13148.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <201006221543.27169.linux@rainbow-software.org> <201006240856.16402.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1-out1.atlantis.sk ([80.94.52.55]:42123 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755773Ab0F2NvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 09:51:18 -0400
In-Reply-To: <201006240856.16402.oneukum@suse.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

On Thursday 24 June 2010, Oliver Neukum wrote:
> Am Dienstag, 22. Juni 2010, 15:43:24 schrieb Ondrej Zary:
> > On Tuesday 22 June 2010, Oliver Neukum wrote:
> > > This is a violation of the spec. Can you give me the IDs so that I can
> > > put the devices into the quirks file? Or can I take this from the
> > > driver? Do all devices that marked as always needing an irq transfer
> > > behave this way?
> >
> > This is not a bug surprise as this device is broken in many ways. It
> > takes ages to detect and identify and looks like cdc_acm. The
> > pseudo-multitouch capable protocol is pretty bad too. Also there are some
> > reports about devices using the same ID but different protocol.
> >
> > I have only one - 1870:0001, don't know anything about the other.
>
> OK, it seems like those devices are hopeless. Could you test this series
> form harmlessness on a broken device and functionality on a non-broken
> device?

Tested with:
0eef:0001 D-WAV Scientific Co., Ltd eGalax TouchScreen
595a:0001 IRTOUCHSYSTEMS Co. Ltd. Touchscreen
1870:0001 Nexio Co., Ltd iNexio Touchscreen controller

The patches have no visible effect on these devices so they're probably OK.

-- 
Ondrej Zary
