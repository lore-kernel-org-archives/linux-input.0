From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH Resend] Input: tegra-kbc- Convert to
 devm_ioremap_resource()
Date: Sun, 24 Feb 2013 22:48:08 -0800
Message-ID: <20130225064808.GB3735@core.coreip.homeip.net>
References: <1361764020-28728-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50923 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3BYGsM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 01:48:12 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1493305pbc.38
        for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 22:48:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361764020-28728-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, thierry.reding@avionic-design.de

On Mon, Feb 25, 2013 at 09:17:00AM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Rebased on the latest Linus' tree (v3.8+).

I do not have this yet. I will merge with mainline around rc3, please
ping me then.

Thanks.

-- 
Dmitry
