From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from matrix
 lines
Date: Fri, 21 Jun 2013 15:41:15 -0600
Message-ID: <51C4C87B.3050300@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-9-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52485 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945958Ab3FUVlS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 17:41:18 -0400
In-Reply-To: <1371838198-7327-9-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +The driver assumes that all interconnections of the matrix can potentially
> +contain a button, and will submit scan and key code events to the input
> +subsystem.  By default the keypad matrix dimenstions are automatically
> +derived from the GPIO pin specifications.  Optionally device tree
> +information can override the keypad matrix dimension data, e.g. when not
> +all of the potentially available physical connections are used to create
> +the logical keypad matrix.

Ignoring the binary encoding in the next patch, why would someone ever
define more row GPIOs that there are rows (or similarly for columns)?

On its own, I don't think this patch is needed.

Now, if you add binary encoding, I can see that you might have say 3 row
GPIOs but only say 6 rows even though there are 8 combinations of row
GPIO values. If that is the situation this patch is intended to cover,
the changes here should be introduced as part of, and only applicable
to, the binary encoding patch instead.
