From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: apbps2 - Convert to devm_ioremap_resource()
Date: Mon, 15 Apr 2013 13:40:04 -0700
Message-ID: <20130415204004.GA4374@core.coreip.homeip.net>
References: <1365411831-8021-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:36998 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3DOUkR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Apr 2013 16:40:17 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so2241773dae.3
        for <linux-input@vger.kernel.org>; Mon, 15 Apr 2013 13:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365411831-8021-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>

On Mon, Apr 08, 2013 at 02:33:51PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Daniel Hellstrom <daniel@gaisler.com>

Applied, thank you.

-- 
Dmitry
