Return-Path: <SRS0=0DbS=YS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1839CA9EAF
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 02:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8836E21D7E
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571972291;
	bh=Pv99gGUhMu9Zgja2DFKQIDN8Qw7xgxA0yc7ICmoKRDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mbVvyUdSsFJK+Az1TufgJYM566Fbx/CFZ7Gu2SfeyqCtnzXgtw5GWwzn/Zb0eXZSc
	 y1SrYNv9OFucfeVncyfvf5igCZxjrXugFGPup3gApUQ7gaYTp7Sgnf22j4A6R1aGd3
	 mi+3+9yMduY2qt4xEq4qGc8vqylbPOyNTJDncbhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbfJYC6L (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389230AbfJYC6L (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Oct 2019 22:58:11 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637B221929;
        Fri, 25 Oct 2019 02:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571972290;
        bh=Pv99gGUhMu9Zgja2DFKQIDN8Qw7xgxA0yc7ICmoKRDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuU+++ByNPb4vYd9Mqpwhljltb614f8boUhgLiuDMDyMfQTP2aqBSaTKXOPgvF2II
         z/cFiR1dGsb1lADHuYNsXGhBM5OkTtzm5mQmoJdOiBesvf6vX1fWqQ3cxG6ikR6Bub
         5HX8T+4BtmczDfXie574pRiWPJRKv4bVG/opQvLY=
Date:   Fri, 25 Oct 2019 10:57:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 3/5] arm64: dts: imx8qxp: Add scu key node
Message-ID: <20191025025745.GA3208@dragon>
References: <1570412509-7893-1-git-send-email-Anson.Huang@nxp.com>
 <1570412509-7893-3-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB3916BA030CDAD9057017F52FF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916BA030CDAD9057017F52FF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Oct 18, 2019 at 01:40:10AM +0000, Anson Huang wrote:
> Hi, Shawn
> 	Dmitry has picked up the #1 and #2 patch, would you please pick up #3 ~ #5, thanks.
> 

Applied #3 ~ #5, thanks.

Shawn
