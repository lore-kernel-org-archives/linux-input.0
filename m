From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/6] Input: psmouse - rearrange Focaltech init code
Date: Fri, 11 Dec 2015 12:44:45 +0100
Message-ID: <20151211114445.GJ12308@pali>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
 <1448774036-39040-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37396 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbLKLos (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2015 06:44:48 -0500
Content-Disposition: inline
In-Reply-To: <1448774036-39040-4-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org

On Saturday 28 November 2015 21:13:53 Dmitry Torokhov wrote:
> The fact that we were calling focaltech_init() even when Focaltech su=
pport
> is disabled was confusing. Rearrange the code so that if support is
> disabled we continue to fall through the rest of protocol probing cod=
e
> until we get to full reset that Focaltech devices need to work proper=
ly.
>=20
> Also, replace focaltech_init() with a stub now that it is only called=
 when
> protocol is enabled.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

It's also OK, so

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
