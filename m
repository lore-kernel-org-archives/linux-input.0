From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 6/7] input: cyapa: add of match device support and
 description document
Date: Fri, 12 Jun 2015 20:53:58 -0700
Message-ID: <20150613035358.GA18645@hudson.localdomain>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
 <1434092198-13018-7-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34037 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbFMDyA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 23:54:00 -0400
Content-Disposition: inline
In-Reply-To: <1434092198-13018-7-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se, bleung@google.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Fri, Jun 12, 2015 at 02:56:37PM +0800, Dudley Du wrote:
> Add of_match_device machanism support for Cypress trackpad device, and
> add the sample description document of adding the trackpad device node in DT.
> TEST=test on Chromebook.
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>
> ---
>  .../devicetree/bindings/input/cypress,cyapa.txt    | 44 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/mouse/cyapa.c                        | 10 +++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
> 
[...]
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 728cd0e..4813437 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -48,6 +48,7 @@ cnxt	Conexant Systems, Inc.
>  cortina	Cortina Systems, Inc.
>  cosmic	Cosmic Circuits
>  crystalfontz	Crystalfontz America, Inc.
> +cypress	Cypress Semiconductor Corporation
>  dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom	DAVICOM Semiconductor, Inc.
>  denx	Denx Software Engineering
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 86f2263..7e7613f 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -25,6 +25,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
>  #include "cyapa.h"
>  
>  
> @@ -1562,12 +1563,21 @@ static const struct acpi_device_id cyapa_acpi_id[] = {
>  MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id cyapa_of_match[] = {
> +	{ .compatible = "cypress,cyapa" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cyapa_of_match);
> +#endif
> +
>  static struct i2c_driver cyapa_driver = {
>  	.driver = {
>  		.name = "cyapa",
>  		.owner = THIS_MODULE,
>  		.pm = &cyapa_pm_ops,
>  		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
> +		.of_match_table = of_match_ptr(cyapa_of_match),
>  	},
>  
>  	.probe = cyapa_probe,
> -- 
> 1.9.1

This patch fails to apply on linux-next 20150611 because of difference
in vendor-prefixes.txt.  Probably just needs to be updated.

  Applying: input: cyapa: add of match device support and description
  document
  error: patch failed:
  Documentation/devicetree/bindings/vendor-prefixes.txt:48
  error: Documentation/devicetree/bindings/vendor-prefixes.txt: patch does
  not apply
  Patch failed at 0001 input: cyapa: add of match device support and
  description document

-- 
- Jeremiah Mahler
