Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D42C7EE23
	for <linux-input@archiver.kernel.org>; Tue, 23 May 2023 14:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEWOAH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 23 May 2023 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbjEWOAA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2023 10:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5701B1
        for <linux-input@vger.kernel.org>; Tue, 23 May 2023 06:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5C2626FD
        for <linux-input@vger.kernel.org>; Tue, 23 May 2023 13:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741E7C4339B;
        Tue, 23 May 2023 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684850353;
        bh=OGORBcGjLtdgfhPqiLxvWEykYvYAuLPrwI1WKBUDtfM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VVHM+G1iUMnjcxCxFfQ9SxgdSZ/wvPik0fSxU8J8+JCqNDsSefE9G0bProT7SLt2+
         W7tjazA+sbRvrorCKdfSntcVefSp1tj8Asy+MRzTEmE64jUpdU0BbGJvGXEmxfkrDU
         jTZ//L6JKwyn+VK2P6xIfgIDVhC6/3FII2Gu5wqNkPCyQpWYZlvWbT4beGfS1NEcPu
         RdUbf9ejHUrkbpIJgyRE9GSw1mt1ReJzmxWy9gCZgWROgR2cQfZfiIdd6m1SXmZmmx
         pdBblixWEowQvrLglowXnRH6pvGR+BK3Ar6BF7yBkY9gNZvqbMb1FgSE6SSlFuAI7p
         VcLKRjrluDV7Q==
Date:   Tue, 23 May 2023 15:59:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/5] cleanups to amd-sfh
In-Reply-To: <20230509065857.4170013-1-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2305231559000.29760@cbobk.fhfr.pm>
References: <20230509065857.4170013-1-Basavaraj.Natikar@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 9 May 2023, Basavaraj Natikar wrote:

> Changes of code cleanup includes duplicate log removal, cleanup
> sequence and spliting into multiple functional blocks.
> 
> Basavaraj Natikar (5):
>   HID: amd_sfh: Remove unnecessary log
>   HID: amd_sfh: Remove duplicate cleanup
>   HID: amd_sfh: Split sensor and HID initialization
>   HID: amd_sfh: Remove duplicate cleanup for SFH1.1
>   HID: amd_sfh: Split sensor and HID initialization for SFH1.1
> 
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 47 ++++++-------------
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 24 +++-------
>  2 files changed, 20 insertions(+), 51 deletions(-)

Now queued in hid.git#for-6.5/amd-sfh. 

Thanks,

-- 
Jiri Kosina
SUSE Labs

