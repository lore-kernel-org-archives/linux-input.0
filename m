From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: logitech HID driver is not probing
Date: Sat, 13 Feb 2016 22:46:04 +0200
Message-ID: <CANOLnONnWtvp73DMZ2Uy=nNv3u+fXfxme=FugjJ9m=KcBYm0ZA@mail.gmail.com>
References: <CANOLnOMFQpULSw5Wt=v200peGSCoLNbVpVG5eYW-w6amxBL_pQ@mail.gmail.com>
	<af1aa3beec094c30d4670eda62bcf2c3.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35202 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcBMUqF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Feb 2016 15:46:05 -0500
Received: by mail-yk0-f177.google.com with SMTP id r207so47258764ykd.2
        for <linux-input@vger.kernel.org>; Sat, 13 Feb 2016 12:46:04 -0800 (PST)
In-Reply-To: <af1aa3beec094c30d4670eda62bcf2c3.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

On Sat, Feb 13, 2016 at 9:30 PM, Simon Wood <simon@mungewell.org> wrote=
:
=2E..
> static const struct hid_device_id hid_have_special_driver[] =3D {
> ...
> --
>
> Perhaps that's something to do with confusion. Do you have the abilit=
y to
> add and rebuild kernel to test?

Yup, that helped, patch sent, thanks.

Gra=C5=BEvydas

>
> Simon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
