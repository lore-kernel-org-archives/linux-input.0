Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4681AEB64DD
	for <linux-input@archiver.kernel.org>; Sun, 25 Jun 2023 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFYQWN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 25 Jun 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjFYQWL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Jun 2023 12:22:11 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA757193
        for <linux-input@vger.kernel.org>; Sun, 25 Jun 2023 09:22:07 -0700 (PDT)
Date:   Sun, 25 Jun 2023 16:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687710124; x=1687969324;
        bh=AcdBB/40IASGAGeiCoIqo5lG2vgePb4cmrJ/82hiIjY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=c9aiLbdpP+CXcnt2+ir02JE/eBFFD1DiXxl1y1MzMH8eSt8w+MR+IVCX4EAqpEMxa
         9c6EjO9dFHo0w/1Ljah6TCabCIXsAEWH3fa1PVPwTxOg7UD43Xbp9f0+icSysjUcHC
         9qul9jBqr4m+O+jnEYQVvviOz/rvpiSdG1aSVfRBlirBzVYWO7ZfhBvnTcDsWYul+F
         YyvYuft9x6Tq+p64ppu+7bSt9GMxj9E8jJeRxW6NYsl60c4MgbZ0CXBkL7NFBQEv6l
         yYUp4HD8h5cJOf+qCSWKWpI0bXu46Ob/AzxXHbT4STksiDxZcLynW8iFdSE7wwbfUe
         XC34Hhsx9VccA==
To:     jikos@kernel.org
From:   Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        lains@riseup.net,
        Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
Subject: [RESEND PATCH 2/2] HID: logitech-hidpp: Add support for the Pro X Superlight
Message-ID: <20230625162131.17921-2-mavchatz@protonmail.com>
In-Reply-To: <20230625162131.17921-1-mavchatz@protonmail.com>
References: <20230625162131.17921-1-mavchatz@protonmail.com>
Feedback-ID: 20039310:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patch adds support for the Pro X Superlight. Tested over USB.

Co-developed-by: Filipe La=C3=ADns <lains@riseup.net>
Signed-off-by: Filipe La=C3=ADns <lains@riseup.net>
Signed-off-by: Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 5e1a412fd28f..a718535fb87d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4616,6 +4616,8 @@ static const struct hid_device_id hidpp_devices[] =3D=
 {
 =09=09.driver_data =3D HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_R=
EPORTS },
 =09{ /* Logitech G Pro Gaming Mouse over USB */
 =09  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
+=09{ /* Logitech G Pro X Superlight Gaming Mouse over USB */
+=09  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC094) },

 =09{ /* G935 Gaming Headset */
 =09  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0a87),
--
2.34.1


