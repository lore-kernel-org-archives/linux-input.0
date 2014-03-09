From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: drivers/input/input.c and a broken USB HID Contour ShuttlePRO v2
Date: Sun, 9 Mar 2014 10:19:07 -0700
Message-ID: <20140309171907.GC30196@kroah.com>
References: <531C8EF4.9090609@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57226 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaCIRS3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Mar 2014 13:18:29 -0400
Content-Disposition: inline
In-Reply-To: <531C8EF4.9090609@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Albrecht <harald.albrecht@gmx.net>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Mar 09, 2014 at 04:55:32PM +0100, Harald Albrecht wrote:
> I would like to improve support for the multimedia controllers from 
> Contour company, as there currently get relative events swalled by input.c.
> 
> The background: Contour seems to have messed up the USB HID descriptions 
> of their multimedia controller devices in that these report to use 
> relative axis when in fact they are creating EV_REL events with absolute 
> coordinate values. The problem here is, that mapping these events to 
> EV_ABS will break all existing software that supports these devices.
> 
> Unfortunately, drivers/input/input.c correctly swallows any relative 
> events with a relative movement value of zero...
> 
>     case EV_REL:
>        if (is_event_supported(code, dev->relbit, REL_MAX) && value)
>          disposition = INPUT_PASS_TO_HANDLERS;
>        break;
> 
> Simply removing the "&& value" would most probably have adverse effect 
> on many software. Unfortunately, there is yet no "quirks" handling 
> present in input.c.
> 
> How can I add such quirks handling in a way that would be acceptable by 
> the kernel maintainers?

The people on linux-input@vger.kernel.org (now cc:ed) might know more...
