Return-Path: <SRS0=0BCR=56=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC30C2BA19
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9887A206E9
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586855685;
	bh=vIPB95jP71/wZfkYY1Jl0maRvCI3/VPsvQxyrFC/qsU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=qJBaqx46pKWQqX3REtH+mArpxthiKMKGB+1SfalR0Q/WaUF49yLg1OdAj2ZFOFZRY
	 +Zh2TjgPGwZhNwy0pxX8TZTrjom/vKKNtCqCPTAWc9sNzclmiKX1wm0k2KYelPqsp1
	 cIDwdhgPUPi8sl3k/Eji8P5eDiCqBSN8JeKbQmss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437448AbgDNJOp (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437356AbgDNJOn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Apr 2020 05:14:43 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6BA20656;
        Tue, 14 Apr 2020 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586855683;
        bh=vIPB95jP71/wZfkYY1Jl0maRvCI3/VPsvQxyrFC/qsU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jSQiX6ifWi3Z0dKGh1AeVhQHX/hp5MRAG8zItVCaixLNSDqmY5FKN/kt4G8XHYPwH
         XxFhWL+jPRo4IBC/e45PPI9U0u4qPa8Da2uHHMpi4DS/f/3KEKQD2gBmJs46Eg6VXy
         flnY19xsmOxtUbEPgavch9KRStAiSqDDnbbCcr8M=
Date:   Tue, 14 Apr 2020 11:14:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] HID: multitouch: add eGalaxTouch P80H84 support
In-Reply-To: <20200413160237.610771-1-sebastian.reichel@collabora.com>
Message-ID: <nycvar.YFH.7.76.2004141114310.19713@cbobk.fhfr.pm>
References: <20200413160237.610771-1-sebastian.reichel@collabora.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 13 Apr 2020, Sebastian Reichel wrote:

> Add support for P80H84 touchscreen from eGalaxy:
> 
>   idVendor           0x0eef D-WAV Scientific Co., Ltd
>   idProduct          0xc002
>   iManufacturer           1 eGalax Inc.
>   iProduct                2 eGalaxTouch P80H84 2019 vDIVA_1204_T01 k4.02.146
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

