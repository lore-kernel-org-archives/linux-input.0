From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv2 1/2] drivers: input: keypad: Add device tree support
Date: Thu, 19 Apr 2012 09:23:49 -0600
Message-ID: <4F902E05.30503@wwwdotorg.org>
References: <1334848537-823-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35952 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab2DSPYC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Apr 2012 11:24:02 -0400
In-Reply-To: <1334848537-823-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 04/19/2012 09:15 AM, Sourav Poddar wrote:
> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.
> 
> Tested on omap4430 sdp with 3.4-rc3.

> diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt b/Documentation/devicetree/bindings/input/omap-keypad.txt

> +- Keys represented as child nodes: Each key connected to the keypad
> +  controller is represented as a child node to the keypad controller
> +  device node and should include the following properties.
> +  - keypad,row: the row number to which the key is connected.
> +  - keypad,column: the column number to which the key is connected.
> +  - linux,code: the key-code to be reported when the key is pressed
> +    and released.

Shouldn't this use the common matrix keymap bindings;
Documentation/devicetree/bindings/input/matrix-keymap.txt
