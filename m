From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Wed, 29 Sep 2010 16:45:53 +0400
Message-ID: <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36179 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab0I2Mp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 08:45:58 -0400
Received: by qyk36 with SMTP id 36so983474qyk.19
        for <linux-input@vger.kernel.org>; Wed, 29 Sep 2010 05:45:56 -0700 (PDT)
In-Reply-To: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> PS2Mult is a simple serial protocol used for multiplexing several PS/=
2 streams
> into one serial data stream. It's used e.g. on TQM85xx serie of board=
s.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>
> It actually depends on "serio: multiple children" patch. I'm not rese=
nding it
> as you were the originator of the latest version of the patch.

So, what about this version of patch?

>
> =A0drivers/input/serio/Kconfig =A0 | =A0 =A08 +
> =A0drivers/input/serio/Makefile =A0| =A0 =A01 +
> =A0drivers/input/serio/ps2mult.c | =A0283 +++++++++++++++++++++++++++=
++++++++++++++
> =A0include/linux/serio.h =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A04 files changed, 294 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/serio/ps2mult.c

--=20
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
