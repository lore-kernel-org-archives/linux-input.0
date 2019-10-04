Return-Path: <SRS0=eGih=X5=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F368C4360C
	for <linux-input@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1112084D
	for <linux-input@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="M4s539QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfJDIJS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:09:18 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:51804 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731053AbfJDIJS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Oct 2019 04:09:18 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id F164CA05D3;
        Fri,  4 Oct 2019 10:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1570176557;
        bh=rszklT5AfFggE4WOlv5dnLOTdW5pIVWmTQcYuHaDbw8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M4s539QDrgzbTtln0Of3sHmOcK4SYwaYlRV4rQGuS1bLu2khid6UbB76wGystnC21
         1+/oLmaaGXKu620WjbRLPO+Rg8u2QvxBsceODjFhvVZgwT9L7wwGaYg4PEvrSqMiPT
         uNDEmI2kUUR3jAin5BXApxowlxMjG5sh/BfdNu2o=
Subject: Re: [PATCH] Input: add input_get_poll_interval()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191002215812.GA135681@dtor-ws>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <d52af5bc-aa1c-c186-e686-de63d66a95b7@ysoft.com>
Date:   Fri, 4 Oct 2019 10:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002215812.GA135681@dtor-ws>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191004080916.maobhOIKGSPmIQODOolFA0P37qrSE3vkZX73qNbQLO8@z>

On 02. 10. 19 23:58, Dmitry Torokhov wrote:
> Some drivers need to be able to know the current polling interval for
> devices working in polling mode, let's allow them fetching it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Just tested to use this function from a mpr121_touchkey driver.
Works as expected. When I change the poll interval from sysfs, the new
value is correctly reported.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> ---
>   drivers/input/input-poller.c | 9 +++++++++
>   include/linux/input.h        | 1 +
>   2 files changed, 10 insertions(+)
