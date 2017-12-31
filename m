From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] input: pxrc: new driver for PhoenixRC Flight Controller Adapter
Date: Sun, 31 Dec 2017 21:26:10 +0100
Message-ID: <CAOFm3uG1Vq=L-rSdOHU4vfayUY-f-=TGYBvXdZx4bhvsDkVytA@mail.gmail.com>
References: <20171231200925.26424-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45558 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdLaU0w (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 31 Dec 2017 15:26:52 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so55631322wme.4
        for <linux-input@vger.kernel.org>; Sun, 31 Dec 2017 12:26:51 -0800 (PST)
In-Reply-To: <20171231200925.26424-1-marcus.folkesson@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Markus,

On Sun, Dec 31, 2017 at 9:09 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> This driver let you plug in your RC controller to the adapter and
> use it as input device in various RC simulators.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

<snip>

> --- /dev/null
> +++ b/drivers/input/joystick/pxrc.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0

<snip>

> +MODULE_LICENSE("GPL");

This MODULE_LICENSE means GPL 2.0 or later per module.h and this does
not match your top level SPDX tag which means GPL 2.0 only.
Could you make sure they are in sync?

-- 
Cordially
Philippe Ombredanne
