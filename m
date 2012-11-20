From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] input: added driver support for the t5400 pressure sensor.
Date: Tue, 20 Nov 2012 21:21:42 +0000
Message-ID: <201211202121.42414.arnd@arndb.de>
References: <1353445355-2517-1-git-send-email-stefan.nilsson@unixphere.com> <1353445355-2517-2-git-send-email-stefan.nilsson@unixphere.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65144 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab2KTVVp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 16:21:45 -0500
In-Reply-To: <1353445355-2517-2-git-send-email-stefan.nilsson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Nilsson <stefan.nilsson@unixphere.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rob.herring@calxeda.com, matthias.schmidt@epcos.com, armin.schober@epcos.com, eric.andersson@unixphere.com

On Tuesday 20 November 2012, Stefan Nilsson wrote:
> +Optional properties:
> +- gpio-irq: platform gpio pin connected to the t5400 irq pin
> +- op-mode: operation modes to be set according to enum t5400_op_mode in t5400.h
> +
> +Example of having the t5400 on an i2c bus:
> +
> +pressure@77 {
> +       compatible = "tdk-epcos,t5400";
> +       reg = <0x77>;
> +       gpio-irq = <18>;
> +       op-mode = <1>;

The way that the "gpio-irq" is specified doesn't look right. If you want to specify
a gpio line, use the gpio binding. If you just want to specify an interrupt, use the
"interrupts" property with a proper interrupt-parent.

> +       int gpio-irq;
> ...
> +       if (t5400->gpio-irq > 0) {
> +               error = request_threaded_irq(t5400->gpio-irq, NULL,


I'm pretty sure this doesn't even compile. '-' is not part of an identifier in C.

	Arnd
