Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D525C64EC4
	for <linux-input@archiver.kernel.org>; Fri, 10 Mar 2023 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCJSAb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCJSAa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2023 13:00:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8B11D08B;
        Fri, 10 Mar 2023 10:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 242C5B8237E;
        Fri, 10 Mar 2023 18:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D38C433EF;
        Fri, 10 Mar 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678471226;
        bh=ObCZO+01I36mLNnxpUvuqdmL3UoGCJEOZB8snLWBcCM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pkRP8JrzB9rOFCdFX9+LJif/KwYH8+YFc7AIT6DLEdimENfFMAw5+oEIxLcEqI6zE
         DuefO3EmpQdaESBH9lS/Xk9EdAvBL8peMAGEzY1URDuZ3WSaFsFvLmq1uNYXtdnrxR
         HtyUZKMfkCFRgDQLPjaTDzWYLur8Hw50c04bCKyb5KO45WF0QJ1MptM5mkEfGqstmP
         dEo5H0bpwcYpRB/3C11vm2EOi5etN2wAfbyz/nSYIA52i/NT3wiY1L3Z5MUrMoB9Pj
         ZEiAaHMXv5OxDHEw97/h9KvBOfcG3DtYMNucBUwuMd3+J8w5jevQBT51qpXzkFptVX
         ZotbwyPmxLtmw==
Date:   Fri, 10 Mar 2023 19:00:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alessandro Manca <crizan.git@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: topre: Add support for 87 keys Realforce R2
In-Reply-To: <20230310164933.4798-1-crizan.git@gmail.com>
Message-ID: <nycvar.YFH.7.76.2303101900190.1142@cbobk.fhfr.pm>
References: <20230310164933.4798-1-crizan.git@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 10 Mar 2023, Alessandro Manca wrote:

> The tenkeyless version of the Realforce R2 has the same issue of the
> full size one, the report fixup is needed to make n-key rollover
> work instead of 6 key rollover

Applied, thanks Alessandro.

-- 
Jiri Kosina
SUSE Labs

