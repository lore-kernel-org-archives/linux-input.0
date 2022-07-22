Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B3C43334
	for <linux-input@archiver.kernel.org>; Fri, 22 Jul 2022 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiGVNGO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiGVNGD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Jul 2022 09:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA085D7A;
        Fri, 22 Jul 2022 06:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C290361F32;
        Fri, 22 Jul 2022 13:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8123C341C6;
        Fri, 22 Jul 2022 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658495148;
        bh=PH0xzQni9tDvj6pIqW1KMJth68cyioHou2hc3CVbZ9c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UO2SYe+sU0lVIMfH0AHJu0XG8RczjAoZetnjTF6s8BKxm2pu/HwJjiOlRznQU42/m
         vD1uN1GIZjanFKbJObNEDrsrnmdoJtZk1hNEDq4M1Y2a6AXTb06t/JizLkpHtHNMvP
         h9zQvj/94tinaSHPGGGVqwaXeaRXJaMoYaqcZ+DTvxIF6UsNnZNEeQCIlbdf9Aoh9w
         NIrODysj1MGrdO52BPgtn/icL9MdiX0EeDVlIx8KrPDhpuJj/f3z7mcjcLFIg9blL5
         ZwD3OZNERhIdXYQFEndz9QJ4Jmg6EU47Yk5fSox7LDZ3ckDXiSdxyaEceKjsxU9n7M
         MtL5ug3xR2Q3Q==
Date:   Fri, 22 Jul 2022 15:05:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hilton Chain <hako@ultrarare.space>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add "GANSS" to the non-Apple list
In-Reply-To: <y76wnc6o6w9.wl-hako@ultrarare.space>
Message-ID: <nycvar.YFH.7.76.2207221505380.19850@cbobk.fhfr.pm>
References: <y76wnc6o6w9.wl-hako@ultrarare.space>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 21 Jul 2022, Hilton Chain wrote:

> While using the name "SONiX USB DEVICE" for wired mode, my GANSS keyboard
> uses "GANSS" for bluetooth mode as well, so adding this to the list.
> 
> Signed-off-by: Hilton Chain <hako@ultrarare.space>
> ---
>  drivers/hid/hid-apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 7fbde58e1219..6970797cdc56 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -320,7 +320,8 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
>  static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
>  	{ "SONiX USB DEVICE" },
>  	{ "Keychron" },
> -	{ "AONE" }
> +	{ "AONE" },
> +	{ "GANSS" }
>  };
>  
>  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

