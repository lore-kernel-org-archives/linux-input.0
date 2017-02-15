From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3] HID: wacom: generic: support touch on/off softkey
Date: Wed, 15 Feb 2017 12:13:54 -0800
Message-ID: <CAF8JNhJeUVwr6GBNi6MhJ6cq5uYHeeg4UoMdfXi6ZW5n1JfC=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35004 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdBOUOP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 15:14:15 -0500
Received: by mail-ot0-f195.google.com with SMTP id y13so1882751oty.2
        for <linux-input@vger.kernel.org>; Wed, 15 Feb 2017 12:14:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Bastien,

Thank you for your comment.

> -----Original Message-----
> From: Bastien Nocera [mailto:hadess@hadess.net]
> Sent: Wednesday, February 15, 2017 2:28 AM
> To: Ping Cheng <pinglinux@gmail.com>; linux-input@vger.kernel.org
> Cc: jikos@kernel.org; benjamin.tissoires@gmail.com; dmitry.torokhov@gmail=
.com; Cheng, Ping <Ping.Cheng@wacom.com>; Cheng, Ping <Ping.Cheng@wacom.com=
>
> Subject: Re: [PATCH 3/3] HID: wacom: generic: support touch on/off softke=
y
>
> On Tue, 2017-02-14 at 21:27 -0800, Ping Cheng wrote:
>> Wacom Cintiq Pro has a softkey to turn touch on/off. Since it is a
>> softkey, hardware/firmware still reports touch events no matter what
>> state the softkey is. We need to ignore touch events when the key is
>> in off mode.
>
> Why can't this simply be reported to user-space to handle? This would all=
ow an OSD popping up. Implementing everything in the driver means that we'r=
e setting ourselves up for "fat finger" bug reports where the user doesn't =
know that they disabled the tablet, as there would be no notification of th=
e change.

I see your point. But, the reasons to support your point don't match
with the reality.

1. We still send an event (SW_MUTE_DEVICE) to inform user(land) that
touch is disabled. So, if you plan to popup an OSD, you are well
informed. Plus, there is a LED on the tablet to indicate its for touch
on/off. Users should know what they are doing unless they accidentally
touch it, which is, uh, an accident.

2. Allow kernel to take care of it is better than having clients
repeat the same implementation everywhere. This is especially helpful
for those applications that communicate with kernel directly.

This patch is to make sure the key does what it meant to.

Cheers.
Ping
