From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] input: mc13783_ts: rename to mc13xxx_ts
Date: Mon, 30 Jan 2012 00:52:59 -0200
Message-ID: <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
	<1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54914 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab2A3CxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 21:53:00 -0500
Received: by eekc14 with SMTP id c14so1271360eek.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 18:52:59 -0800 (PST)
In-Reply-To: <1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Reilly <marc@cpdesign.com.au>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

Hi Marc,

On Sun, Jan 29, 2012 at 8:51 PM, Marc Reilly <marc@cpdesign.com.au> wro=
te:
> Start moving this driver towards support for both mc13892 and mc13783=
=2E
>
> This patch simply renames mc13783 specific identifiers to the generic
> mc13xxx. A platform_device_id table is also added so that the driver
> is still created correctly for the mc13783 only.
>
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
> =C2=A0drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A08 +-
> =C2=A0drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
2 +-
> =C2=A0drivers/input/touchscreen/mc13783_ts.c | =C2=A0259 ------------=
-------------------
> =C2=A0drivers/input/touchscreen/mc13xxx_ts.c | =C2=A0267 ++++++++++++=
++++++++++++++++++++
> =C2=A04 files changed, 272 insertions(+), 264 deletions(-)
> =C2=A0delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
> =C2=A0create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c

=46or the rename, it is better to do:
git mv  drivers/input/touchscreen/mc13783_ts.c
drivers/input/touchscreen/mc13xxx_ts.c

git commit -a

and then git format -M -1 , as it will detect the rename.

Regards,

=46abio Estevam
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
