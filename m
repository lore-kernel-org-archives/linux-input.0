Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F41BECAAD5
	for <linux-input@archiver.kernel.org>; Thu,  8 Sep 2022 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIHIbo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Thu, 8 Sep 2022 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIHIbl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2022 04:31:41 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB804E1A8E;
        Thu,  8 Sep 2022 01:31:37 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 54C54200005;
        Thu,  8 Sep 2022 08:31:35 +0000 (UTC)
Message-ID: <7b3641c5dcec258d03b178dfd1cc25b1ce81e880.camel@hadess.net>
Subject: Re: [PATCH] HID: sony: Support for DS4 clones that do not implement
 feature report 0x81
From:   Bastien Nocera <hadess@hadess.net>
To:     Ivan Mironov <mironov.ivan@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 10:31:34 +0200
In-Reply-To: <20210113173402.17030-1-mironov.ivan@gmail.com>
References: <20210113173402.17030-1-mironov.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 2021-01-13 at 22:34 +0500, Ivan Mironov wrote:
> There are clones of DualShock 4 that are very similar to the
> originals,
> except of 1) they do not support HID feature report 0x81 and 2) they
> do
> not have any USB Audio interfaces despite they physically have audio
> jack.

Do you have the brand/catalogue name for the device on which you tested
this? I found a "YCCTEAM" joypad, but it seems that the audio interface
is supposed to work (maybe that's only on wireless?).

Do you think you could also look into a patch for BlueZ's cable pairing
plugin? It uses 0x81 too, even though it does have some fallback code.

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/plugins/sixaxis.c#n111
