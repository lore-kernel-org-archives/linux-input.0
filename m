From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3 1/2] drivers: input: keypad: Add device tree support
Date: Mon, 23 Apr 2012 09:26:22 -0600
Message-ID: <4F95749E.40708@wwwdotorg.org>
References: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44640 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2DWP01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:26:27 -0400
In-Reply-To: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>

On 04/23/2012 09:27 AM, Sourav Poddar wrote:
> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.

Shouldn't this use the already-defined matrix keyboard bindings at
Documentation/devicetree/bindings/input/matrix-keymap.txt?

(I asked this before, but don't recall seeing any response explaining
why a new binding was needed. Sorry if I missed it.)
