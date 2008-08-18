From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [INPUT] removed unused #include <version.h>
Date: Mon, 18 Aug 2008 11:04:46 -0400
Message-ID: <20080818110400.ZZRA012@mailhub.coreip.homeip.net>
References: <20080817064601.160F.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:28650 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYHRPEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 11:04:51 -0400
Received: by qw-out-2122.google.com with SMTP id 3so128437qwe.37
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 08:04:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080817064601.160F.WEIYI.HUANG@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, Aug 17, 2008 at 07:50:53AM +0800, Huang Weiyi wrote:
> The drivers below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
>   drivers/input/keyboard/gpio_keys.c
>   drivers/input/mouse/gpio_mouse.c
>   drivers/input/tablet/gtco.c
> 
> This patch removes the said #include <version.h>.
> 

Folded with the other version.h removeal patch and applied, thank you.

-- 
Dmitry
