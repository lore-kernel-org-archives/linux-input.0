From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] Input: ads7846 - allow specifying irq trigger type
 in platform data
Date: Mon, 31 May 2010 21:28:20 +0200
Message-ID: <20100531212820.322d5bfd@wker>
References: <1272630181-5364-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56620 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab0EaT2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 15:28:25 -0400
In-Reply-To: <1272630181-5364-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Detlev Zundel <dzu@denx.de>

Hi Dmitry,

On Fri, 30 Apr 2010 14:23:00 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> On some platforms, for example with GPIO interrupts
> on mpc5121, it is not possible to configure falling edge
> interrupts.
> 
> Specifying irq trigger type in platform data structure
> allows using ads7846 driver on such platforms.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/input/touchscreen/ads7846.c |    5 ++++-
>  include/linux/spi/ads7846.h         |    1 +
>  2 files changed, 5 insertions(+), 1 deletions(-)

Any comments on these patches?

Thanks,
Anatolij
