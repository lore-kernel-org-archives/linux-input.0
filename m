From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/3] Add device tree support for Goodix GT9xx series
 touchscreen controller
Date: Sat, 17 Jan 2015 21:37:26 +0100
Message-ID: <1421527046.2075.11.camel@hadess.net>
References: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50386 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbAQUil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jan 2015 15:38:41 -0500
In-Reply-To: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Sat, 2015-01-17 at 17:34 +0300, Aleksei Mamlin wrote:
> Provide device tree support and binding information.

What hardware is this enabling support for? The commit messages lack
that information.

> Aleksei Mamlin (3):
>   input: goodix: Add device tree support
>   dt-bindings: Add vendor-prefix for Goodix
>   input: goodix: Add bindings documentation
> 
>  .../bindings/input/touchscreen/gt9xx.txt           | 23 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/touchscreen/goodix.c                 | 10 ++++++++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/gt9xx.txt
> 


