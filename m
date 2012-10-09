From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] Input: egalax_ts: get gpio from devicetree node
Date: Tue, 9 Oct 2012 11:58:32 +0000
Message-ID: <201210091158.33040.arnd@arndb.de>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com> <1345114051-3052-2-git-send-email-jason77.wang@gmail.com> <20120817003125.GA24242@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55712 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2JIL6j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Oct 2012 07:58:39 -0400
In-Reply-To: <20120817003125.GA24242@S2101-09.ap.freescale.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>, devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org

On Friday 17 August 2012, Shawn Guo wrote:
> On Thu, Aug 16, 2012 at 06:47:29PM +0800, Hui Wang wrote:
> > The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> > and don't support this API anymore.
> > 
> > The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> > and this platform already transfered to GENERIC_GPIO framework, to
> > support this driver, we use a more generic way to get gpio.
> > 
> > Add a return value checking for waking up the controller in the probe
> > function, this guarantee only a workable device can pass init.
> > 
> > Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> 
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

What's the status on this patch? I'm still getting build errors from this
driver, so I guess it was never accepted for the 3.7 merge window.

	Arnd
