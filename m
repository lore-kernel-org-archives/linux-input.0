Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E661C004D4
	for <linux-input@archiver.kernel.org>; Wed, 18 Jan 2023 09:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjARJxD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjARJwe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2023 04:52:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E318F6F9;
        Wed, 18 Jan 2023 01:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C921B81AA0;
        Wed, 18 Jan 2023 09:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA49C433EF;
        Wed, 18 Jan 2023 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032624;
        bh=Z+pgYC89S4+L9Jh7B8LqdM+hX7kbZdQaaYDpkoSrfUo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AoEz3tLJdGTcnf3EB1XpR03FJgWRmArpgneIhsAzB08HkkeLUKxcwLRxWqZBQ2hfd
         8XPDyEJ0qZE4+YR8WdtoUdq4We0LHcJ4fFhi9NqVPoiwDZ4ukt/H1P6xAN4U1r/AP4
         z50+HzzoS3JGPujCDZQvPyzzy9GKLeVgOYRqF5OY07JGXQn3AqcXcHSxNBciSETJ8t
         1OfUQtLDVRAoq/EeyQcw+RFWXk5JTZEpmMyxgFOXp3RPvCmroJ98wAldoPhXGwMoAy
         KPENEASbX6U92vhMxlVTDW48tZRjcYnGyafkNft1K3f+/9ijLYyPqyv1ZgDn6JUuVR
         rB61n61y8GrqA==
Date:   Wed, 18 Jan 2023 10:03:44 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lee Jones <lee@kernel.org>
cc:     benjamin.tissoires@redhat.com, avid.rheinsberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: Provide new max_buffer_size attribute to
 over-ride the default
In-Reply-To: <20230113150557.1308176-1-lee@kernel.org>
Message-ID: <nycvar.YFH.7.76.2301181002550.1734@cbobk.fhfr.pm>
References: <20230113150557.1308176-1-lee@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 13 Jan 2023, Lee Jones wrote:

> Presently, when a report is processed, its size is compared solely 
> against the value specified by user-space.  

While I am generally fine with the idea, I don't understand this sentence. 
What exactly do you mean by 'specified by user-space'? It's defined as a 
compile-time constant.

Thanks,

-- 
Jiri Kosina
SUSE Labs

