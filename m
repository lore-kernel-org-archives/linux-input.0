From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mpr121: improve sensibility of touch key.
Date: Wed, 29 Jun 2011 01:26:45 -0700
Message-ID: <20110629082645.GE10299@core.coreip.homeip.net>
References: <1309365281-3444-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:64947 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab1F2I0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 04:26:51 -0400
Received: by pzk26 with SMTP id 26so833998pzk.10
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 01:26:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309365281-3444-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: linux-input@vger.kernel.org

On Thu, Jun 30, 2011 at 12:34:41AM +0800, Zhang Jiejing wrote:
> From: Jiejing Zhang <jiejing.zhang@freescale.com>
> 
> There was an Quick Charge bit in Electrode conf register
> should be set in init function, this bit was missed in
> chip's document, which may cause touch controller charge
> too slow to generate an interrupt.
> 
> Also, adjust the default vlaue of touch and release threshold
> to make touch key more sensitive, this fix touch may not sensitive
> after setup with plastic case.
> 
> Signed-off-by: Jiejing Zhang <jiejing.zhang@freescale.com>

Applied, thanks Zhang.

-- 
Dmitry
