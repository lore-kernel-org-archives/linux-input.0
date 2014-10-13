From: Benson Leung <bleung@chromium.org>
Subject: Re: Elan TS driver patch
Date: Mon, 13 Oct 2014 11:47:21 -0700
Message-ID: <CANLzEktRicHTvAbDWe6E73EUdknJQT8TmTeHtmK=kUz46HPFtA@mail.gmail.com>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw>
	<20141007160358.GA16469@dtor-ws>
	<006001cfe294$13720370$3a560a50$@emc.com.tw>
	<20141010221137.GD38320@dtor-ws>
	<24A1508F-93CB-4139-BF22-4BD7A118E005@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:36962 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbaJMSrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2014 14:47:23 -0400
Received: by mail-vc0-f170.google.com with SMTP id hy10so6299361vcb.29
        for <linux-input@vger.kernel.org>; Mon, 13 Oct 2014 11:47:22 -0700 (PDT)
In-Reply-To: <24A1508F-93CB-4139-BF22-4BD7A118E005@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott <scott.liu@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Charles Mooney <charliemooney@google.com>, "Jeff.Chuang" <Jeff.chuang@emc.com.tw>, =?UTF-8?B?5qKB5Y2a57+U?= <paul.liang@emc.com.tw>, Duson Lin <dusonlin@emc.com.tw>

Hi Scott,

On Sun, Oct 12, 2014 at 8:22 AM, Scott <scott.liu@emc.com.tw> wrote:
>         I would call this driver name as =E2=80=9CElan Large-Size Tou=
chscreen=E2=80=9D.
>         We (Elan) have two types of TS series internally, Large-size(=
 > 10=E2=80=9D ~ 20") and small-size ( <=3D 10=E2=80=9D)
>         and this driver patch is for large size. thanks.

While this may be an accurate description of the touchscreen family,
Dmitry is looking for a part number that can identify the class of
devices. For example, Duson identified the touchpad part as "eKTH3000"

Is there a similar part number for the large size touchscreen?

--=20
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
