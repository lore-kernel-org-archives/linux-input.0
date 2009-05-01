From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated
 with a  few fixes)
Date: Fri, 01 May 2009 14:15:34 +0100
Message-ID: <1241183734.20413.123.camel@cookie.hadess.net>
References: <167e8a330904280834i23dac0e0n3f859ced30a3e4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34285 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbZEANQc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 May 2009 09:16:32 -0400
In-Reply-To: <167e8a330904280834i23dac0e0n3f859ced30a3e4a7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping <pinglinux@gmail.com>
Cc: Andrew Zabolotny <zap@homelink.ru>, linux-input@vger.kernel.org

On Tue, 2009-04-28 at 08:34 -0700, Ping wrote:
> Hi Bastien,
> 
> Thank you for putting the Wacom Bluethooth support together.  I have
> two questions (I have to admit that I know nothing about Bluethooth.
> I know something about Wacom devices though :):
> 
> 1.          Should we follow the USB way to blacklist all Wacom
> Bluetooth devices so we don't have to add each product ID later on?
> Something like this should work (correct me if I am wrong):
> 
> { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, HID_ANY_ID) }, 
> 
> instead of 
> 
>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM,
> USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) }, 

We don't know whether the other Bluetooth tablets that appear will use
the same protocol. New devices wouldn't work as tablets, and they
wouldn't work as mice either, because we blacklisted them.

> 2.         Is it possible to merge hid/hid-wacom.c into
> input/tablet/wacom*?  From maintenance point of view, this would be
> easier for people to update the driver with future support (one place
> handles all common data between USB and Bluetooth devices of the
> similar models).

Yes, that's really what should happen, but until somebody actually does
the job, it's unlikely to happen. It's not that big a problem right now,
as the Bluetooth and USB devices don't share a protocol.

> I am glad to see that Wacom Bluetooth support is getting into the main
> stream.  

I'm actually still waiting for the patch to make it into the input
tree...

