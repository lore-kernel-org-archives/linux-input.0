Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E066C56202
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA337206F7
	for <linux-input@archiver.kernel.org>; Wed, 25 Nov 2020 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDBaU2DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgKYNEX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 25 Nov 2020 08:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgKYNEX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Nov 2020 08:04:23 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA00B206F7;
        Wed, 25 Nov 2020 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606309462;
        bh=v87+vT1vbzQNQF9sfSdi43D0NAAsysrN49fRtGjXIbM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GDBaU2DO2N8KjcEE1C6v8jYjBeKF18FBn7EJmnl6DZVTXn3xjk0dtPnOEIgLVrLMg
         TmQ/GgDWDqEYxkrGv6bKDq28xP2GB/zcp08TR6UGJUQWWjPuAkYAW+0B52gjgsCwoK
         5GhWMQPg13pGiBHIt2TiycAT6MUPI0Y5uFzBU22w=
Date:   Wed, 25 Nov 2020 14:04:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 063/141] HID: input: Fix fall-through warnings for
 Clang
In-Reply-To: <18a24381b4461ec8174211c78eac549808b15e6f.1605896059.git.gustavoars@kernel.org>
Message-ID: <nycvar.YFH.7.76.2011251403390.3441@cbobk.fhfr.pm>
References: <cover.1605896059.git.gustavoars@kernel.org> <18a24381b4461ec8174211c78eac549808b15e6f.1605896059.git.gustavoars@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 20 Nov 2020, Gustavo A. R. Silva wrote:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a goto statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/hid/hid-input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9770db624bfa..37601b800a2e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -743,6 +743,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  				field->flags |= HID_MAIN_ITEM_RELATIVE;
>  				break;
>  			}
> +			goto unknown;
>  
>  		default: goto unknown;

This makes my eyes hurt :) But adding the annotation would be ugly as 
well, so let me just take it as-is.

Thanks,

-- 
Jiri Kosina
SUSE Labs

