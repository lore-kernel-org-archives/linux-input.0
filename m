Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFC25B08
	for <linux-input@archiver.kernel.org>; Wed, 17 Aug 2022 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiHQKhI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiHQKhG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Aug 2022 06:37:06 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED7352450;
        Wed, 17 Aug 2022 03:37:04 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 36B3A200003;
        Wed, 17 Aug 2022 10:37:02 +0000 (UTC)
Message-ID: <c7c1373b84a297d2745c4fb98ad2ecf26e67f0d5.camel@hadess.net>
Subject: Re: [PATCH v3 1/3] Input: joystick: xpad: Add X-Box Adaptive
 Controller support
From:   Bastien Nocera <hadess@hadess.net>
To:     Nate Yocom <nate@yocom.org>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 12:37:02 +0200
In-Reply-To: <20220813185343.2306-2-nate@yocom.org>
References: <20220813185343.2306-1-nate@yocom.org>
         <20220813185343.2306-2-nate@yocom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 2022-08-13 at 11:53 -0700, Nate Yocom wrote:
> Adds correct VID/PID for this XTYPE_XBOXONE compatible controller to
> xpad_device[] table.
> 
> Signed-off-by: Nate Yocom <nate@yocom.org>

Have you tested the device in Bluetooth mode? My controller's battery
is still charging.

Tested-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/xpad.c
> b/drivers/input/joystick/xpad.c
> index 18190b529bca..c8b38bb73d34 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -131,6 +131,7 @@ static const struct xpad_device {
>         { 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0,
> XTYPE_XBOXONE },
>         { 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0,
> XTYPE_XBOXONE },
>         { 0x045e, 0x0719, "Xbox 360 Wireless Receiver",
> MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> +       { 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", 0,
> XTYPE_XBOXONE },
>         { 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller",
> MAP_SELECT_BUTTON, XTYPE_XBOXONE },
>         { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360
> },
>         { 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360
> },

