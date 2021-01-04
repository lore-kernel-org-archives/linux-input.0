Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98619C433E6
	for <linux-input@archiver.kernel.org>; Mon,  4 Jan 2021 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D60D221E5
	for <linux-input@archiver.kernel.org>; Mon,  4 Jan 2021 12:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhADMFb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:05:31 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51663 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADMFb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2021 07:05:31 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 68FAD60007;
        Mon,  4 Jan 2021 12:04:47 +0000 (UTC)
Message-ID: <c7b47af9cc3bd1d38b6c3582f6e63d7876365ee9.camel@hadess.net>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add swap-x-y quirk for
 Goodix touchscreen on Estar Beauty HD tablet
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-input@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 04 Jan 2021 13:04:47 +0100
In-Reply-To: <99d3da8d-3319-3904-25d1-a9ff34be653f@redhat.com>
References: <20201224135158.10976-1-hdegoede@redhat.com>
         <99d3da8d-3319-3904-25d1-a9ff34be653f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 2021-01-04 at 13:00 +0100, Hans de Goede wrote:
> <
> <snip>
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
>  
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.

Do you plan on sending a patch to migrate the other quirks in goodix.c
itself to touchscreen_dmi.c?

(also, feels a bit weird that your robot replies to yourself like it
was a different person ;)

