From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 6/8] input: i8042: add Dritek quirk for Acer TravelMate
	660
Date: Wed, 30 Jul 2008 15:47:41 -0400
Message-ID: <20080730154701.ZZRA012@mailhub.coreip.homeip.net>
References: <200807301931.m6UJVffQ012061@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:42795 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbYG3Trr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 15:47:47 -0400
Received: by an-out-0708.google.com with SMTP id d40so30079and.103
        for <linux-input@vger.kernel.org>; Wed, 30 Jul 2008 12:47:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807301931.m6UJVffQ012061@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, bonbons@linux-vserver.org

On Wed, Jul 30, 2008 at 12:31:41PM -0700, akpm@linux-foundation.org wro=
te:
> From: Bruno Pr=E9mont <bonbons@linux-vserver.org>
>=20
> The Acer TravelMate 660 series also requires the Dritek quirk to enab=
le
> the extra scancodes.
>=20

Andrew,

Please drop this patch - it's been in mainline for a while now.
--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
