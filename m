From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] Input: matrix-keypad - support binary column select
 gpios
Date: Wed, 20 Feb 2013 14:09:03 -0700
Message-ID: <51253B6F.10202@wwwdotorg.org>
References: <1359462324-7233-1-git-send-email-agust@denx.de> <1361388475-23705-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51138 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935519Ab3BTVJH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 16:09:07 -0500
In-Reply-To: <1361388475-23705-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 02/20/2013 12:27 PM, Anatolij Gustschin wrote:
> On hardware with limited gpios one column select gpio can select
> two different rows when using some additional hardware logic:
> high value selects one row, low value selects another row. Add
> support for such matrix keyboards and document device tree
> bindings used to describe them.
> 
> Since half of the columns is always not selected, interrupts won't be
> generated for press events on these columns. To generate interrupts
> for not selected columns we need to periodicaly switch to these columns
> in order to catch the potential press events. This is done by additional
> work function.

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +- col-gpios-binary:	specify that high and low states of a column gpio
> +			select two different rows (boards with limited gpios
> +			could support this by additional hardware logic)

1 GPIO and 2 columns is essentially a special case with a 1->2 line decoder.

Do the binding definition and code work fine if you have e.g. 3 GPIOs,
and a 3->8 decoder in order to support 8 columns?
