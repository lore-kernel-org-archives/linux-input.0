Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA4C2D0E4
	for <linux-input@archiver.kernel.org>; Tue, 24 Nov 2020 14:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41CA20715
	for <linux-input@archiver.kernel.org>; Tue, 24 Nov 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUoxlPZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbgKXOo0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389228AbgKXOo0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Nov 2020 09:44:26 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2524320715;
        Tue, 24 Nov 2020 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606229065;
        bh=3w6LzCIjZTrsMv4QT2GrmnT7TWBf+K+9Il8t+N4U4Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUoxlPZD9ZF6eJHiKoDce4rJxHrKZGSVRhwI6b/3ytLPgL54wCjS8xiWACe3P7XG5
         hjIovXZ3Ryg8H7Nly7BXJryY5axCqsw3uJnTo8bqRfj0lLaUCP8OwlMccJ91cYiz8c
         i8QmJHYkNzggcGz0zGUye+4j2TwdJXbsdLhXIi+Q=
Date:   Tue, 24 Nov 2020 08:44:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 141/141] Input: libps2 - Fix fall-through warnings for
 Clang
Message-ID: <20201124144441.GJ16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <d2944854e3e118b837755abf4cbdb497662001b7.1605896060.git.gustavoars@kernel.org>
 <20201123061605.GX2034289@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123061605.GX2034289@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, Nov 22, 2020 at 10:16:05PM -0800, Dmitry Torokhov wrote:
> On Fri, Nov 20, 2020 at 12:41:12PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> > warning by replacing a /* Fall through */ comment with the new
> > pseudo-keyword macro fallthrough.
> > 
> > Notice that Clang doesn't recognize /* Fall through */ comments as
> > implicit fall-through markings.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thank you.

Thank you, Dmitry.
--
Gustavo
