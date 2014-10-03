From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] input: alps: Reset mouse and ALPS driver immediately
 after first invalid packet
Date: Fri, 03 Oct 2014 11:55:52 +0200
Message-ID: <542E72A8.2030908@redhat.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com> <1412329392-5580-4-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49518 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbaJCJ4B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Oct 2014 05:56:01 -0400
In-Reply-To: <1412329392-5580-4-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 10/03/2014 11:43 AM, Pali Roh=C3=A1r wrote:
> For unknown reasons linux psmouse alps driver sometimes receive total=
ly invalid
> packet sequences on Dell Latitude laptops. According to ALPS HW engin=
eers these
> invalid packets do not come from ALPS devices. So it looks like bug i=
n BIOS and
> EC incorrectly split keyboard and touchpad PS/2 data when laptops are=
 under
> heavy loads (big I/O together with powersave governor, running on bat=
tery).
>=20
> There are sequences of invalid packets (which are dropeed) and some s=
equences
> which look like valid. But these valid packets cause random trackstic=
k button
> pressing, random cursor moving/jumping and in these condition it is n=
ot possible
> to use ALPS device (trackstick+touchpad).
>=20
> To prevent random button press and random cursor jumps immediately re=
set ALPS
> device after first invalid packet. This will cause that touchpad and =
trackstick
> will not respond for one or two seconds and it better then random cur=
sor jumps.
>=20

This one probably should have:

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1145954

And you may want to add Bug: tags to the relevant patches for the
launchpad issues too.

While on the topic of tags, once we've agreed upon the return value to =
use for the
2nd patch, can you please resend with a "Cc: stable@vger.kernel.org" ad=
ded to all
3 patches?

> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Looks good and seems sensible:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks & Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
