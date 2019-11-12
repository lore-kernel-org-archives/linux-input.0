Return-Path: <SRS0=z9zd=ZE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BEC43331
	for <linux-input@archiver.kernel.org>; Tue, 12 Nov 2019 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42721E6F
	for <linux-input@archiver.kernel.org>; Tue, 12 Nov 2019 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573572183;
	bh=C8pFx+z61g1o2Rqv59xs+NMVdBuyXFgC/DuTJsbFGM4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=wRun2njx15r9hv/OlIs6yYdv2KBx8TeZzgQmOGZN2EB3DAh1e0mEFCGoquJIXr3e3
	 EZkw45/4UinGFf50wWiVnV0cUi0QQRVICI0ZGGCWW5XPgiF1HsyfF3pzDcpbF4IMLQ
	 oyG/fYYbmr3PN7DRmf0Q32XoLJqAPWit6DaSaA5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLPXC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfKLPXC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Nov 2019 10:23:02 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10AD21D7F;
        Tue, 12 Nov 2019 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573572182;
        bh=C8pFx+z61g1o2Rqv59xs+NMVdBuyXFgC/DuTJsbFGM4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uH+r73cGBEMaC4rLWGr4x94nApsVJruY88nXPCBAwmE/g+2yDV3utHiqaNidtewmX
         gjDWUa4+NCaHDWcwcVWZw/VH3OIUpZ5bvZ6BdydTJMGNaK8NnE9dViuj59aFoD+1t7
         IA9iu83LuYtdCLTKyhrJGTFGhJCLXmiTuLwamr4I=
Date:   Tue, 12 Nov 2019 16:22:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Candle Sun <candlesea@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?GB2312?Q?=B5=D4=BE=A9_=28Orson_Zhai=29?= <orson.zhai@unisoc.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: Re: [PATCH v4] HID: core: check whether Usage Page item is after
 Usage ID items
In-Reply-To: <CAO-hwJKO5u6xUrBe_ne0OqFAHM9dpwtTOWtYW+3z-LxSFT6VWQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1911121621550.1799@cbobk.fhfr.pm>
References: <20191022142139.16789-1-candlesea@gmail.com> <nycvar.YFH.7.76.1911121457050.1799@cbobk.fhfr.pm> <CAO-hwJKO5u6xUrBe_ne0OqFAHM9dpwtTOWtYW+3z-LxSFT6VWQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 12 Nov 2019, Benjamin Tissoires wrote:

> The kernel patch is now OK, so we can grab it now (either you take it
> Jiri, and add my acked-by or I'll push it later...)

I've just queued it in for-5.5/core. Thanks,

-- 
Jiri Kosina
SUSE Labs

