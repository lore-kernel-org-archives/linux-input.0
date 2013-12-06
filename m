From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: use dev_get_platdata()
Date: Thu, 5 Dec 2013 19:23:57 -0800
Message-ID: <20131206032357.GB16530@core.coreip.homeip.net>
References: <000e01ceeff2$8b6f62e0$a24e28a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41442 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab3LFJbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 04:31:52 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so714356pdj.30
        for <linux-input@vger.kernel.org>; Fri, 06 Dec 2013 01:31:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <000e01ceeff2$8b6f62e0$a24e28a0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Wan ZongShun' <mcuos.com@gmail.com>, 'Josh Wu' <josh.wu@atmel.com>, 'Ferruh Yigit' <fery@cypress.com>

On Tue, Dec 03, 2013 at 03:40:23PM +0900, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead
> of accessing dev->platform_data directly. This is a cosmetic change
> to make the code simpler and enhance the readability.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Fugang Duan <B38611@freescale.com>

Applied, thank you.

-- 
Dmitry
