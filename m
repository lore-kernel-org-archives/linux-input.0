From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata to
 private struct
Date: Sun, 5 May 2013 20:24:44 -0700
Message-ID: <20130506032444.GD25084@core.coreip.homeip.net>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51893 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3EFDYq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 23:24:46 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so1754534pbc.15
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 20:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366889633-12577-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

Hi Daniel,

On Thu, Apr 25, 2013 at 01:33:52PM +0200, Daniel Mack wrote:
> In preparation for DT bindings, we have to store all runtime information
> inside struct ads7846. Add more variable to struct ads7846 and refactor
> some code so the probe-time supplied pdata is not used from any other
> function than the probe() callback.
> 

I think more common pattern is to allocate platform data structure when
parsing device tree, often with devm_kzalloc() so it is cleaned up after
driver is unbound.

Thanks.

-- 
Dmitry
