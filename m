From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad: sync device IDs with xboxdrv
Date: Mon, 8 Sep 2014 14:21:33 -0700
Message-ID: <20140908212133.GA24033@core.coreip.homeip.net>
References: <20140906144727.29b44f5a@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140906144727.29b44f5a@rechenknecht2k7>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ted Mielczarek <ted@mielczarek.org>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 06, 2014 at 02:47:27PM +0200, Benjamin Valentin wrote:
> The userspace xboxdrv driver knows some more device ids than the kernel.
> This patch adds the missing xbox gamepads from [1] to xpad.c
> 
> [1] https://github.com/Grumbel/xboxdrv/blob/master/src/xpad_device.cpp
> 
> Signed-off-by: Benjamin Valentin <benpicco@zedat.fu-berlin.de>


Applied, thank you.

-- 
Dmitry
