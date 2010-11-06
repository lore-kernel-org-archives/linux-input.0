From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Evdev uniq id
Date: Sat, 6 Nov 2010 02:45:45 -0700
Message-ID: <20101106094541.GA16663@core.coreip.homeip.net>
References: <4CD38B2B.3080200@netspace.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40538 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab0KFJp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 05:45:59 -0400
Received: by pzk28 with SMTP id 28so597764pzk.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 02:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CD38B2B.3080200@netspace.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell Shaw <rjshaw@netspace.net.au>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Russell,

On Fri, Nov 05, 2010 at 03:42:19PM +1100, Russell Shaw wrote:
> Hi,
> In X, i want an application program to apply settings to a specific
> mouse/puck device, regardless of how many other devices have been
> plugged in since the last session.
> 
> Prefereably, a manufacturer-model-serial_number call would be available
> from evdev.
> 
> Minimally, a uniq non-changing ID could be useful. I found this in
> linux-2.6.31.1/drivers/input/evdev.c:
> 
>   if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0)))
>     return str_to_user(dev->uniq, _IOC_SIZE(cmd), p);
> 
> How is "dev->uniq" constructed?

USB HID devices populate this field with data from descriptor.iSerialNumber.
I suppose we should do that in other USB drivers as well, patches are
welcome.

Thanks.

-- 
Dmitry
