From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/5] input: wacom: Initial support for Bamboo (rev3)
Date: Sat, 4 Sep 2010 23:24:12 +0200
Message-ID: <AANLkTi=9F1HpUyhGOp0TJdazoshKgxbFkyqWvztb5OeH@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Saturday, September 4, 2010, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> This the fourth iteration of the Bamboo patches. Hopefully no big
> surprises. =A0The ordering has changed to allow setting the pressure_=
max
> which is not parsed in the hid function. Ping's button mapping has
> been implemented, relying on middle-button emulation instead. =A0The
> lowres quirks now apply to all touch devices in the family.

Thank you Henrik for the patchset. Very much appreciated.

Acked-by: Ping Cheng < pingc@wacom.com>  for the series.

Ping

> Henrik Rydberg (4):
>  =A0input: wacom: Add fuzz parameters to features
>  =A0input: wacom: Collect device quirks into single function (rev2)
>  =A0input: wacom: Add support for the Bamboo Touch trackpad (rev4)
>  =A0input: wacom: Add a quirk for lowres Bamboo devices (rev2)
>
> Ping Cheng (1):
>  =A0input: wacom: Parse the Bamboo device family
>
> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A01 +
> =A0drivers/input/tablet/wacom_sys.c | =A0 57 +++++++++++++-----
> =A0drivers/input/tablet/wacom_wac.c | =A0123 ++++++++++++++++++++++++=
+++++++++++++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 14 ++++
> =A04 files changed, 176 insertions(+), 19 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
