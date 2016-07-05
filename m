From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add MKBP event support
Date: Tue, 5 Jul 2016 13:55:44 -0700
Message-ID: <CAOesGMjPaztVQPYEvGdHkQDDJYsw2bLSnaz5R_e5hsHYDZZsvw@mail.gmail.com>
References: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
 <1467364076-20172-2-git-send-email-enric.balletbo@collabora.com> <CAOesGMgXoHxDv0An6OTp+qg4BK+Zvom_rtAhFHfF726Y0RHHDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35249 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbcGEUzp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 16:55:45 -0400
Received: by mail-io0-f193.google.com with SMTP id u25so21914121iou.2
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2016 13:55:45 -0700 (PDT)
In-Reply-To: <CAOesGMgXoHxDv0An6OTp+qg4BK+Zvom_rtAhFHfF726Y0RHHDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Lee Jones <lee.jones@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>, Randall Spangler <rspangler@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Benson Leung <bleung@chromium.org>

On Tue, Jul 5, 2016 at 1:54 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jul 1, 2016 at 2:07 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> From: Vic Yang <victoryang@google.com>
>>
>> Newer revisions of the ChromeOS EC add more events besides the keyboard
>> ones. So handle interrupts in the MFD driver and let consumers register
>> for notifications for the events they might care.
>>
>> To keep backward compatibility, if the EC doesn't support MKBP event, we
>> fall back to the old MKBP key matrix host command.
>>
>> Signed-off-by: Vic Yang <victoryang@google.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Cc: Randall Spangler <rspangler@chromium.org>
>> Cc: Vincent Palatin <vpalatin@chromium.org>
>> Cc: Benson Leung <bleung@chromium.org>
>
> Probably easiest to merge this through the MFD tree due to the
> overlaps, so for that purpose:
>
> Acked-by: Olof Johansson <olof@lixom.net>

Argh, I just noticed that the second patch is an input patch, not
another MFD patch. Either way, I'm OK with this going through the
input tree if that's easiest. If so, you should probably wait for an
ack from Lee as well.


-Olof
