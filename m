Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780DC636CE
	for <linux-input@archiver.kernel.org>; Thu, 15 Jul 2021 19:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C32E613FE
	for <linux-input@archiver.kernel.org>; Thu, 15 Jul 2021 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhGOTFI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243406AbhGOTEX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jul 2021 15:04:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67631613E4;
        Thu, 15 Jul 2021 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626375613;
        bh=IAYwZ7lqmKqo7kwpIZd8jEH+0WAdp3nVSxSEqOQ0baQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LSm0sjuw1A8vhZ1M6QIkIoJkDvnP9lnHihSOK5o0MOrXNP/Q0FkbfUovCeTmPWMuj
         6fzDBglna2V2IRC8N7xP9syjWl7KE6Pe09Fr1IsqsH3ODpn0aRlr0jKNInCU2WhHHw
         abUOR1Y+tttobwbbEa/aF9hZmVmQRWb0vQVpHLMOEhMoL/5PLA1yTyzIrE5HjDdYkk
         95RAV2HyR0J2gGluTk4qXuf/U+x67H5Ll5jrTRE3wFQ93BTfP2C0zqW9fARx7ouJep
         UaOSaKs8dwx59w3oWvXX+DgQ0F6V6KCVj8/OH5ioZGb9dsfSXy73QV5Kaz4+v+Odgv
         eCZWmsdEkPHvA==
Date:   Thu, 15 Jul 2021 21:00:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [PATCH] HID: add cmedia-fixup driver
In-Reply-To: <20210704104906.78490-1-linux@weissschuh.net>
Message-ID: <nycvar.YFH.7.76.2107152059330.8253@cbobk.fhfr.pm>
References: <20210704104906.78490-1-linux@weissschuh.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 4 Jul 2021, Thomas Weißschuh wrote:

> This driver provides HID fixups for CMedia audio chips.
> For now this enables the recognition of the microphone mute button for the
> HS-100B.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/hid/Kconfig            |  6 +++
>  drivers/hid/Makefile           |  1 +
>  drivers/hid/hid-cmedia-fixup.c | 82 ++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h          |  1 +
>  drivers/hid/hid-quirks.c       |  3 ++
>  5 files changed, 93 insertions(+)
>  create mode 100644 drivers/hid/hid-cmedia-fixup.c

Can you please drop the '-fixup' from the driver name? We have quite a 
couple of drivers that do report descriptor modifications, but we're not 
using this '-fixup' naming scheme for them either.

Thanks,

-- 
Jiri Kosina
SUSE Labs

