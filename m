From: Bastien Nocera <hadess@hadess.net>
Subject: Re: How to add support for Motorola RZ100?
Date: Thu, 23 Jul 2015 13:06:36 +0200
Message-ID: <1437649596.2863.7.camel@hadess.net>
References: <55B0C883.20001@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60016 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbbGWLIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 07:08:04 -0400
In-Reply-To: <55B0C883.20001@hanno.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hanno Zulla <abos@hanno.de>, linux-input@vger.kernel.org

On Thu, 2015-07-23 at 12:57 +0200, Hanno Zulla wrote:
> Hi there,
> 
> how can I help add support for the following device?
> 
> The "Motorola Smart Controller RZ100" is a combined telephony headset
> and HID touchpad with four Android-specific buttons. It is designed 
> to
> work as a remote control for Motorola Android devices.
> 
> <https://motorola-global
> -portal.custhelp.com/app/product_page/faqs/p/1422,7975,8227>
> 
> <http://www.amazon.com/Motorola-Bluetooth-Smart-Controller
> -Android/dp/B0060EKFYG>
> 
> It is possible to pair this device with my Linux box, see the log 
> output
> below.
> 
> Using hid-recorder, the incoming events can be seen. But none of the
> buttons or the touchpad are supported within my system.
> 
> How can I help adding this?

You could start with making the hid-recorder output available...

Cheers

