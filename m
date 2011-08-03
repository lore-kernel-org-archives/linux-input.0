From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: ad7879: Fix deficient device disable
Date: Tue, 2 Aug 2011 22:20:26 -0700
Message-ID: <20110803052026.GB18560@core.coreip.homeip.net>
References: <1312289205-9936-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46075 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab1HCFUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 01:20:32 -0400
Received: by iyb12 with SMTP id 12so587554iyb.19
        for <linux-input@vger.kernel.org>; Tue, 02 Aug 2011 22:20:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312289205-9936-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com

On Tue, Aug 02, 2011 at 02:46:45PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Input close or device disable should not interact with the exported gpiolib
> functionality. However that's the case. __ad7879_disable() clears the
> entire AD7879_REG_CTRL2, while it should just power down the ADC and
> its reference.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Applied, thanks Michael.

-- 
Dmitry
