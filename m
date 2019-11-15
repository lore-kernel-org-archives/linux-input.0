Return-Path: <SRS0=EPtW=ZH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4AC432C3
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A02073A
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573831685;
	bh=Fcx7CiRtmf7mi9xH0z47kfW9NQ2f4gcl82z8/TEdRRA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=JR46V+Zg6NS27keuvEx1MFgA3k3UEnjaFZAydG1sbNdePzo2zVZ+nkSyRL7cBLz1k
	 2y9TLhPCDHPrHzjvp5HcVwOIojTrP/t4jw42Xy0O2+qcVn6QnbMREqDI/STDpDMThD
	 I4LXhn7IwYi3lzzNfjQ9QZOgg41cKP5rWlRDTtT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKOP2E (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfKOP2E (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Nov 2019 10:28:04 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A22120732;
        Fri, 15 Nov 2019 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573831684;
        bh=Fcx7CiRtmf7mi9xH0z47kfW9NQ2f4gcl82z8/TEdRRA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=x9u/T0L7RNIOcaNsZ5TXHiD38wmCujqh3zcxYDle+016JpBBiApi8Gg19CAz7Xo9y
         PQv9It9EpFO9Y8/f5pKX/SxUycP53Dc4MlOfZVsuzSfFp+oyNagV1l/yxU79osJ9Pn
         GD8Ms5pysy/nZVygWHYB3z6mZCD9Aq06jiB1oMv8=
Date:   Fri, 15 Nov 2019 16:28:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Reset ALPS touchpads on resume
In-Reply-To: <20191107142811.5833-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1911151627520.1799@cbobk.fhfr.pm>
References: <20191107142811.5833-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 7 Nov 2019, Kai-Heng Feng wrote:

> Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system
> resume") fixes many touchpads and touchscreens, however ALPS touchpads
> start to trigger IRQ storm after system resume.
> 
> Since it's total silence from ALPS, let's bring the old behavior back
> to ALPS touchpads.
> 
> Fixes: 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

