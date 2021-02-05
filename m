Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B80C433E0
	for <linux-input@archiver.kernel.org>; Fri,  5 Feb 2021 09:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE7664FBB
	for <linux-input@archiver.kernel.org>; Fri,  5 Feb 2021 09:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBEJWB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhBEJT5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Feb 2021 04:19:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A5A64F87;
        Fri,  5 Feb 2021 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612516741;
        bh=D6IC+Qjel3VKDlF+oaoeNyDwbJGv7T/gs1hJNC79gqc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OFpDBT2WXqLHpbVVTlzgESWeNEiUL/wwVeC3Izvz8H4b2gSRDnIPJC7LlS+L39WG+
         JBhST82jNruV0Iaxc6LNvJ3rcg5ni46D53ThcLsLCnWtBsLHUfuTijBRQXvr+b5C9y
         d/cx1USBgrIETpg8kyJ0FYDdnWMswofB6w6aT/V4GD1YEf0DtV2d/K5SK41kuMgFTJ
         ZGf2m28opprWxzEHQe+kJGrpL7wGyLNUhb267LwDq2syr15VEGtt2xNTcJu6ibfJxp
         SCpX9xeLdeLunPrtIF9SeeJtRb9g1sMD4IOxmwb5mpkhMf1yXkvsou6eJV+IK4sOmj
         bv1u3wCh9PB4A==
Date:   Fri, 5 Feb 2021 10:18:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>
Subject: Re: [PATCH] HID: logitech-dj: add support for keyboard events in
 eQUAD step 4 Gaming
In-Reply-To: <20210130191027.1225465-1-lains@archlinux.org>
Message-ID: <nycvar.YFH.7.76.2102051018370.28696@cbobk.fhfr.pm>
References: <20210130191027.1225465-1-lains@archlinux.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 30 Jan 2021, Filipe Laíns wrote:

> From: Filipe Laíns <lains@riseup.net>
> 
> In e400071a805d6229223a98899e9da8c6233704a1 I added support for the
> receiver that comes with the G602 device, but unfortunately I screwed up
> during testing and it seems the keyboard events were actually not being
> sent to userspace.
> This resulted in keyboard events being broken in userspace, please
> backport the fix.
> 
> The receiver uses the normal 0x01 Logitech keyboard report descriptor,
> as expected, so it is just a matter of flagging it as supported.
> 
> Reported in
> https://github.com/libratbag/libratbag/issues/1124
> 
> Signed-off-by: Filipe Laíns <lains@riseup.net>

Given this is a regression, could you please add proper Fixes: and Cc: 
stable tags?

Thank you,

-- 
Jiri Kosina
SUSE Labs

