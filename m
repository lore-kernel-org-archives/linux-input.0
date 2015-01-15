From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] Input: ALPS - mix trackstick and external PS/2 mouse
 data
Date: Thu, 15 Jan 2015 13:00:30 -0800
Message-ID: <20150115210030.GB19367@dtor-ws>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
 <1421276154-8689-7-git-send-email-dmitry.torokhov@gmail.com>
 <201501152134.51503@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40935 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbAOVAe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 16:00:34 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so17299916iec.2
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 13:00:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201501152134.51503@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

On Thu, Jan 15, 2015 at 09:34:51PM +0100, Pali Roh=E1r wrote:
> On Wednesday 14 January 2015 23:55:54 Dmitry Torokhov wrote:
> > From: Pali Roh=E1r <pali.rohar@gmail.com>
> >=20
> > Previously dev2 device was used for both external PS/2 mouse
> > and internal trackstick device (if available). This change
> > introduces dev3 device which is used for external PS/2 mouse
> > data and dev2 is now used only for trackstick.
> >=20
> > In case that trackstick is not present dev2 is not created, so
> > userspace does not see non existent device in system.
> >=20
> > Because laptops with ALPS devices often do not use i8042
> > active multiplexing all data (from touchpad, trackstick and
> > external PS/2 mouse) come to one port.  So it is not possible
> > to know if external PS/2 mouse is connected or not. In most
> > cases external PS/2 mouse is not connected so driver will
> > create dev3 input device after first bare PS/2 packet will be
> > received. So there will not be "ghost" input device.
> >=20
> > This change also helps in identifying possible problems in
> > future if driver decides to report 6-bytes trackstick packets
> > as 3-bytes bare PS/2 (data will be reported to dev3 instead
> > dev2).
> >=20
> > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Subject should be: "do *not* mix" or "prevent mix"

Right, I'll adjust it.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
