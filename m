From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4] Input: matrix-keypad - Add device tree support
Date: Thu, 08 Nov 2012 09:55:33 -0700
Message-ID: <509BE405.60204@wwwdotorg.org>
References: <1352280725-452-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39118 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab2KHQzh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 11:55:37 -0500
In-Reply-To: <1352280725-452-1-git-send-email-anilkumar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, dgdunix@gmail.com, rob.herring@calxeda.com, linux-input@vger.kernel.org

On 11/07/2012 02:32 AM, AnilKumar Ch wrote:
> Add device tree support to matrix keypad driver and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +Optional Properties:

> +- clustered-irq:	have clustered irq number, that is needed if the irq
> +			is a combined irq source for the whole matrix keypad.
> +			This is useful if rows and columns of the keypad are
> +			connected to a GPIO expander.
> +- clustered-irq-flags:	clustered irq flags to specify the interrupt line
> +			behaviour among IRQF_TRIGGER_*

I still don't understand why there's a need for a clustered-irq-flags
property; if those flags are the flags for an interrupt, why aren't the
flags part of the clustered-irq interrupt specifier, just like any other
interrupt in DT?
