From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: kernel panic on gpio-keys
Date: Sat, 14 Dec 2013 01:39:52 -0800
Message-ID: <20131214093900.GA10799@core.coreip.homeip.net>
References: <52A8BA49.7080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:63030 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3LNJkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 04:40:00 -0500
Received: by mail-pa0-f50.google.com with SMTP id kl14so1026250pab.9
        for <linux-input@vger.kernel.org>; Sat, 14 Dec 2013 01:40:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A8BA49.7080507@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <pcercuei@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 11, 2013 at 08:17:29PM +0100, Paul Cercueil wrote:
> Hi there,
> 
> I am trying to use the gpio-keys driver to inject joystick events.
> There seems to be some basic support of it, looking at <linux/gpio_keys.h>.
> 
> However, registering the following will trigger a kernel panic in
> the kernel:
> 
> static struct gpio_keys_button my_buttons[] {
> 	{
> 		.gpio = GPIO_FOO,
> 		.type = EV_ABS,
> 		.code = ABS_HAT0X,
> 		.value = 1,
> 	},
> };
> 
> (tested on kernel 3.12).
> 
> I don't know well the input subsystem, so I have no idea of what is
> going wrong. Could anybody try to at least reproduce the issue?

It woudl be helpful if you poster the stack trace from panic so we'd
have an idea where the fault happens.

Thanks.

-- 
Dmitry
