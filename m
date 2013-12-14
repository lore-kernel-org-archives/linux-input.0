From: Ken Phillis Jr <kphillisjr@gmail.com>
Subject: Re: Xpad Driver Replacement
Date: Fri, 13 Dec 2013 23:16:14 -0600
Message-ID: <CACiKS=SWfYQ58BN3tDGk7e2bg5vNVNw5XyxigVE80=hz2xJsVg@mail.gmail.com>
References: <52A40F19.3020109@computerquip.com>
	<52A68A23.7050707@computerquip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:56899 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3LNFQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 00:16:15 -0500
Received: by mail-qa0-f54.google.com with SMTP id f11so124711qae.6
        for <linux-input@vger.kernel.org>; Fri, 13 Dec 2013 21:16:15 -0800 (PST)
In-Reply-To: <52A68A23.7050707@computerquip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org

On Mon, Dec 9, 2013 at 9:27 PM, Zachary Lund <admin@computerquip.com> wrote:
>
>
> On 12/08/13 00:18, Zachary Lund wrote:
>>
>> Secondly, the Xbox 360 controllers claim to be HID compliant... this is not an HID driver. That's because the report descriptor is missing and I, unfortunately, do not know what to do about that. Some drivers like XBCD and the driver found at tattiebogle.net both provide their own report descriptor and work from there. While I'd like to do the same eventually, it will take me longer than a week to do that as I'd have to educate myself on HID and figure out what to do about the missing descriptors.
>
> I've run into an instant road block. The controller claims bInterfaceClass to be 0xFF (Vendor-specific) so usbhid won't probe it. I didn't think it would be so difficult to work around that but I've spent the better part of today trying to figure out just that. usbhid is a usb_driver that has only one requirement to be probed: bInterfaceClass be 0x03. Unfortunately, the device fails this requirement.
>
> Does anyone know of a way around this mechanism? Or perhaps I should take a different approach?
>

I agree that the XBOX 360 controller support should appear as a
separate driver. However the approach for detecting this should
instead rely on what microsoft has described as the "Xbox 360 Common
Controller class" (XUSB) [1]. The documentation surround the XINPUT
covers Audio and Joystick input. However I believe it is possible to
just cover the joystick input types ( and sub-controller types ) [2]
without overdoing the driver.

[1] MSDN Reference - DirectInput and XUSB
 http://msdn.microsoft.com/en-us/library/windows/desktop/hh405052%28v=vs.85%29.aspx

[2] MSDN Reference - XINPUT and sub-controller types.
http://msdn.microsoft.com/en-us/library/windows/desktop/hh405050%28v=vs.85%29.aspx
