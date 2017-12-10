From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH] Input: Add support for PDP Xbox One controllers
Date: Sun, 10 Dec 2017 14:30:38 -0800
Message-ID: <59aac433-ac3e-c542-0560-49ec8afe6f31@gmail.com>
References: <1a12e3c57f22f67a63d26f45fd4d997f@furneaux.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38787 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdLJWak (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 10 Dec 2017 17:30:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id f12so9594087pgo.5
        for <linux-input@vger.kernel.org>; Sun, 10 Dec 2017 14:30:40 -0800 (PST)
In-Reply-To: <1a12e3c57f22f67a63d26f45fd4d997f@furneaux.ca>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Furneaux <mark@furneaux.ca>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

On 12/09/2017 02:26 PM, Mark Furneaux wrote:
> [PATCH] Input: Add support for PDP Xbox One controllers
> 
> Adds support for the current lineup of Xbox One controllers from PDP
> (Performance Designed Products). These controllers are very picky with
> their initialisation sequence and require an additional 2 packets before
> they send any input reports.
> 
> Signed-off-by: mark@furneaux.ca

I believe 'Signed-off-by: Full Name <email@address>' is generally preferred.

> 
> ---
>  drivers/input/joystick/xpad.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d86e595..5e76be2 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -229,6 +229,7 @@ static const struct xpad_device {
>      { 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
>      { 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
>      { 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
> +    { 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
>      { 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
>      { 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
>      { 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
> @@ -476,6 +477,22 @@ static const u8 xboxone_hori_init[] = {
>  };
> 
>  /*
> + * This packet is required for some of the PDP pads to start
> + * sending input reports. One of those pads is (0x0e6f:0x02ab).
> + */
> +static const u8 xboxone_pdp_init1[] = {
> +    0x0a, 0x20, 0x04, 0x03, 0x00, 0x01, 0x14
> +};

Byte 2 is going to be replaced by the real sequence number at send-time,
so I've been leaving it as 0x00 in these arrays.

These should also be indented with tabs, not spaces.

> +
> +/*
> + * This packet is required for some of the PDP pads to start
> + * sending input reports. One of those pads is (0x0e6f:0x02ab).
> + */
> +static const u8 xboxone_pdp_init2[] = {
> +    0x06, 0x20, 0x01, 0x02, 0x01, 0x00
> +};
> +

I believe both of these init packets are actually sent to all Xbox One
gamepads with the Microsoft driver. We went the conservative route of
only sending the one required to make most gamepads work, but maybe it's
time to revisit that approach to try to mimic the official driver more
closely, rather than maintain an ever-growing quirk list.

Either way, not really relevant for this patch, just something I've been
thinking about.

> +/*
>   * A specific rumble packet is required for some PowerA pads to start
>   * sending input reports. One of those pads is (0x24c6:0x543a).
>   */
> @@ -504,7 +521,10 @@ static const u8 xboxone_rumbleend_init[] = {
>  static const struct xboxone_init_packet xboxone_init_packets[] = {
>      XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
>      XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
> +    XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_fw2015_init),

This line shouldn't be necessary, since the below entry already sends this
to all gamepads.

>      XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
> +    XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
> +    XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
>      XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
>      XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
>      XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
> -- 

Also your mail client may be screwing with your patch, since it looks very
weird on Patchwork - https://patchwork.kernel.org/patch/10103825/

Nice work for discovering another quirky gamepad.

Cameron

