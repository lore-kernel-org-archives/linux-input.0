From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Xpad Driver Replacement
Date: Thu, 19 Dec 2013 10:24:45 +0100
Message-ID: <CANq1E4SgjL+f9eVXm8KwejmkxHB5oV7hT_Hqb6mi9D=w_NvrBA@mail.gmail.com>
References: <52A40F19.3020109@computerquip.com>
	<52A68A23.7050707@computerquip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63542 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3LSJYq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 04:24:46 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so985786iec.37
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 01:24:45 -0800 (PST)
In-Reply-To: <52A68A23.7050707@computerquip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zachary Lund <admin@computerquip.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Dec 10, 2013 at 4:27 AM, Zachary Lund <admin@computerquip.com> wrote:
>
> On 12/08/13 00:18, Zachary Lund wrote:
>>
>> Secondly, the Xbox 360 controllers claim to be HID compliant... this is
>> not an HID driver. That's because the report descriptor is missing and I,
>> unfortunately, do not know what to do about that. Some drivers like XBCD and
>> the driver found at tattiebogle.net both provide their own report descriptor
>> and work from there. While I'd like to do the same eventually, it will take
>> me longer than a week to do that as I'd have to educate myself on HID and
>> figure out what to do about the missing descriptors.
>
> I've run into an instant road block. The controller claims bInterfaceClass
> to be 0xFF (Vendor-specific) so usbhid won't probe it. I didn't think it
> would be so difficult to work around that but I've spent the better part of
> today trying to figure out just that. usbhid is a usb_driver that has only
> one requirement to be probed: bInterfaceClass be 0x03. Unfortunately, the
> device fails this requirement.
>
> Does anyone know of a way around this mechanism? Or perhaps I should take a
> different approach?

Try adding it to:
  static const struct usb_device_id hid_usb_ids[]
in drivers/hid/usb-hid/hid-core.c
You should provide a fairly narrow match-line, though. You don't want
to match on all vendor-specific-class devices.

Cheers
David
