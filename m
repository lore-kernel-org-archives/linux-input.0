From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Tue, 25 Apr 2017 11:28:17 +0900
Message-ID: <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
        <20170424094231.435f82de@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14009 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980012AbdDYC2V (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 22:28:21 -0400
Content-disposition: inline
In-reply-to: <20170424094231.435f82de@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Jean,

On Mon, Apr 24, 2017 at 09:42:31AM +0200, Jean Delvare wrote:
> The tm2-touchkey driver is only useful on specific platforms. Add the
> missing hardware dependency so that the driver is not proposed on
> systems where the device does not exist.

I'm sorry, I don't see any connection between Exynos and the
TM2-touchkey (which is manufactured by cypress, btw).

It surely does have connections with the TM2 board which happens
to have an Exynos SoC, but that cannot be fixed from the Kconfig.

Thanks,
Andi
