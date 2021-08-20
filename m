Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4DC4338F
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 12:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12EC6056B
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhHTMvf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhHTMvf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Aug 2021 08:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB4460187;
        Fri, 20 Aug 2021 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629463857;
        bh=aAtcJJqVawLbZdPSJij5oVeaN+x5/EoaK/wcOgW9tbQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=qRtsTDlXlAyc6dSLjgH6kKjJD2SG4VMs/0t4xRy1BWbooilpqjWUWOodt7qy+MfeX
         gWsjfCn9txxRuSrbQpkli9xH7mr4URMXC3TnGiOR36u6Pc7JCejDIVZLZ/l6NAVYsn
         fy0w4yoMEAyx350o80NOI3I83kxbApOW8aaHagWnkAy2k4FFHXZjMF90hldpio/MDN
         MgYHQ9k2mvmyUVDdviy2fSZK2M5MxJ73MSo1Et/e/DDvqcfmT2kPUAPQaEWCTKWQff
         Nvya56cftSW5tQy1pSHGkNzbVqGuPYZA2Ppag0ODhaibqOY7eMBY3vA/snZ77JIICS
         9AEBU+XjyFZOg==
Date:   Fri, 20 Aug 2021 14:50:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Luke D. Jones" <luke@ljones.dev>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH] HID: asus: Prevent Claymore sending suspend event
In-Reply-To: <20210807024921.26479-1-luke@ljones.dev>
Message-ID: <nycvar.YFH.7.76.2108201450460.15313@cbobk.fhfr.pm>
References: <20210807024921.26479-1-luke@ljones.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 7 Aug 2021, Luke D. Jones wrote:

> Prevent the ASUS Claymore keyboard from sending a suspend event
> when the device sleeps itself. The suspend event causes a system
> suspend if uncaught.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

