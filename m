From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/4] HID: remove ThingM blink(1) driver
Date: Wed, 22 Jun 2016 15:25:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606221520340.6874@cbobk.fhfr.pm>
References: <f8c59082-d76c-73aa-70b6-7454b731a055@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f8c59082-d76c-73aa-70b6-7454b731a055@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Jun 2016, Heiner Kallweit wrote:

> Now that support for ThingM blink(1) was merged into the hid-led driver
> the dedicated driver for this device can be removed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/hid/Kconfig      |  10 --
>  drivers/hid/Makefile     |   1 -
>  drivers/hid/hid-thingm.c | 259 -----------------------------------------------
>  3 files changed, 270 deletions(-)
>  delete mode 100644 drivers/hid/hid-thingm.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index ab22090..6b08a3b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -828,16 +828,6 @@ config HID_TOPSEED
>  	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
>  	CLLRCMCE remote control.
>  
> -config HID_THINGM

Overall the patchset looks good to me. I'd suggest we keep 
CONFIG_HID_THINGM as a stub though, that'd just select CONFIG_HID_LED, so 
that we don't cause kernel config regressions for users who had 
CONFIG_HID_THINGM already turned on.

Also adding Vivien Didelot to CC, as the author of the original driver. 
Vivien, the full set can be found in linux-input archives ( 
http://marc.info/?l=linux-input&r=1&b=201606&w=2 )

-- 
Jiri Kosina
SUSE Labs
