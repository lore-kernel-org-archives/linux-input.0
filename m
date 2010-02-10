From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Add a device driver for the Apple Magic Mouse.
Date: Wed, 10 Feb 2010 14:06:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002101404210.30967@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <dd18b0c31002082322m4238a4a6m73fc30752ba30447@mail.gmail.com> <1265710460.2383.5685.camel@localhost.localdomain> <201002090736.55576.edt@aei.ca> <alpine.LNX.2.00.1002091339190.30967@pobox.suse.cz>
 <87y6j2eeqv.fsf_-_@troilus.org> <87pr4eeemz.fsf_-_@troilus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87pr4eeemz.fsf_-_-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 9 Feb 2010, Michael Poole wrote:

> >From da3e2b0330fccd584ad79495853e638e9652155b Mon Sep 17 00:00:00 2001
> From: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
> Date: Sat, 6 Feb 2010 12:24:36 -0500
> Subject: Add a device driver for the Apple Magic Mouse.
> 
> Signed-off-by: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
> ---
>  drivers/hid/Kconfig          |   10 +
>  drivers/hid/Makefile         |    1 +
>  drivers/hid/hid-core.c       |    1 +
>  drivers/hid/hid-ids.h        |    1 +
>  drivers/hid/hid-magicmouse.c |  469 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 482 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-magicmouse.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 24d90ea..ba14ec8 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -183,6 +183,16 @@ config LOGIRUMBLEPAD2_FF
>  	  Say Y here if you want to enable force feedback support for Logitech
>  	  Rumblepad 2 devices.
>  
> +config HID_MAGICMOUSE
> +	tristate "Apple" if EMBEDDED

Could you please make this something else than "Apple"? This string is 
already used by HID_APPLE.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
