From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] Input: sentelic - filter taps in absolute mode
Date: Tue, 3 Apr 2012 09:46:47 -0700
Message-ID: <20120403164647.GD24832@core.coreip.homeip.net>
References: <20120401183037.GA23849@timantti.taisia.fi>
 <4F79B620.7030800@canonical.com>
 <4F79BE70.90005@ohmu.fi>
 <4F79C029.3040606@canonical.com>
 <4F79C7A0.6060601@ohmu.fi>
 <4F79D54E.4060500@canonical.com>
 <20120403065909.GA32166@timantti.taisia.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64965 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2DCQqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:46:54 -0400
Received: by dake40 with SMTP id e40so3870608dak.11
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 09:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120403065909.GA32166@timantti.taisia.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: Chase Douglas <chase.douglas@canonical.com>, Tai-hwa Liang <avatar@sentelic.com>, linux-input@vger.kernel.org

On Tue, Apr 03, 2012 at 09:59:09AM +0300, Oskari Saarenmaa wrote:
> Taps in absolute positioning single-finger mode are currently reported
> as physical clicks by the driver. This should be handled by userspace,
> not the kernel.
> 
> When a tap occurs, the FSP_PB0_LBTN bit is set, but the FSP_PB0_PHY_BTN
> is not. We use this to filter out physical clicks from taps.
> 
> Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>
> Reviewed-by: Tai-hwa Liang <avatar@sentelic.com> 
> Reviewed-by: Chase Douglas <chase.douglas@canonical.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Applied, thank you.

-- 
Dmitry
