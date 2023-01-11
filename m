Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E67C46467
	for <linux-input@archiver.kernel.org>; Wed, 11 Jan 2023 10:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjAKK3Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Jan 2023 05:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjAKK3D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2023 05:29:03 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F32700;
        Wed, 11 Jan 2023 02:28:56 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8ADDD1BF21B;
        Wed, 11 Jan 2023 10:28:54 +0000 (UTC)
Message-ID: <211974789ce308698ce79a38848036dc498f6d5c.camel@hadess.net>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: Add support for Logitech G923
 wheel Xbox Edition
From:   Bastien Nocera <hadess@hadess.net>
To:     Walt Holman <walt@holmansrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Date:   Wed, 11 Jan 2023 11:28:54 +0100
In-Reply-To: <1912021550.81.1672759744435.JavaMail.zimbra@holmansrus.com>
References: <1912021550.81.1672759744435.JavaMail.zimbra@holmansrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hey Walt,

On Tue, 2023-01-03 at 09:29 -0600, Walt Holman wrote:
> Hello, 
> 
> This patch adds support for the Logitech G923 Xbox edition steering
> wheel. This uses the hid-logitech-hidpp kernel module and from my
> testing, force feedback and all buttons work. This requires the
> usb_modeswitch application to setup the device in PC mode with a
> magic string that is the same as the Logitech 920 wheel. Originally I
> had massaged a patch I found for this wheel, however, much of it was
> unnecessary and I culled it back to just adding the ID's. Let me know
> if you need anything else or have any questions. Thanks, 
> 
> Signed-off-by: Walt Holman walt@holmansrus.com 
> 

You'll want to follow:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
to submit this patch. It definitely shouldn't be an attachment :)

Cheers
