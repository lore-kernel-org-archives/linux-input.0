From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BISECTED] Re: psmouse.c: GlidePoint at isa0060/serio1/input0
	lost sync at byte 1
Date: Tue, 15 Jan 2008 15:49:12 -0500
Message-ID: <20080115154142.ZZRA012@mailhub.coreip.homeip.net>
References: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com> <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com> <d120d5000801110647k4b1fa49ene974898baf745aec@mail.gmail.com> <478CFB56.1030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:6011 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYAOUtT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 15:49:19 -0500
Received: by an-out-0708.google.com with SMTP id d31so564754and.103
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 12:49:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <478CFB56.1030700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, William Pettersson <william.pettersson@gmail.com>

Hi Vegard,

On Tue, Jan 15, 2008 at 07:28:38PM +0100, Vegard Nossum wrote:
> # up/down scroll button
> drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, 0, 1) [592682]
> drivers/input/serio/i8042.c: df <- i8042 (interrupt, 1, 12) [596318]
> psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> drivers/input/serio/i8042.c: 21 <- i8042 (interrupt, 1, 12) [596321]
> psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, 1, 12) [596323]
> psmouse.c: GlidePoint at isa0060/serio1/input0 lost sync at byte 1
> drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, 1, 12) [596325]
> drivers/input/serio/i8042.c: 67 <- i8042 (interrupt, 1, 12) [596328]
> drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, 1, 12) [596331]

Thank you for the debug data. It looks like the scroll buttons on your
box send 0xdf instead of 0xcf. That should be pretty easy to fix, please
stay tuned.

-- 
Dmitry

