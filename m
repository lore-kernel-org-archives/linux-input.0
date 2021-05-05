Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C818C433ED
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80D66139A
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhEEMXt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 May 2021 08:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhEEMXs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 May 2021 08:23:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC1E613B3;
        Wed,  5 May 2021 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620217372;
        bh=CMDcKI5N6OtXILJ8K9LQvTq0sfkb27Ri0D/cC1xcUgk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CefQmh03eq32KjiVNT4BwsfPArwNSuHKX+ClPGGd1AtpvXiqLp0noWxD0x6+wxx3W
         LKuGZgy9SmCcD5TBneppQP+wH7rRKUAwUaYtiLL62y0cgFAZizRZsshGBhq+EwjInj
         T5oGcOdRkyD0kycrnx8yWjd5CsiDu9RLwLdv9+ut70gMMJVMdT5U7ZqXBvGzoeUOvb
         nCCm4Ei2cSkvHt2PY85UUJ7YM7fgvimknpSUcFIqpQNq9IagbbBTG9YWjYoLjhRNbj
         JI0uEC2ClUiV+aIRqjue0KOry6jNRNCdUAgjwWW+Y7w29N8mYTZrSAVM76wO81PpCl
         4asC6ZEtvE8ag==
Date:   Wed, 5 May 2021 14:22:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luke D Jones <luke@ljones.dev>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Filter keyboard EC for old ROG keyboard
In-Reply-To: <20210218213846.22504-1-luke@ljones.dev>
Message-ID: <nycvar.YFH.7.76.2105051422410.28378@cbobk.fhfr.pm>
References: <20210218213846.22504-1-luke@ljones.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 19 Feb 2021, Luke D Jones wrote:

> Older ROG keyboards emit a similar stream of bytes to the new
> N-Key keyboards and require filtering to prevent a lot of
> unmapped key warnings showing. As all the ROG keyboards use
> QUIRK_USE_KBD_BACKLIGHT this is now used to branch to filtering
> in asus_raw_event.
> 
> Signed-off-by: Luke D Jones <luke@ljones.dev>

Applied now, thanks.

-- 
Jiri Kosina
SUSE Labs

