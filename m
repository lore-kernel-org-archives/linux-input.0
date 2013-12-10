From: Zachary Lund <admin@computerquip.com>
Subject: Re: Xpad Driver Replacement
Date: Mon, 09 Dec 2013 21:27:31 -0600
Message-ID: <52A68A23.7050707@computerquip.com>
References: <52A40F19.3020109@computerquip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:54736 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3LJD1n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 22:27:43 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so3400329yha.26
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 19:27:42 -0800 (PST)
Received: from [10.8.0.10] (li40-72.members.linode.com. [72.14.178.72])
        by mx.google.com with ESMTPSA id b30sm20357215yhm.5.2013.12.09.19.27.41
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 19:27:41 -0800 (PST)
In-Reply-To: <52A40F19.3020109@computerquip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


On 12/08/13 00:18, Zachary Lund wrote:
> Secondly, the Xbox 360 controllers claim to be HID compliant... this 
> is not an HID driver. That's because the report descriptor is missing 
> and I, unfortunately, do not know what to do about that. Some drivers 
> like XBCD and the driver found at tattiebogle.net both provide their 
> own report descriptor and work from there. While I'd like to do the 
> same eventually, it will take me longer than a week to do that as I'd 
> have to educate myself on HID and figure out what to do about the 
> missing descriptors.
I've run into an instant road block. The controller claims 
bInterfaceClass to be 0xFF (Vendor-specific) so usbhid won't probe it. I 
didn't think it would be so difficult to work around that but I've spent 
the better part of today trying to figure out just that. usbhid is a 
usb_driver that has only one requirement to be probed: bInterfaceClass 
be 0x03. Unfortunately, the device fails this requirement.

Does anyone know of a way around this mechanism? Or perhaps I should 
take a different approach?
