Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEBC433EF
	for <linux-input@archiver.kernel.org>; Wed, 15 Sep 2021 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CCA60E90
	for <linux-input@archiver.kernel.org>; Wed, 15 Sep 2021 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhIOOqS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233745AbhIOOqS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Sep 2021 10:46:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7185A60F13;
        Wed, 15 Sep 2021 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631717099;
        bh=gtfqYelVApDfXyM8R6kC0P7Ao8Xz+cwMhcE/ZEPw7fo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Jp21UEgznGOJmkZdd1tle2CHnTGqoayRZyvq4qMBx2e4od8sYSMX5qEc6Ocge7SSN
         Tvn46qCVxGTXuILiJ+e5iuin9wSgLCnbevRhet6meLM/BD3y5EcDC8udAv9pMyyohw
         woz/+Rif1k9fRp5nIcDvgcxvTq7oaM6c9CRYFjLUnu5lhytVQIOhd+arMZruckWnP9
         bW+u/d2IEbRxkMCUcgTz8l/wSdsoJCJCq10A6qTsBovjYnv0mx9zVT/rEYCQjha4ba
         aXw6b7ZGnpnofEwyECDBEyCpUoXQ/4YKSB/9DJBd/DohW9zvSzWhwxUEQQOlQeexac
         L5Bm0aZ/tPxQw==
Date:   Wed, 15 Sep 2021 16:44:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mizuho Mori <morimolymoly@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Fix logical maximum and usage maximum of
 Magic Keyboard JIS
In-Reply-To: <20210729110325.15089-1-morimolymoly@gmail.com>
Message-ID: <nycvar.YFH.7.76.2109151644270.15944@cbobk.fhfr.pm>
References: <20210729110325.15089-1-morimolymoly@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 29 Jul 2021, Mizuho Mori wrote:

> Signed-off-by: Mizuho Mori <morimolymoly@gmail.com>

The signoff is on a funny place here. I have moved it to the end of the 
changelog where it belongs, and applied the patch, thanks.

-- 
Jiri Kosina
SUSE Labs

