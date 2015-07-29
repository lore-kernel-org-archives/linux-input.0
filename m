From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Input: Merge max77843 haptic driver into max77693
Date: Wed, 29 Jul 2015 10:08:31 -0700
Message-ID: <20150729170831.GA23178@dtor-ws>
References: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33659 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbG2RIg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 13:08:36 -0400
Content-Disposition: inline
In-Reply-To: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>

On Wed, Jul 29, 2015 at 03:31:26PM +0900, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Description
> ===========
> The Maxim 77843 haptic driver differs from 77693 by:
> 1. Setting the bias.
> 2. Different configuration register.
> 3. Not enabling the low-sys DAC.
> 4. Using same regmap for PMIC and haptic blocks.
> 
> The patchset merges max77843 driver into the max77693.
> 
> 
> Dependencies
> ============
> The patchset *depends on* "regulator: Merge max77843 into max77693" [0]
> which was applied by Mark Brown (regulator tree). The mentioned
> regulator patchset actually changed also MFD drivers and other headers
> so the child drivers (like max77693 regulator or haptic) can be used
> with both max77693 and max77843 main MFD drivers.
> 
> 
> Merging ideas
> =============
> 0. Patches 1 and 2 can be applied directly.
> For rest of it (patches 3 and 4):
> 1. If this will go to v4.3, then maybe Mark Brown could prepare
>    an immutable branch (or a tag) with the [0] patchset?
> 2. If this will go to v4.4, then patchset can wait till MFD/regulator
>    changes reach Linus' tree.

How about 3: Mark merges it through his tree with:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

for the series?

Thanks!

-- 
Dmitry
