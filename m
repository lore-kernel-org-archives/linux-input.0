From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 0/4] HID: wacom: fixes for next
Date: Fri, 20 Jan 2017 18:35:22 -0800
Message-ID: <CANRwn3QHsoURBnpybX4Bn1UAMif13yqo16NEg1JFqfz4GD=3dA@mail.gmail.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35665 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdAUCfY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 21:35:24 -0500
In-Reply-To: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>

Patches 1/3 look reasonable to me, though I've not run into the bugs
they aim to fix. For those:

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

As for patch 4, I have some additional reservations about hiding the
message... We can discuss that further in its thread.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Fri, Jan 20, 2017 at 7:20 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> well, these are non critical but nonetheless interesting fixes for
> Wacom I was working on last week. I was waiting for the current v4.10
> fix to be sent by Jason before pushing those out.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (4):
>   HID: wacom: release the resources before leaving despite devm
>   HID: wacom: remove warning while disconnecting devices
>   HID: wacom: do not attempt to switch mode while in probe
>   HID: wacom: do not shout an error on LED control
>
>  drivers/hid/wacom.h     |  1 +
>  drivers/hid/wacom_sys.c | 42 ++++++++++++++++++++++++++++++------------
>  2 files changed, 31 insertions(+), 12 deletions(-)
>
> --
> 2.9.3
>
