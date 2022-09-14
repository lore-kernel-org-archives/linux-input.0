Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835FAECAAD3
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 15:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiINPlp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINPlg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 11:41:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05122BCC;
        Wed, 14 Sep 2022 08:41:34 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id E3CEC4000C;
        Wed, 14 Sep 2022 15:41:31 +0000 (UTC)
Message-ID: <c56c4053388baa5ea3db8bc849c5a420859347f1.camel@hadess.net>
Subject: Re: [PATCH v1] HID: logitech-hidpp: Detect hi-res scrolling support
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Wed, 14 Sep 2022 17:41:31 +0200
In-Reply-To: <20220914132146.6435-1-hadess@hadess.net>
References: <20220914132146.6435-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 2022-09-14 at 15:21 +0200, Bastien Nocera wrote:
> Rather than relying on a never-ending stream of patches for quirks.
> 
> This change will detect whether HID++ 1.0 hi-res scroll, HID++ 2.0
> hi-res scroll or HID++ 2.0 hi-res scroll wheel is supported, and
> enable
> the feature without the need for quirks.
> 
> Tested on a Logitech M705 mouse that was unsupported before this
> change.
> 
> [    9.365324] logitech-hidpp-device 0003:046D:406D.0006:
> input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-
> 0000:00:14.0-4/input2:3
> [   57.472434] logitech-hidpp-device 0003:046D:406D.0006: HID++ 4.5
> device connected.
> [   57.616429] logitech-hidpp-device 0003:046D:406D.0006: Detected
> HID++ 2.0 hi-res scroll wheel
> [   57.712424] logitech-hidpp-device 0003:046D:406D.0006: wheel
> multiplier = 8
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216480
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

For anyone on a recent version of Fedora that wants to test it, those
packages should work:
https://koji.fedoraproject.org/koji/taskinfo?taskID=92008550

Cheers
