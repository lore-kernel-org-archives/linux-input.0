Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D0C48BE6
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0379D600D3
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFNIu3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:50:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52805 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNIu3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Jun 2021 04:50:29 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0237D40003;
        Mon, 14 Jun 2021 08:48:24 +0000 (UTC)
Message-ID: <be664f7551029705030188f446799e1ff9ad9e03.camel@hadess.net>
Subject: Re: [PATCH 1/3] Input: touchscreen - Extend
 touchscreen_parse_properties() to allow overriding settings with a module
 option
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org
Date:   Mon, 14 Jun 2021 10:48:24 +0200
In-Reply-To: <20210613102158.16886-2-hdegoede@redhat.com>
References: <20210613102158.16886-1-hdegoede@redhat.com>
         <20210613102158.16886-2-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 2021-06-13 at 12:21 +0200, Hans de Goede wrote:
> On x86/ACPI platforms touchscreens mostly just work without needing
> any
> device/model specific configuration. But in some cases (mostly with
> Silead
> and Goodix touchscreens) it is still necessary to manually specify
> various
> touchscreen-properties on a per model basis.
> 
> This is handled by drivers/platform/x86/touchscreen_dmi.c which
> contains
> a large list of per-model touchscreen properties which it attaches to
> the
> (i2c)device before the touchscreen driver's probe() method gets
> called.
> This means that ATM changing these settings requires recompiling the
> kernel. This makes figuring out what settings/properties a specific
> touchscreen needs very hard for normal users to do.
> 
> Add a new, optional, settings_override string argument to
> touchscreen_parse_properties(), which takes a list of ; separated
> property-name=value pairs, e.g. :
> "touchscreen-size-x=1665;touchscreen-size-y=1140;touchscreen-swapped-
> x-y".
> 
> This new argument can be used by drivers to implement a module option
> which
> allows users to easily specify alternative settings for testing.
> 
> The 2 new touchscreen_property_read_u32() and
> touchscreen_property_read_bool() helpers are also exported so that
> drivers can use these to add settings-override support to the code
> for driver-specific properties.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note instead of patching all touchscreen drivers we could also rename
> touchscreen_parse_properties() to
> touchscreen_parse_properties_with_override()
> and add a static inline wrapper which passes NULL. Just patching the
> drivers
> feels a bit cleaner to me though.

It would be easier to do that in a separate commit, or separate
commits, keeping just the new parsing code separate, even if you remove
the _with_override() variant the next commit.

I haven't reviewed the argument parsing code, but eep. If this were
user-space code, we'd have exported it and tried to feed it all kind of
garbage to see whether it parsed things properly, even if it's only run
on the author's machine. Can't say that I like it.

Cheers

