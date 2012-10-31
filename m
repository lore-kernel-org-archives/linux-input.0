From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] Input: matrix-keypad - Add device tree support
Date: Wed, 31 Oct 2012 09:30:59 -0600
Message-ID: <50914433.1070805@wwwdotorg.org>
References: <1351684471-29369-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37721 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934513Ab2JaPbC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 11:31:02 -0400
In-Reply-To: <1351684471-29369-1-git-send-email-anilkumar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, dgdunix@gmail.com, rob.herring@calxeda.com, linux-input@vger.kernel.org

On 10/31/2012 05:54 AM, AnilKumar Ch wrote:
> Add device tree support to matrix keypad driver and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.

> diff --git a/Documentation/devicetree/bindings/input/matrix-keypad.txt b/Documentation/devicetree/bindings/input/matrix-keypad.txt
> new file mode 100644

> +- compatible:		Should be "gpio-matix-keypad"

There's a typo there.

Given that compatible value, shouldn't the file be named
gpio-matrix-keypad.txt then?

It seems like the property linux,keymap should be mentioned here too,
with a note to read matrix-keymap.txt for the definition.

> +Optional Properties:

> +- clustered-irq:	have clustered irq number
> +- clustered-irq-flags:	have clustered irq flags

Explaining what those mean would be useful.

