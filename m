Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9BC433E0
	for <linux-input@archiver.kernel.org>; Thu,  7 Jan 2021 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D2A2312E
	for <linux-input@archiver.kernel.org>; Thu,  7 Jan 2021 09:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGJQJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:16:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGJQI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 Jan 2021 04:16:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53B932312E;
        Thu,  7 Jan 2021 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610010928;
        bh=Eh6KUSwoPsCkD9mUQP+H7klASF40gUofPS2/w04o/m4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MCLnRmvGuyYW3xsVWvNEaZxUpZSGhL1gG+sVYrqXHp/l0oGisCcqi46PAArHWUJF/
         RQ6jHRB9nW9Js9kfHBPGi/eIrcfuxg85PXbLhbxR8U0FJvwfcu0EId3If85/bIeWaH
         wv0d+BGCJqLrX6Gj0N/nht7HLKRUaH0o8tS/LA939t+0cw5F2ZraXNGGAgtui6W3KX
         lk4P2F/fjTarEYNZbXJZcOZG7ZH7J96KqJXa7EJqm6z4jfMycOYCGIE90NQmQRAb9V
         bJ+r3e+OTgYo+Wq+EZAl0vtfwnJKKJSBVV6z+Ql5y4YMWDpI5v7ZjNB6gJxlaMvBZD
         UCypKGgCEdMXw==
Date:   Thu, 7 Jan 2021 10:15:25 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tom Rix <trix@redhat.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: remove h from printk format specifier
In-Reply-To: <20201215145454.1905175-1-trix@redhat.com>
Message-ID: <nycvar.YFH.7.76.2101071015160.13752@cbobk.fhfr.pm>
References: <20201215145454.1905175-1-trix@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 15 Dec 2020, trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

