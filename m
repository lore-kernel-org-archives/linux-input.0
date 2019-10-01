Return-Path: <SRS0=p1C8=X2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB9C352AA
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8D21924
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569939854;
	bh=DtYd54/3IZfCY7nrpXq9zBTqzYtKRdKNAPE+LjcOMpA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=mBn7NKovR5ZrXApMmvm3Oirco+h+tFIrifr6xCsZ6EuT6rXQvnzt1A+E3UGuxkzQR
	 i5Ne1RWyLCbKAWsLSZnB/ZJHJbe6RpdBmBf1wzsYPAauPid0Qe5AKKlzwUz1Lf9n41
	 f4nO8P3nnWvnl/2vfXa+6gA16mwf2mOJyMO3ptHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJAOYN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbfJAOYN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Oct 2019 10:24:13 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9199E21855;
        Tue,  1 Oct 2019 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569939852;
        bh=DtYd54/3IZfCY7nrpXq9zBTqzYtKRdKNAPE+LjcOMpA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Srl7mAAYyU0K2eMjXKz7iFef2gX+7zh9HwRww3J2Nty1Z5K1Kdbgz1NgQh3UcG1Z0
         U8v9spZpVE7yuwcdKpKwgx2QSiPNrOusNJM98cvywSD5I0x13zHTB9gviogMaO779s
         zAr3n1ajP7bTLptEsfT5Q1ncxbE22cjHbaKKxLQE=
Date:   Tue, 1 Oct 2019 16:23:46 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
cc:     dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: hidraw: replace printk() with corresponding
 pr_xx() variant
In-Reply-To: <1568946901-29752-1-git-send-email-gupt21@gmail.com>
Message-ID: <nycvar.YFH.7.76.1910011623370.13160@cbobk.fhfr.pm>
References: <20190919161613.GR237523@dtor-ws> <1568946901-29752-1-git-send-email-gupt21@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191001142346.VXNnC-IyDfTmd_52WQ4vWtVuDz7Oqo_AjdgHdMuUlC0@z>

On Fri, 20 Sep 2019, Rishi Gupta wrote:

> This commit replaces direct invocations of printk with
> their appropriate pr_info/warn() variant.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v3:
> * Use hid_warn() subsystem specific variant instead of pr_warn()

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

