Return-Path: <SRS0=IZ7M=YU=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C816CA9EAF
	for <linux-input@archiver.kernel.org>; Sun, 27 Oct 2019 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A34920873
	for <linux-input@archiver.kernel.org>; Sun, 27 Oct 2019 17:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="woSdUwsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfJ0Rvw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 27 Oct 2019 13:51:52 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:55867 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfJ0Rvv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Oct 2019 13:51:51 -0400
Date:   Sun, 27 Oct 2019 17:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1572198709;
        bh=G/3oKNxyqbLXtqaP/AroMNutpIgmqogHjijhEZ0UCts=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=woSdUwsAJHS7YHZBkEDQo76+QTYISyvExhm9h+FiWwAgowPRwXhQuDdeSz8axwXW0
         arAlgor22BzH7y9KLyQYj6TPjTIT5fsxuMWDMiJZxKKwV94WLbHMi8HDLKBlio0loC
         PkZLnm7OIc33wffw/xd80VUKff+sZKmNwZZ7ENAY=
To:     Adrian Freund <adrian@freund.io>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "mnrzk@protonmail.com" <mnrzk@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH v3] HID: logitech: Add MX Master 3 Mouse
Message-ID: <De3ZOlDrC8MZTFGbvc8QlYmWDm7P6Lm69IYASbTfvHaX6FbLYT6ZTznFRNZVvKiBD1lGbp5Om90U_EPPRP6IafvJ19ebBm-RWx69MRZYy4E=@protonmail.com>
In-Reply-To: <20191025205928.87295-1-adrian@freund.io>
References: <20191025205928.87295-1-adrian@freund.io>
Feedback-ID: 18B_FC5q-t32TXzMsVp9BgkgrdNH3iwklfW8WOrHrcxZA0WRj7JodCh5VXKxs6A3OaiHK0QNd8wi3SImKex8yQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Friday, October 25, 2019 4:59 PM, Adrian Freund <adrian@freund.io> wrote=
:

> This patch adds support for the Logitech MX Master 3 Mouse using the
> Logitech Unifying Receiver and Bluetooth LE.
>
> Signed-off-by: Adrian Freund adrian@freund.io
>
> v3:
>
> -   rebased on top of https://patchwork.kernel.org/project/linux-input/li=
st/?series=3D190445

I have updated this series over here:
https://patchwork.kernel.org/project/linux-input/list/?series=3D194201

However, the update only squashed two commits within the series so nothing
needs to be done here.

Thanks,
Mazin

> -   Added bluetooth id
>
>     v2:
>
> -   added Signed-off-by line
>
> drivers/hid/hid-logitech-hidpp.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 23baf9b09c48..74f2517d88d5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3793,6 +3793,8 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
> { LDJ_DEVICE(0x4071), .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> { /* Mouse Logitech MX Master 2S */
> LDJ_DEVICE(0x4069), .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>
> -   { /* Mouse Logitech MX Master 3 */
> -       LDJ_DEVICE(0x4082), .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2=
121 },
>
>
>     { /* Mouse Logitech Performance MX/
>     LDJ_DEVICE(0x101a), .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
>     { / Keyboard logitech K400 */@@ -3854,6 +3856,9 @@ static const struc=
t hid_device_id hidpp_devices[] =3D {
>     .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
>     .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>
> -   { /* MX Master 3 mouse over Bluetooth */
> -       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023),
>
>
> -       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>
>
>     {}
>     };
>
>     --
>     2.23.0
>


