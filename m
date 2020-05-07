Return-Path: <SRS0=FvaY=6V=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C5C38A2A
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 08:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0314B20753
	for <linux-input@archiver.kernel.org>; Thu,  7 May 2020 08:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgEGIPh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 7 May 2020 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbgEGIPc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 May 2020 04:15:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3AC061A41
        for <linux-input@vger.kernel.org>; Thu,  7 May 2020 01:15:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jWbgp-00011V-BU; Thu, 07 May 2020 10:15:31 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jWbgp-0004Sh-1W; Thu, 07 May 2020 10:15:31 +0200
Date:   Thu, 7 May 2020 10:15:31 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Mack <daniel@zonque.org>
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 2/3] Input: ads7846: Remove custom filter handling
 functions from pdata
Message-ID: <20200507081531.gu2gamtl4orvshd7@pengutronix.de>
References: <20200507062014.1780360-1-daniel@zonque.org>
 <20200507062014.1780360-4-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507062014.1780360-4-daniel@zonque.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:15:15 up 173 days, 23:33, 181 users,  load average: 0.18, 0.11,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 20-05-07 08:20, Daniel Mack wrote:
> The functions in the platform data struct to initialize, cleanup and
> apply custom filters are not in use by any mainline board.
> 
> Remove support for them to pave the road for more cleanups to come.
> 
> The enum was moved as it has no users outside of the driver code
> itself.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

