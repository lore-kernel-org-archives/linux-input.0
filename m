From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH V2] hp_sdc_rtc: fixed y2038 problem in proc_show
Date: Wed, 16 Sep 2015 15:55:37 +0200
Message-ID: <2616886.83FcmajDm5@wuerfel>
References: <3021182.6jgkaVHA9u@wuerfel> <1442411138-773-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55214 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbIPNzn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2015 09:55:43 -0400
In-Reply-To: <1442411138-773-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y2038@lists.linaro.org
Cc: WEN Pingbo <pingbo.wen@linaro.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org

On Wednesday 16 September 2015 21:45:38 WEN Pingbo wrote:
> hp_sdc_rtc_proc_show() use timeval to store the time, which will
> overflowed in 2038.
> 
> This patch fixes this problem by replacing timeval with timespec64.
> hp_sdc_rtc_proc_show() only output string, so that userspace will work
> normally if we apply this patch.
> 
> Not all timer in i8042 have y2038 risk(handshake, match timer, etc),
> Replacements in those timer are just for consistency.
> 
> Version 2 Updates:
> - compiled in m68k gcc cross compiler(4.6.3), no extra warnings
> - placed s64 type cast in tv.tv_sec, making sure it work properly in
> both 32bit and 64bit platform.
> 
> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
> Cc: Y2038 <y2038@lists.linaro.org>
> 

Looks very good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
