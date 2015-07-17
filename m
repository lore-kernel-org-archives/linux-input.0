From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] input: snvs_pwrkey: add linux prefix for wakeup property
Date: Fri, 17 Jul 2015 11:46:25 +0800
Message-ID: <20150717034625.GD12927@tiger>
References: <1436930409-6536-1-git-send-email-shawnguo@kernel.org>
 <CAHrpEqS2o6_B6dNrnWJ06ASWaB0SGxur1o3VuN2A-QywWhbWVA@mail.gmail.com>
 <20150716183408.GD32571@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45309 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbGQDqe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 23:46:34 -0400
Content-Disposition: inline
In-Reply-To: <20150716183408.GD32571@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhi Li <lznuaa@gmail.com>, Frank Li <Frank.Li@freescale.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org

On Thu, Jul 16, 2015 at 11:34:08AM -0700, Dmitry Torokhov wrote:
> I should have said to use "wakeup-source", not simply "wakeup" so that
> we'd match with I2C annotation.

Yeah, consistency is the real motivation of this patch.  I do not
like that different properties are invented for the same purpose.  As it
seems that subsystems are all moving to "wakeup-source", I would be
happy to get it consistent with that.  V2 will be coming soon.

Shawn
