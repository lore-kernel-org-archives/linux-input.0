Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC79EB64DD
	for <linux-input@archiver.kernel.org>; Mon, 14 Aug 2023 09:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjHNJPo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjHNJPW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2023 05:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D004AD;
        Mon, 14 Aug 2023 02:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431D762A8C;
        Mon, 14 Aug 2023 09:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BAC433C8;
        Mon, 14 Aug 2023 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004520;
        bh=UnbYLbdWrIB2cXL2eCtQJBeGyCijgPtAVQK/KlNMhts=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gS8AIES9K3qT9NNb4p6wKdWIU2Y0Esec5F8jQa2fmYa8N/lsFeW4l8xPdk+l2IQkw
         5n9vv7eOndlU1eHq7ZEMDxjn3Q4h4aS93Nku1L+c/zWAxUPyJpv5kXb99D9cnoJEGf
         qXX6j6V0YesiBuSnxhCh5KfuY6t3nTOq6BmzEcGSIeIjnrfZxpKDYTjeZcKuM2od+T
         USVGmHE7V+g2UGw0wP+N1Yq/NDNnmMEeHf88Zp/hRlURl+FkFlZx+Ch28sCVXgPZbI
         u/Ltd25bs1Mfwh1s4WAiE1sFY0FadVz1DsCW2O2/gPbsgcw4CbQq5wm2kakJNeIm8j
         jAfFAI4dod0hQ==
Date:   Mon, 14 Aug 2023 11:15:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Osama Muhammad <osmtendev@gmail.com>
cc:     david.rheinsberg@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hid-wiimote-debug.c: Drop error checking for
 debugfs_create_file
In-Reply-To: <20230530154252.7895-1-osmtendev@gmail.com>
Message-ID: <nycvar.YFH.7.76.2308141115050.14207@cbobk.fhfr.pm>
References: <20230530154252.7895-1-osmtendev@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 30 May 2023, Osama Muhammad wrote:

> This patch removes the error checking for debugfs_create_file
> in hid-wiimote-debug.c.c. This is because the debugfs_create_file()
> does not return NULL but an ERR_PTR after an error.
> The DebugFS kernel API is developed in a way that the
> caller can safely ignore the errors that occur during
> the creation of DebugFS nodes.The debugfs Api handles
> it gracefully. The check is unnecessary.
> 
> Link to the comment above debugfs_create_file:
> https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> 
> ---
> changes since v1
> 	-In v1 the IS_ERR was used for error checking which is dropped now.

Now applied, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

