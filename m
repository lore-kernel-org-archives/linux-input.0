Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD3FEB64DD
	for <linux-input@archiver.kernel.org>; Mon, 14 Aug 2023 09:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjHNJXU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHNJWx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2023 05:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9C195;
        Mon, 14 Aug 2023 02:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFF562A49;
        Mon, 14 Aug 2023 09:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2874C433C8;
        Mon, 14 Aug 2023 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004971;
        bh=I5eP7QwPtvi99/Ipxhh+MqvAiTYxlbBxBx8v4jcURgA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=upsMdRwvRgnNp7ubJI2arCWg6mKA1Jna0DV1ud11gydjbSNhjDKou/OVliA5W2MS/
         hNc9ewTPIWOnCMoyQT8nb/lqqyTqFanjuUL/1S67n/GtbegEwyvDtdp1i1vuFMV3pi
         YuLRWhtF8RMnvlbgMZwLZQOJwPTZFIQixbR2kEFPW3QMwJkF3riN/eRAM5X/MEOAz6
         dwS8C4S0Rk9A/0YNJQhOLMXue1HvqYH+nYPfRGgrwlLJa+st3SGFGrnLwwdJ3wbK41
         Vw5wDz7ZTzELXiB7NfKFNsTe+owZkxuoGoW9XYtK/ORMv5qTjOZm1gHziUmYnlyo1N
         +IDRFwaUCYweQ==
Date:   Mon, 14 Aug 2023 11:22:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Rename HID++ "internal" error
 constant
In-Reply-To: <20230620085014.542370-1-hadess@hadess.net>
Message-ID: <nycvar.YFH.7.76.2308141122410.14207@cbobk.fhfr.pm>
References: <20230620085014.542370-1-hadess@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 20 Jun 2023, Bastien Nocera wrote:

> As per the upstream "hidpp" helpers commit:
> "
> There has been some confusion about error value 5 but feature specs that
> refer to it generally use NOT_ALLOWED.
> "

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

