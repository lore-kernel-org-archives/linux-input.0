Return-Path: <SRS0=0BCR=56=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E47C2BA19
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8631B206E9
	for <linux-input@archiver.kernel.org>; Tue, 14 Apr 2020 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586856205;
	bh=3YOURsaZIsK7yQSnEreTOxZL9wuwg0SgKBo+kH9ebqU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=0N0GhcqrHC8VKUbU7X2mVfzRfrE8iOJAuFCTMSSEM7gQARb8Zb7yU7L/+BZ/IZCXI
	 ZJg/EVvOwl7vvNQrhD0hcYCiC8DEVz1bLjTDPs3ZTyJEMOJPzj3pdEBgScV5fTyJJP
	 bYCU55p1HVCzH6MwAvCaNn7WCErKPKqbkdVv+r+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437599AbgDNJXY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437562AbgDNJXT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Apr 2020 05:23:19 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90FDA206E9;
        Tue, 14 Apr 2020 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586856198;
        bh=3YOURsaZIsK7yQSnEreTOxZL9wuwg0SgKBo+kH9ebqU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GB4bj00xHVgHket69i5reG0GZyRcQqgVL3wYG+x88xcZ7bk45edsSPSWL0ZB9w3Vp
         pR0/jFRjSmz15QYG75sVL4en0xrACba8pCoRW7wAQ8swcP+f6aFj8n4mNelaahRiz0
         ygmSFR9kJar/gGLqUoR3CSVUv0TyPGsheoURGp/s=
Date:   Tue, 14 Apr 2020 11:23:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Artem Borisov <dedsa2002@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaojian Cao <xiaojian.cao@cn.alps.com>,
        Masaki Ota <masaki.ota@alpsalpine.com>
Subject: Re: [PATCH 1/2] HID: alps: Add AUI1657 device ID
In-Reply-To: <20200405235517.18203-1-dedsa2002@gmail.com>
Message-ID: <nycvar.YFH.7.76.2004141122090.19713@cbobk.fhfr.pm>
References: <20200405235517.18203-1-dedsa2002@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 6 Apr 2020, Artem Borisov wrote:

> This device is used on Lenovo V130-15IKB variants and uses
> the same registers as U1.
> 
> Signed-off-by: Artem Borisov <dedsa2002@gmail.com>

I am in the meantime applying this one, and postponing the axis resolution 
logic followup, waiting for Alps people to grok it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

