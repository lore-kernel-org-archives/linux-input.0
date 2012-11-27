From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: samsung-keypad - Use devm_* functions
Date: Tue, 27 Nov 2012 02:13:21 -0800
Message-ID: <20121127101320.GD25658@core.coreip.homeip.net>
References: <1354010091-31294-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33183 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557Ab2K0KNZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 05:13:25 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4178303dak.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 02:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354010091-31294-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org, Kukjin Kim <kgene.kim@samsung.com>

On Tue, Nov 27, 2012 at 03:24:51PM +0530, Sachin Kamat wrote:
> devm_* functions are device managed and make error handling
> and code simpler. While at it also fix error exit paths.
> 

Is this different from the version I sent you?

Thanks.

-- 
Dmitry
