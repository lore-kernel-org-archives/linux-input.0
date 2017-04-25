From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Tue, 25 Apr 2017 11:55:00 +0200
Message-ID: <20170425115500.6d5c8bee@endymion>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
        <20170424094231.435f82de@endymion>
        <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52387 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1172524AbdDYKLL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 06:11:11 -0400
In-Reply-To: <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Andi,

On Tue, 25 Apr 2017 11:28:17 +0900, Andi Shyti wrote:
> On Mon, Apr 24, 2017 at 09:42:31AM +0200, Jean Delvare wrote:
> > The tm2-touchkey driver is only useful on specific platforms. Add the
> > missing hardware dependency so that the driver is not proposed on
> > systems where the device does not exist.
> 
> I'm sorry, I don't see any connection between Exynos and the
> TM2-touchkey (which is manufactured by cypress, btw).
> 
> It surely does have connections with the TM2 board which happens
> to have an Exynos SoC, but that cannot be fixed from the Kconfig.

Thanks for your constructive contribution to this discussion.

The KEYBOARD_TM2_TOUCHKEY option name, description and help text as
well as the driver name all make it sound highly hardware specific. If
this driver is for a "generic" part from Cypress then the driver should
be renamed and the Kconfig option name and description should be
updated to reflect that. The help text should also first mention the
chip vendor and name, and only then mention that it is used on the
Exynos5433 TM2 board.

That being said, I took a look at the driver, and while "cypress" is
indeed being mentioned as the vendor name, the chip name itself is
referred to as "tm2-touchkey", which isn't generic at all. You can't
identify the hardware under the name "tm2 touchkey" everywhere in the
driver and expect people to understand it is not board specific.

So it really boils down to this question: is that chip a generic part
from Cypress, and if so, what is the real part number? Or was is
designed privately by Cypress specifically for Samsung for this one
board (and possibly others to come)?

Thanks again,
-- 
Jean Delvare
SUSE L3 Support
