Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C9C4338F
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E36A60E90
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhHTNHJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 20 Aug 2021 09:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238220AbhHTNHJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Aug 2021 09:07:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB11E60E9B;
        Fri, 20 Aug 2021 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629464791;
        bh=J0ivGgw0LmBfQHw7UnP596zZOR3kqfR37bSrijGs+nE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=peMZbWuwQnAjdqqr+bPxdG/vf5xfl3qv5DXrXSAoOqmACn3Ai5/EJ6ZEXXGXmRiXj
         Sv44JHqU7TydlO3yPyVE6DmMzblcTgBtXiFQ1jU2/HBJy6uCzzx5n9kh1jpnhvABVG
         1mPkxCJpmICDi0UxsQd157S3AVdoCOdoEQanulPxHy13tCMZ4aQhXga8kTXQcROLI9
         rbrMaEJq7tpVid+DYEpqq6VQHArOZeU368UkmlhfMXQ2pWFLJC5suUAV7RwvydRKWh
         z3jKlqWA8lWmx8vHIIRhJMyMaZcPWVa2jUEuU9z1CUcweylr7lGQ9ZTna+zKB2+vSr
         NDCo/Cn4q4ujQ==
Date:   Fri, 20 Aug 2021 15:06:29 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephan Losa <stephan.losa@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add support for Keychron K8, K2 in bluetooth
 mode
In-Reply-To: <20210819193221.558454-1-stephan.losa@gmail.com>
Message-ID: <nycvar.YFH.7.76.2108201506010.15313@cbobk.fhfr.pm>
References: <20210819193221.558454-1-stephan.losa@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 19 Aug 2021, Stephan Losa wrote:

> Use hid-apple in bluetooth mode like in wired mode for Keychron K8, K2
> (and others). Those keyboards use vendor/product ids 05AC:024F (APPLE_ALU_REVB_ANSI).
> 
> Signed-off-by: Stephan Losa <stephan.losa@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

