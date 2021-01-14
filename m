Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7576C433DB
	for <linux-input@archiver.kernel.org>; Thu, 14 Jan 2021 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9866F23877
	for <linux-input@archiver.kernel.org>; Thu, 14 Jan 2021 12:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbhANMO0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbhANMO0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Jan 2021 07:14:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40AE423A52;
        Thu, 14 Jan 2021 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610626425;
        bh=PVXJRhvFe7BLmVr2i1SezFPmp12SAhr17IcwNtv9YIM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dXCOnahROWoZhORgJfOYuQOz6NZRv5aEJXuqNZbj/Om91u2AzGNF6DBGq/TrWxjgZ
         gy1jhTriZHhYho4cusjdZxlmcnQWQIUrBWjmb7aLhuw5l92zudrCbigG18am8nDt90
         VefIgpXY7h8g+9oQ+qDyBwNncFSjMeEMItZg1BOvtR2Wje1uGSDKUpUR2oI3G5peSh
         GlFuzFR1zWlO9xHBE0e0Tsrci55TrDYcTziTQMeDnFVRt0RtThquXjbHTNSrweKC3k
         AMYKJQ4pyjkryndzuX2ynqEopT3vxtbX2KsVlkAz3jbdC9bUV+VJ4d9XQIw8zghkK+
         6cLMZFWsS9jSw==
Date:   Thu, 14 Jan 2021 13:13:42 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jian-Hong Pan <jhp@endlessos.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chris Chiu <chiu@endlessos.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH v2] HID: Add Wireless Radio Control feature for Chicony
 devices
In-Reply-To: <20201223055540.204685-1-jhp@endlessos.org>
Message-ID: <nycvar.YFH.7.76.2101141313320.13752@cbobk.fhfr.pm>
References: <CAB4CAwfFQrMDYuzjL2nuUnHgXO031ty-mA7GGxW+-nHFkZTGTg@mail.gmail.com> <20201223055540.204685-1-jhp@endlessos.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 23 Dec 2020, Jian-Hong Pan wrote:

> Some Chicony's keyboards support airplane mode hotkey (Fn+F2) with
> "Wireless Radio Control" feature. For example, the wireless keyboard
> [04f2:1236] shipped with ASUS all-in-one desktop.
> 
> After consulting Chicony for this hotkey, learned the device will send
> with 0x11 as the report ID and 0x1 as the value when the key is pressed
> down.
> 
> This patch maps the event as KEY_RFKILL.
> 
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2: Remove the duplicated key pressed check.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

