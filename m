From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2 0/4] input: wacom - Add Bamboo Pen Support
Date: Sun, 12 Sep 2010 04:13:27 +0200
Message-ID: <AANLkTinCoY=7sm4VjRk=bmO1cvEcwWqgVGKG4pCaFfJm@mail.gmail.com>
References: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36945 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0ILCN2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Sep 2010 22:13:28 -0400
Received: by wyf22 with SMTP id 22so4669348wyf.19
        for <linux-input@vger.kernel.org>; Sat, 11 Sep 2010 19:13:27 -0700 (PDT)
In-Reply-To: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "chris@cnpbagwell.com" <chris@cnpbagwell.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "pingc@wacom.com" <pingc@wacom.com>

On Saturday, September 11, 2010, =A0<chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Addes Bamboo Pen and Pen&Touch support. =A0Builds on previous
> commited support for Bamboo Touch.
>
> Only difference in this patch set is patch #3. =A0It makes suggested
> change to logic for checking pen in-proximity and adds comment
> to clarify why 2-bits are checked.
>
> Chris Bagwell (4):
> =A0=A0input: wacom - Request tablet data for Bamboo Pens
> =A0=A0input: wacom - move Bamboo Touch irq to own function
> =A0=A0input: wacom - Add support for Bamboo Pen
> =A0=A0input: wacom - disable Bamboo touchpad when pen is being used.

Acked-by: Ping Cheng <pingc@wacom.com> for the whole series.

Ping

> =A0drivers/input/tablet/wacom_sys.c | =A0 =A09 ++--
> =A0drivers/input/tablet/wacom_wac.c | =A0 97 ++++++++++++++++++++++++=
++++++++++++--
> =A02 files changed, 97 insertions(+), 9 deletions(-)
>
> --
> 1.7.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
