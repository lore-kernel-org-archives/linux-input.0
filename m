Return-Path: <SRS0=L/+t=42=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA2C10F27
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD342051A
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCILG0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:06:26 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59651 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILG0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2020 07:06:26 -0400
X-Originating-IP: 90.66.181.224
Received: from localhost (lfbn-lyo-1-2013-224.w90-66.abo.wanadoo.fr [90.66.181.224])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 655FEFF81F;
        Mon,  9 Mar 2020 11:06:09 +0000 (UTC)
Date:   Mon, 9 Mar 2020 12:06:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        gregkh@linuxfoundation.org, linux@rempel-privat.de,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        ronald@innovation.ch, krzk@kernel.org, robh@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Message-ID: <20200309110609.GE3563@piout.net>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 09/03/2020 08:38:14+0800, Anson Huang wrote:
> Add stubs for those i.MX SCU APIs to make those modules depending
> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- return error for stubs.

I'm not sure why you are sending v3 with the stubs as we determined that
2/7 is enough to compile all the drivers with COMPILE_TEST.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
