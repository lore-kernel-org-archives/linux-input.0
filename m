From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 09/14 v3] Input: atmel_mxt_ts - refactor get info
Date: Sun, 6 May 2012 10:43:03 +0800
Message-ID: <CAGS+omCGaCujKbhbf8vUwa0K26jGFHzYJc7m_cx3fUBcUpsO6A@mail.gmail.com>
References: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
 <1334755319-21365-10-git-send-email-djkurtz@chromium.org> <4FA5665D.80304@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FA5665D.80304@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
List-Id: linux-input@vger.kernel.org

On Sun, May 6, 2012 at 1:41 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrote=
:
> Hi Daniel-
>
> Daniel Kurtz wrote:
>> - =A0 =A0 dev_info(&client->dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Family ID: %d Variant ID:=
 %d Version: %d Build: %d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->family_id, info->var=
iant_id, info->version,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->build);
>> + =A0 =A0 dev_info(dev, "Family ID: %d Variant ID: %d Major.Minor.Bu=
ild: %d.%d.%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0info->family_id, info->variant_id, info=
->version >> 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0info->version & 0xf, info->build);
>
> The canonical format for the Atmel firmware versions has the build nu=
mber
> in hex, eg. 2.0.AA
>
> So it should be %d.%d.%02X

Nick,
Thanks!  Will update.  Or perhaps %u.%u.%02X ?
-Daniel

>
> cheers
>
> Nick
