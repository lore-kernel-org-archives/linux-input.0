Return-Path: <SRS0=K583=CJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB5C433E2
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA897208A9
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598857142;
	bh=KwTApQ3uEGZx3eGTq7oBhnYtOqsfYCmPlZaAbK9r378=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=XCEGv45+SZ0InnyqTmNMcWH3nNkqU20mZu9oTy8FGdYvbJs2oWViboaCHtPXcokUo
	 69ua4QqHmeujfLrHtS0mC6miUTK8pZdMTpsFFuidjYgbHpQ90MdxITCf+ijpniPW61
	 Jx+WTS3GLN+zKCgzuCatotmXMh+K5YPqb40Oe7/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgHaG7C (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaG7B (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:01 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596E92072D;
        Mon, 31 Aug 2020 06:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598857141;
        bh=KwTApQ3uEGZx3eGTq7oBhnYtOqsfYCmPlZaAbK9r378=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=0dl5OkC6hs6guuYurNojcgIX77NjPfrfw0MaLcqU6s+c08n/hquUsHxJ0xPozpQhK
         GklawgHq8vu7UyIWuA15EkdR5YczHfVYlJV7gFldkZsyfC94drEw1iaokvyo25fN0K
         a1KkhAttNueFqSvy3e+j0Mva/c8rnekrX7mFsc38=
Date:   Mon, 31 Aug 2020 08:58:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nicholas Miell <nmiell@gmail.com>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, pgriffais@valvesoftware.com,
        andrew.smirnov@gmail.com
Subject: Re: [PATCH] HID: microsoft: Add rumble support for the 8bitdo SN30
 Pro+ controller
In-Reply-To: <3289459a-915f-5f39-f1c0-0d2ee3adeebd@gmail.com>
Message-ID: <nycvar.YFH.7.76.2008310858450.27422@cbobk.fhfr.pm>
References: <3289459a-915f-5f39-f1c0-0d2ee3adeebd@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 28 Aug 2020, Nicholas Miell wrote:

> When operating in XInput mode, the 8bitdo SN30 Pro+ requires the same
> quirk as the official Xbox One Bluetooth controllers for rumble to
> function.
> 
> Other controllers like the N30 Pro 2, SF30 Pro, SN30 Pro, etc. probably
> also need this quirk, but I do not have the hardware to test. 

Applied, thank you Nicholas.

-- 
Jiri Kosina
SUSE Labs

