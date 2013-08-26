From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [PATCH v2] Input: cyttsp4 - remove useless NULL test from cyttsp4_watchdog_timer()
Date: Mon, 26 Aug 2013 09:28:28 +0300
Message-ID: <521AF58C.1010004@cypress.com>
References: <CAPgLHd-VmhDGxLgx7T7BoTntOhOabG4j07u-fFtB0X3NVwOgyw@mail.gmail.com>
Reply-To: fery@cypress.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59033 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab3HZG2m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 02:28:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3023749pbb.19
        for <linux-input@vger.kernel.org>; Sun, 25 Aug 2013 23:28:38 -0700 (PDT)
In-Reply-To: <CAPgLHd-VmhDGxLgx7T7BoTntOhOabG4j07u-fFtB0X3NVwOgyw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: javier@dowhile0.org, dmitry.torokhov@gmail.com, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On 08/26/2013 09:00 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Remove useless NULL test from cyttsp4_watchdog_timer().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> v1 -> v2: remove NULL test instead.
>    (was: Input: cyttsp4 - fix potential NULL pointer dereference in cyttsp4_watchdog_timer())
> ---
>   drivers/input/touchscreen/cyttsp4_core.c | 3 ---
>   1 file changed, 3 deletions(-)

Acked-by: Ferruh Yigit <fery@cypress.com>

--
ferruh
