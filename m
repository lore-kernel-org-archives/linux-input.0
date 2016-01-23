From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 0/4] rotary-encoder: use generic device properties
Date: Sat, 23 Jan 2016 19:01:04 +0100
Message-ID: <87r3h8b2fz.fsf@belgarion.home>
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:35126 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbcAWSBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jan 2016 13:01:07 -0500
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
	(Dmitry Torokhov's message of "Mon, 18 Jan 2016 09:41:38 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@zonque.org>
Cc: linux-input@vger.kernel.org, Timo =?utf-8?Q?Ter=C3=A4s?= <timo.teras@iki.fi>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> Hi,
>
> This series tries to move the driver away from legacy platform data towards
> using platform-independent way of retrieving both configuration parameters and
> GPIOs (device_property_read_* and gpiod APIs).
>
> This is based on top of 2 Timo's patches converting the driver to use devm* API
> and threaded IRQs. I uploaded all changes into 'rotary-encoder' branch of my
> tree.
>
> I do not have hard ware so please give it a spin, especially on raumfield as it
> uses branch new way of passing platform parameters to the driver.

Hi Dmitry,

>From the pxa architecture point of view, it looks fine to me.
Daniel, I seem to remember you had this raumfeld hardware, would you have the
opportunity to give this serie a try ?

Cheers.

-- 
Robert
