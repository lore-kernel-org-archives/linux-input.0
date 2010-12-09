From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 0/8] input: gpio_keys_polled fixes
Date: Thu, 9 Dec 2010 16:36:50 -0500
Message-ID: <AANLkTim_vAeWVKzhSks0kw3_WBoAp4VxdcJRqfLH6uLm@mail.gmail.com>
References: <4CF541ED.80905@openwrt.org>
	<1291142663-1011-1-git-send-email-juhosg@openwrt.org>
	<AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
	<20101209000600.GF15294@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49970 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754919Ab0LIVgw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 16:36:52 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so14128qyj.12
        for <linux-input@vger.kernel.org>; Thu, 09 Dec 2010 13:36:50 -0800 (PST)
In-Reply-To: <20101209000600.GF15294@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Hi Dmitry,

On Wed, Dec 8, 2010 at 7:06 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Ok, so driver is in mainline now [...]

I see it in v2.6.37-rc5 (at 0e7d0c860a0dee49dacb7bbb248d1eba637075ad
). With all the changes proposed folded-in and even a little Kconfig
help text fixup. It is (still) working as expected.

Thank you very much for picking up the driver changes...

> [...] and you should have no problems with
> merging your platform code in .38 merge window.

and thank you for the vote of confidence. I will post an updated
version shortly.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
