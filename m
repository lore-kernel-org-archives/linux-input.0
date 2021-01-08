Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD0C433E0
	for <linux-input@archiver.kernel.org>; Fri,  8 Jan 2021 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F8223998
	for <linux-input@archiver.kernel.org>; Fri,  8 Jan 2021 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAHOxD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbhAHOxD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Jan 2021 09:53:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22F002388B;
        Fri,  8 Jan 2021 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610117543;
        bh=QU3ipsXVNL0XD6gyhmMxngyUJUMmitfozxeL0wc1EBI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=abUFfWvpo2sHghnuAHbbYCt8PwOYIXw11Ewa+CxYeNtKgujj4SZ6NSjYqzbhAVM/R
         DKxF0grSCQRYVtVJs42guQnRlwlnyghO8LqOdKZt8rCRFFtTobqJV2gEV2vzpFHvyt
         6IWIybFefzoGAHk8uW3djzvm1ZZIPQTC3YgazZedYrTxZJhnopyYlj65T3H8GoMcZh
         yB4s2lORzPSMmaoB6M8Au8vesEqidixRngUCdbW/eoszJBXVI30K73y6N6Wh1KcrTd
         X1rs4duWqkYWnofgxkXJv4qrhElNrI+MixGRb4rfhWWbSdcm4l6B+CY3T+uz/I2kVR
         CaqtbQ70s/rzA==
Date:   Fri, 8 Jan 2021 15:52:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: add the G602 receiver
In-Reply-To: <20210104204717.2229315-1-lains@archlinux.org>
Message-ID: <nycvar.YFH.7.76.2101081552040.13752@cbobk.fhfr.pm>
References: <20210104204717.2229315-1-lains@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 4 Jan 2021, Filipe Laíns wrote:

> Tested. The device gets correctly exported to userspace and I can see
> mouse and keyboard events.
> 
> Signed-off-by: Filipe Laíns <lains@archlinux.org>

Applied to hid.git#for-5.11/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

