From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: cyttsp4 - remove useless NULL test from
 cyttsp4_watchdog_timer()
Date: Mon, 26 Aug 2013 00:16:36 -0700
Message-ID: <20130826071636.GB26405@core.coreip.homeip.net>
References: <CAPgLHd-VmhDGxLgx7T7BoTntOhOabG4j07u-fFtB0X3NVwOgyw@mail.gmail.com>
 <521AF58C.1010004@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58034 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab3HZHQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 03:16:39 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so3094072pdj.4
        for <linux-input@vger.kernel.org>; Mon, 26 Aug 2013 00:16:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <521AF58C.1010004@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, javier@dowhile0.org, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Mon, Aug 26, 2013 at 09:28:28AM +0300, Ferruh Yigit wrote:
> On 08/26/2013 09:00 AM, Wei Yongjun wrote:
> >From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> >Remove useless NULL test from cyttsp4_watchdog_timer().
> >
> >Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >---
> >v1 -> v2: remove NULL test instead.
> >   (was: Input: cyttsp4 - fix potential NULL pointer dereference in cyttsp4_watchdog_timer())
> >---
> >  drivers/input/touchscreen/cyttsp4_core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Acked-by: Ferruh Yigit <fery@cypress.com>

Applied, thank you.

-- 
Dmitry
