From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: Re: [PATCH] input: touchscreen: imx6ul_tsc: add mask when set
 REG_ADC_CFG
Date: Tue, 29 Nov 2016 14:36:51 +0200
Message-ID: <a842b4bd-f8ed-731e-5017-4ec74130506a@mobi-wize.com>
References: <1480322543-8518-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.47]:46382 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754693AbcK2NAM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 08:00:12 -0500
Received: from cm1.websitewelcome.com (cm.websitewelcome.com [192.185.0.102])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3A87C3204629A
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2016 06:36:57 -0600 (CST)
In-Reply-To: <1480322543-8518-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: fabio.estevam@nxp.com

On 28/11/2016 10:42, Haibo Chen wrote:
> Add mask of each function bits of REG_ADC_CFG, and clear these
> function bits first, otherwise use '|=' operation may get the
> wrong setting which depends on the original value of REG_ADC_CFG.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>   drivers/input/touchscreen/imx6ul_tsc.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
Reviewed-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
