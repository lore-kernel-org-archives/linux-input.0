Return-Path: <SRS0=chxs=DA=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11850C2D0A8
	for <linux-input@archiver.kernel.org>; Wed, 23 Sep 2020 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF52235FD
	for <linux-input@archiver.kernel.org>; Wed, 23 Sep 2020 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600859484;
	bh=hkQAUNzoIZDlIOnSqsIjT4FANxzRdAr5tRKOTda18yA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=vRzxx6bikVR6esIa+9nohxnykjmbVKMhfZEF9U6BT9wF9SE+NCeiSbm02DbpuX5u0
	 XqsLve1zm6cwqQW68pe4FuqeFc8UzDKuPEFXr3UzicFvngpLEhj47xvMzExl/bLx2X
	 xeXCKGMizTyL2s21JEBTDcoq4CCTRyb7AtKd6aTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgIWLLY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWLLX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Sep 2020 07:11:23 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DDD2145D;
        Wed, 23 Sep 2020 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600859483;
        bh=hkQAUNzoIZDlIOnSqsIjT4FANxzRdAr5tRKOTda18yA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SlZuamR/U7BgydtmHUtuaSPvgzv+Od8Q6GLABJnNb6z3l7R3XiZ4E0+/wm3IO2NCc
         XEOBK0eIVR123zmzN3Rn4Wv4iOsPD8gS9bcyatjpxmo28bdwu8NOM1ND3aBIQ+EJCc
         U5+5H1vU1LxZ+b4kn6p70XXEL86k4/dDJqKwcPM8=
Date:   Wed, 23 Sep 2020 13:11:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] HID: core: fix some doc warnings in hid-core.c
In-Reply-To: <1600776012-7663-1-git-send-email-tanxiaofei@huawei.com>
Message-ID: <nycvar.YFH.7.76.2009231311110.3336@cbobk.fhfr.pm>
References: <1600776012-7663-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 22 Sep 2020, Xiaofei Tan wrote:

> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> drivers/hid/hid-core.c:931: warning: Function parameter or member 'hid' not described in 'hid_parse_report'
> drivers/hid/hid-core.c:931: warning: Excess function parameter 'device' description in 'hid_parse_report'
> drivers/hid/hid-core.c:961: warning: Function parameter or member 'hid' not described in 'hid_validate_values'
> drivers/hid/hid-core.c:961: warning: Excess function parameter 'device' description in 'hid_validate_values'
> drivers/hid/hid-core.c:1452: warning: Function parameter or member 'report' not described in 'hid_match_report'
> drivers/hid/hid-core.c:1452: warning: Excess function parameter 'report_type' description in 'hid_match_report'
> drivers/hid/hid-core.c:2132: warning: Function parameter or member 'drv' not described in 'new_id_store'
> drivers/hid/hid-core.c:2132: warning: Excess function parameter 'driver' description in 'new_id_store'
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

