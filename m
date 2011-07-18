From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: gpio-keys: do not reference platform_data after .probe exits
Date: Mon, 18 Jul 2011 10:02:44 -0700
Message-ID: <201107181002.45170.dmitry.torokhov@gmail.com>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org> <1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59411 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1GRRCu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 13:02:50 -0400
Received: by iwn6 with SMTP id 6so3264198iwn.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 10:02:50 -0700 (PDT)
In-Reply-To: <1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Phil Blundell <pb@handhelds.org>

On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> The patch makes a copy of platform data into driver data, so that any
> reference to platform_data after .probe exits can be avoided.

And why is this beneficial? I am of the opinion that platform data should
stay on (and be accessed through a const pointer to ensure that the driver
will not alter it).

Thanks.

-- 
Dmitry
