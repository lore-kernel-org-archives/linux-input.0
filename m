From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] Input: pmic8xxx-pwrkey - switch to using managed
 resources
Date: Mon, 16 Dec 2013 12:36:56 -0800
Message-ID: <20131216203656.GR21983@codeaurora.org>
References: <20131215120723.GA375@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:33791 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab3LPUg6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 15:36:58 -0500
Content-Disposition: inline
In-Reply-To: <20131215120723.GA375@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Sachin Kamat <sachin.kamat@linaro.org>, linux-kernel@vger.kernel.org

On 12/15, Dmitry Torokhov wrote:
> This simplifies error handling and device removal paths.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Thanks. Like I said on the other mail, I forgot to send this
patch along. This looks almost identical to what I had so I'm
happy.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
