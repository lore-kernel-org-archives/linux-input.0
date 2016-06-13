From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/4] input/alps: Add touchstick support for SS5 hardware
Date: Mon, 13 Jun 2016 15:47:23 +0200
Message-ID: <20160613134723.GC29844@pali>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <1464436862-2649-2-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35399 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423440AbcFMNr1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2016 09:47:27 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so79224849wmv.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jun 2016 06:47:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464436862-2649-2-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

On Saturday 28 May 2016 14:00:59 Ben Gamari wrote:
> Add touchstick support for the so-called SS5 hardware, which uses a
> variant of the SS4 protocol.
> ---
>  drivers/input/mouse/alps.c | 64 ++++++++++++++++++++++++++++++++++++=
++--------
>  drivers/input/mouse/alps.h |  2 ++
>  2 files changed, 55 insertions(+), 11 deletions(-)

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
