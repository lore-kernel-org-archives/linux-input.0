From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] soc_button_array: fix the issue that button device can't be enumerated since 3.16-rc1
Date: Wed, 09 Jul 2014 14:51:20 +0200
Message-ID: <8282078.gKYV3eC76j@vostro.rjw.lan>
References: <1404309504.8366.93.camel@rzhang1-toshiba> <2556427.cdnVoQoSXY@vostro.rjw.lan> <1404872845.26526.2.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63914 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756140AbaGIMdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 08:33:14 -0400
In-Reply-To: <1404872845.26526.2.camel@rzhang1-toshiba>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: dmitry.torokhov@gmail.com, yao.jin@intel.com, linux-input <linux-input@vger.kernel.org>

On Wednesday, July 09, 2014 10:27:25 AM Zhang Rui wrote:
> On Tue, 2014-07-08 at 22:50 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 02, 2014 10:01:53 PM Zhang Rui wrote:
> > > From c2ee1886ba230d9d93d2ea2f350b1dc1a2d5ead5 Mon Sep 17 00:00:00 2001
> > > From: Jin Yao <yao.jin@linux.intel.com>
> > > Date: Thu, 26 Jun 2014 10:26:44 +0800
> > > Subject: [PATCH] soc_button_array: fix the issue that button device can't be
> > >  enumerated since 3.16-rc1
> > 
> > Hi Rui,
> > 
> > For 3.16 I'm afraid we need to add the missing device ID to the PNP list.
> > It is too late to do the conversion at this point IMO and we can do it later.
> 
> Okay, then please take the patch below.
> 
> From 846c16d9d863723ef9a2d9722778bce0633ea24c Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 9 Jul 2014 10:19:38 +0800
> Subject: [PATCH] ACPI: add soc_button_array device id in acpi_pnp id list
> 
> soc_button_array pnp driver is introduced in 3.15.
> But in commit eec15edbb0e14485998635ea7c62e30911b465f0,
> when reworking the PNPACPI device enumeration, we missed
> the soc_button_array device id.
> 
> This results in a regression in 3.16-rc1 that soc_button_array
> pnp device fails to be enumerated.
> 
> Fix the problem by adding soc_button_array device id into the
> acpi_pnp scan handler id list.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Queued up as a fix for 3.16, thanks!

> ---
>  drivers/acpi/acpi_pnp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 6703c1f..4ddb0dc 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  
>  static const struct acpi_device_id acpi_pnp_device_ids[] = {
> +	/* soc_button_array */
> +	{"PNP0C40"},
>  	/* pata_isapnp */
>  	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
>  	/* floppy */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
