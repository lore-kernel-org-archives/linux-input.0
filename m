From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 RESEND 1/3] Input: egalax_ts: get gpio from devicetree
Date: Wed, 10 Oct 2012 09:30:36 -0700
Message-ID: <20121010163036.GC19335@core.coreip.homeip.net>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com>
 <1349860323-12786-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:41361 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab2JJQal (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 12:30:41 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so259562dak.19
        for <linux-input@vger.kernel.org>; Wed, 10 Oct 2012 09:30:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349860323-12786-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: jiejing.zhang@freescale.com, shawn.guo@linaro.org, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Hui,

On Wed, Oct 10, 2012 at 05:12:01PM +0800, Hui Wang wrote:
> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> and don't support this API anymore.
> 
> The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> and this platform already transfered to GENERIC_GPIO framework, to
> support this driver, we use a more generic way to get gpio.

Unfortunately this does break the driver for platforms that do still
support irq_to_gpio and have not transitioned to device tree (yet?).
It looks like the API suffered from premature deletion...

I really do not want to add a new platform data structure with only gpio
in it, is there a better way to detect if irq_to_gpio() (even if only a
stub) is available?

Thanks.

-- 
Dmitry
