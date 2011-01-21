From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: split hid-drff into general and ff parts
Date: Fri, 21 Jan 2011 01:52:43 -0800
Message-ID: <20110121095243.GD21842@core.coreip.homeip.net>
References: <1295602215-6056-1-git-send-email-spbnick@gmail.com>
 <1295602215-6056-2-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40322 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab1AUJwt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 04:52:49 -0500
Received: by iwn9 with SMTP id 9so1497507iwn.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 01:52:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295602215-6056-2-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>

On Fri, Jan 21, 2011 at 12:30:13PM +0300, Nikolai Kondrashov wrote:
> Split DragonRise Inc. HID gamepad driver (hid-drff.c) into a general
> (hid-dr.[hc]) and a force feedback part (hid-drff.c).
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
>  drivers/hid/Makefile   |    7 ++++-
>  drivers/hid/hid-dr.c   |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-dr.h   |   13 +++++++++
>  drivers/hid/hid-drff.c |   63 +-----------------------------------------
>  4 files changed, 92 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/hid/hid-dr.c
>  create mode 100644 drivers/hid/hid-dr.h
> 
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 6efc2a0..ea58795 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -25,6 +25,11 @@ ifdef CONFIG_LOGIWII_FF
>  	hid-logitech-y	+= hid-lg4ff.o
>  endif
>  
> +hid-dragonrise-objs		:= hid-dr.o
> +ifdef CONFIG_DRAGONRISE_FF
> +	hid-dragonrise-objs	+= hid-drff.o
> +endif

If you want to keep the 2 source files then I think you should write this as:

hid-dragonrise-y			:= hid-dr.o
hid-dragonrise-$(CONFIG_DRAGONRISE_FF)	+= hid-drff.o

Or maybe fold them into one?

-- 
Dmitry
