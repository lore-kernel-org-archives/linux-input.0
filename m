From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: imx6ul_tsc: add mask when set
 REG_ADC_CFG
Date: Wed, 30 Nov 2016 09:02:38 -0800
Message-ID: <20161130170238.GA31934@dtor-ws>
References: <1480322543-8518-1-git-send-email-haibo.chen@nxp.com>
 <a842b4bd-f8ed-731e-5017-4ec74130506a@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36774 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbcK3RCm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 12:02:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id x23so1841094pgx.3
        for <linux-input@vger.kernel.org>; Wed, 30 Nov 2016 09:02:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a842b4bd-f8ed-731e-5017-4ec74130506a@mobi-wize.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, linux-input@vger.kernel.org, fabio.estevam@nxp.com

On Tue, Nov 29, 2016 at 02:36:51PM +0200, Guy Shapiro wrote:
> On 28/11/2016 10:42, Haibo Chen wrote:
> >Add mask of each function bits of REG_ADC_CFG, and clear these
> >function bits first, otherwise use '|=' operation may get the
> >wrong setting which depends on the original value of REG_ADC_CFG.
> >
> >Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >---
> >  drivers/input/touchscreen/imx6ul_tsc.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> Reviewed-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Applied, thank you.


-- 
Dmitry
