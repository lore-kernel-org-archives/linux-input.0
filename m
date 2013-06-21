From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 07/12] input: keypad-matrix: introduce polling support
Date: Fri, 21 Jun 2013 15:38:11 -0600
Message-ID: <51C4C7C3.1070905@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-8-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49007 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945958Ab3FUViP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 17:38:15 -0400
In-Reply-To: <1371838198-7327-8-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> detecting changes in the key press status may not work reliably in
> interrupt driven mode (see the documentation part of the change for
> details)
> 
> add support to poll the matrix in software for reliable operation in the
> presence of multi key press events, leave a comment on how sleep and
> wakeup could be made to work appropriately in the polling case

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +The approach to enable all columns at the same time and to determine
> +that a key press status change has occured from row pin level changes
> +only works reliably for single key presses.  Multi key presses where the
> +keys share their position on a row line may get deferred or even could
> +go unnoticed, pressing and holding one key will shadow events which
> +another key on the same row would have generated.  When reliable
> +detection of key press events is required even in the presence of multi
> +key presses, interrupt mode isn't sufficient any longer, and polling
> +needs to be used.  The polling approach to detecting changes in the key
> +press status will periodically activate a single column line and check
> +the signals of the row lines.  Polling may also be applicable to setups
> +where the hardware doesn't support the activation of several columns at
> +the same time.

This feels a bit like encoding a driver implementation detail into the
DT binding.

Instead, couldn't the driver simply:

* When no keys are pressed, perhaps after a certain delay/timeout while
scanning, enable "interrupt mode".

* As soon as an interrupt is seen, switch back to "scanning mode".

* Once no keys are pressed again, go back to "interrupt mode".

That way, interrupt mode is only used while no key is pressed, and hence
there's no possibility of shadowing.

This can all be done without any need for DT binding changes.
