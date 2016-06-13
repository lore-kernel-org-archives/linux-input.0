From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/4] input/alps: Handle 0-pressure 1F events
Date: Mon, 13 Jun 2016 15:49:21 +0200
Message-ID: <20160613134921.GD29844@pali>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <1464436862-2649-3-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36530 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423772AbcFMNt0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 09:49:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so15031894wme.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2016 06:49:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464436862-2649-3-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

On Saturday 28 May 2016 14:01:00 Ben Gamari wrote:
> While a button is held SS5 hardware will give us single-finger packet=
s
> with x, y, and pressure equal to zero. This causes annoying jumps in
> pointer position if a touch is released while the button is held. Han=
dle
> this by claiming zero contacts to ensure that no position events are
> provided to the user.
> ---
>  drivers/input/mouse/alps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
