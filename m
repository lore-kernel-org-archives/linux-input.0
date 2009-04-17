From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 18:58:03 +0300
Message-ID: <49E8A70B.3020209@teltonika.lt>
References: <200904171640.14294.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 81-7-68-229.static.zebra.lt ([81.7.68.229]:38263 "EHLO
	teltonika.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758035AbZDQP6J (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 11:58:09 -0400
In-Reply-To: <200904171640.14294.hs4233@mail.mn-solutions.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

Holger Schurig wrote:
> The i.MX21 SoC has a built-in keypad controller, which this driver
> utilizes. As the keypad usually doesn't connect to a standard PC
> keyboard, but to the keyboard of a PDA-like device, I wrote the
> driver in a keyboard-layout agnostic way.
> 
> Instead, the driver reports each row/column key press and release
> via a platform-data supplied function. Board-specific code can than
> decode the input events from this and submit them.

IMO it would be better if board code would not provide "handle"
function, but instead it would provide 'keyboard <-> input event' map
structure/array.

> See the comments at the top of drivers/input/keyboard/mxc_keypad.c
> 
> Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>
