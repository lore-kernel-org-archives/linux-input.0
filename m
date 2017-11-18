From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/10 v2] Input: cpcap-pwrbutton: Handle return value of
 platform_get_irq
Date: Sat, 18 Nov 2017 10:27:04 -0800
Message-ID: <20171118182704.2jtdu562iokx6zo2@dtor-ws>
References: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
 <20171118082122.GB31757@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34239 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965883AbdKRS1I (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 13:27:08 -0500
Content-Disposition: inline
In-Reply-To: <20171118082122.GB31757@n2100.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Sat, Nov 18, 2017 at 08:21:22AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 18, 2017 at 02:36:53AM +0530, Arvind Yadav wrote:
> > platform_get_irq() can fail here and we must check its return value.
> 
> The test should be <= 0, and you need to return an error code for the
> 0 case.

Instead of polluting the drivers with special handling of 0 vs negative
error we should have platform_get_irq[_byname] return -EINVAL if it sees
0.

Thanks.

-- 
Dmitry
