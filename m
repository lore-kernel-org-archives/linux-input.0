Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776DDC7EE29
	for <linux-input@archiver.kernel.org>; Fri,  9 Jun 2023 15:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbjFIPmG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjFIPlf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2023 11:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D83588;
        Fri,  9 Jun 2023 08:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E8BA6594A;
        Fri,  9 Jun 2023 15:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8DEC433EF;
        Fri,  9 Jun 2023 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325291;
        bh=D9BRGojXtiVX/FpQDfUF2IkmBGVctRI5JTe2iHqd9Mk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AUjBxF6pYnEFCfHl2RA1q9jo1v+DdzmiXm+FdJZZiKXQ4uxOigl0tfJH1sAeVYKTj
         i46bEkpys88X4CoQt9gUEoUrQs2jT2BfbSOzgVgfyd9EXW+bhjujPokJx7tEgVv1aq
         +s7folPg5KIloE5Qm0za8hB5eTGLxukCgJlr0xsjq6Z65GF5d/EI4NZnjR6XaapHYe
         dlf58qAVVPn2SlmnEjzEETlYU36HBPcWTrudjUJMRGYeA5jzJnCB6zdxfYrL74q77W
         vqflsw3G4FiGDwNJJ7kqrCc68XbBzDkh4xrbgFNYWqaKaIxgdYTRrwqTtTSXRrhC3j
         ywAYCaL0X11vA==
Date:   Fri, 9 Jun 2023 17:41:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lasse Brun <bruners@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: apple: Option to swap only left side mod keys
In-Reply-To: <20230522184013.42621-1-bruners@gmail.com>
Message-ID: <nycvar.YFH.7.76.2306091741170.5716@cbobk.fhfr.pm>
References: <20230522184013.42621-1-bruners@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 22 May 2023, Lasse Brun wrote:

> On the Keychron K8 keyboard, and probably others, the right side keys
> should not be swapped to maintain PC layout.
> 
> Swapping the right side keys moves 'Super' before 'Alt gr' which is not
> intended by the default Keychron layout or the ISO layout.
> 
> Signed-off-by: Lasse Brun <bruners@gmail.com>

Applied, thanks, and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

