From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2/2] Add a driver for the Winbond WPCD376I Consumer IR hardware
Date: Mon, 10 Aug 2009 09:39:53 -0600
Message-ID: <200908100939.54718.bjorn.helgaas@hp.com>
References: <20090809095645.198777507@hardeman.nu> <20090809095744.090206173@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:4582 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbZHJPkZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 11:40:25 -0400
In-Reply-To: <20090809095744.090206173@hardeman.nu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: david@hardeman.nu
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, randy.dunlap@oracle.com

On Sunday 09 August 2009 03:56:47 am david@hardeman.nu wrote:
> --- linux-2.6.orig/drivers/input/misc/Kconfig	2009-07-25 21:18:57.000000000 +0200
> +++ linux-2.6/drivers/input/misc/Kconfig	2009-08-07 21:45:41.000000000 +0200
> @@ -222,6 +222,22 @@
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sgi_btns.
>  
> +config INPUT_WINBOND_CIR
> +	tristate "Winbond IR remote control"
> +	depends on X86 && ACPI

This should depend on PNP, not ACPI.

> +#define WBCIR_ACPI_NAME	"Winbond CIR"

You might remove "ACPI" from "WBCIR_ACPI_NAME," since it has nothing
to do with ACPI.

Otherwise, looks good to me.

Bjorn


