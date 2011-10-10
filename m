From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 0/3] Input: wacom bamboo improvements
Date: Mon, 10 Oct 2011 09:04:37 -0500
Message-ID: <CAGzDe_bg_-aScThVQMJ+KJZX96N_m6uwBA4+bkq+9xpvSKw-wA@mail.gmail.com>
References: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60554 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab1JJOEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:04:38 -0400
Received: by iabz25 with SMTP id z25so377462iab.19
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2011 07:04:38 -0700 (PDT)
In-Reply-To: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>

On Wed, Sep 14, 2011 at 8:36 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> The need for patch 3 was recently discussed on linuxwacom
> mailing list. During that discussion, I looked closer at pen
> code and notice pressure cleanup needed (patch 1) and that
> ABS_DISTANCE was not completely implemented (patch 2).

Hi Dmitry,

Where there any issues for including these patches?

I also have new patches to add support for just released Bamboo
tablets that support 16 touches... but they build upon these patches.

Should I resend old+new patches together?

Chris

>
> Chris Bagwell (3):
> =A0Input: wacom - remove unneeded touch pressure init
> =A0Input: wacom - add ABS_DISTANCE to Bamboo Pen reports
> =A0Input: wacom - correct max Y value on medium bamboos
>
> =A0drivers/input/tablet/wacom_wac.c | =A0 47 +++++++++++++++++++++---=
--------------
> =A01 files changed, 26 insertions(+), 21 deletions(-)
>
> --
> 1.7.6
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
