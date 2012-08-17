From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: imx6q-sabrelite: add eeti egalax
Date: Fri, 17 Aug 2012 08:33:31 +0800
Message-ID: <20120817003329.GC24242@S2101-09.ap.freescale.net>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-4-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58471 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2HQAda (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 20:33:30 -0400
Received: by pbbrr13 with SMTP id rr13so2396596pbb.19
        for <linux-input@vger.kernel.org>; Thu, 16 Aug 2012 17:33:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345114051-3052-4-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thu, Aug 16, 2012 at 06:47:31PM +0800, Hui Wang wrote:
> i.MX6Q sabrelite board uses i2c3 to connect an eeti egalax
> touchscreen controller, add it as an i2c slave device in the dts.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Looks good.  Will apply it after the driver part gets accepted.

-- 
Regards,
Shawn
