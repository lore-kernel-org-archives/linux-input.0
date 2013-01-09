From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: mms114: Use devm_* APIs
Date: Wed, 9 Jan 2013 09:05:49 -0800
Message-ID: <20130109170549.GA7564@core.coreip.homeip.net>
References: <1357723353-11144-1-git-send-email-sachin.kamat@linaro.org>
 <50ED3CC0.10302@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:62259 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220Ab3AIRFx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 12:05:53 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so1067462pbc.16
        for <linux-input@vger.kernel.org>; Wed, 09 Jan 2013 09:05:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50ED3CC0.10302@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

On Wed, Jan 09, 2013 at 03:17:44PM +0530, Laxman Dewangan wrote:
> On Wednesday 09 January 2013 02:52 PM, Sachin Kamat wrote:
> >devm_* APIs are device managed and make the exit and clean up code
> >simpler.
> >
> >Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> >---
> 
> Acked-by: Laxman Dewangan<ldewangan@nvidia.com>
> 

Applied, thank you.

-- 
Dmitry
