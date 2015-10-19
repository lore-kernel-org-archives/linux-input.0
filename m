From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH] hp_sdc: fixed y2038 problem
Date: Mon, 19 Oct 2015 11:01:50 +0200
Message-ID: <5041745.xAgMz1TQSE@wuerfel>
References: <1445161459-26918-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59552 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbJSJB4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 05:01:56 -0400
In-Reply-To: <1445161459-26918-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y2038@lists.linaro.org
Cc: WEN Pingbo <pingbo.wen@linaro.org>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sunday 18 October 2015 17:44:19 WEN Pingbo wrote:
> Two replacements happened in this patch:
>     1. using timespec64 to prevent time overflow in 2038
>     2. using ktime_get_ts64 to avoid wall time issues(leap second, etc)
> 
> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
> 

The patch looks correct, but I think this could be written a little
simpler and clearer using ktime_get() or ktime_getns().

	Arnd
