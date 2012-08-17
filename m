From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 2/3] Input: add devicetree binding note for egalax_ts
Date: Fri, 17 Aug 2012 08:32:11 +0800
Message-ID: <20120817003209.GB24242@S2101-09.ap.freescale.net>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44138 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab2HQAcK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 20:32:10 -0400
Received: by pbbrr13 with SMTP id rr13so2394735pbb.19
        for <linux-input@vger.kernel.org>; Thu, 16 Aug 2012 17:32:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thu, Aug 16, 2012 at 06:47:30PM +0800, Hui Wang wrote:
> The egalax_ts driver needs to get the gpio number of the irq pin,
> and use this gpio to wake up the controller. So add a note
> for this change.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
