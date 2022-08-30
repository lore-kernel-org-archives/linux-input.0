Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B74C0502A
	for <linux-input@archiver.kernel.org>; Tue, 30 Aug 2022 11:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiH3LjN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiH3Lic (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2022 07:38:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EE2C644
        for <linux-input@vger.kernel.org>; Tue, 30 Aug 2022 04:37:16 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 34D8040009;
        Tue, 30 Aug 2022 11:37:13 +0000 (UTC)
Message-ID: <3ddfd0be624f0ec6a56e4a8601c828b4513d2fe7.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Enable HID++ for all the Logitech
 Bluetooth devices
From:   Bastien Nocera <hadess@hadess.net>
To:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Tue, 30 Aug 2022 13:37:12 +0200
In-Reply-To: <4542beb149883ab5dfdcfd7f6bb4b516e5c1bcdb.camel@hadess.net>
References: <4542beb149883ab5dfdcfd7f6bb4b516e5c1bcdb.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2022-08-25 at 14:29 +0200, Bastien Nocera wrote:
> Probe for HID++ support over Bluetooth for all the Logitech Bluetooth
> devices. As Logitech doesn't have a list of Bluetooth devices that
> support HID++ over Bluetooth, probe every device. The HID++ driver
> will fall back to plain HID if the device does not support HID++.
> 
> Note that this change might cause upower to export 2 batteries for
> certain Bluetooth LE devices which export their battery information
> through the Bluetooth BATT profile. This particular bug is tracked
> at:
> https://gitlab.freedesktop.org/upower/upower/-/issues/166
> 
> Tested with a Logitech Signature M650 mouse, over Bluetooth
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> 
> Note that I could not test whether the Harmony PS3 (handled in hid-
> sony.c)
> or DiNovo Edge keyboard (handled in hid-input.c) devices would
> correctly fallback
> to those drivers in that case.

The special case of the DiNovo Edge keyboard and Harmony remote should
be fixed in the v2 version.
