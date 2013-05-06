From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/9] Input: ab8500-ponkey - Remove redundant
 platform_set_drvdata()
Date: Sun, 5 May 2013 20:01:51 -0700
Message-ID: <20130506030151.GA25084@core.coreip.homeip.net>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:52075 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab3EFDBz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 23:01:55 -0400
Received: by mail-da0-f47.google.com with SMTP id k13so1612938dae.20
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 20:01:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, Sundar Iyer <sundar.iyer@stericsson.com>

On Sat, May 04, 2013 at 08:21:50PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied all series, thank you.

-- 
Dmitry
