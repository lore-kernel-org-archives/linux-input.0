From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 0/2] HID: Force feedback support for the Logitech G920 Wheel
Date: Sat, 28 Nov 2015 08:53:37 +0100
Message-ID: <CADbOyBRy0SNL6m4eetV=Fn_YPGo7ge4YpDLeKkr88nfhg-qdQw@mail.gmail.com>
References: <1448109431-10459-1-git-send-email-e.velds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33125 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbK1Hxi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2015 02:53:38 -0500
In-Reply-To: <1448109431-10459-1-git-send-email-e.velds@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Edwin Velds <e.velds@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Nov 21, 2015 at 1:37 PM, Edwin Velds <e.velds@gmail.com> wrote:
> This patch implements force feedback support for the Logitech G920 Driving Force
> Racing Wheel.
>
> This patch is based on the basic G920 support patch by Simon Wood:
> http://www.spinics.net/lists/linux-input/msg42174.html
>
> The first patch splits and renames the HID++ driver (hid-logitech-hidpp.c) into
> a basic header and implementation in order to allow building additional features
> from multiple sources. Since this only satisfies the needs for the FF driver,
> any comments or suggestions are welcome.
>
> The second patch implements all supported force feedback effects. The force
> feedback implementation was not made optional because the G920 (like all
> Logitech wheels) can't function without it due to very stiff to default springs.
>
> Edwin Velds (1):
>   HID: Create header for Logitech HID++ driver
>   HID: Force feedback support for the Logitech G920
>
>  drivers/hid/Makefile                  |    2 +
>  drivers/hid/hid-logitech-hidpp-base.c | 1725 ++++++++++++++++++++++++++++++
>  drivers/hid/hid-logitech-hidpp-base.h |   81 ++
>  drivers/hid/hid-logitech-hidpp-ff.c   |  540 ++++++++++
>  drivers/hid/hid-logitech-hidpp-ff.h   |    9 +
>  drivers/hid/hid-logitech-hidpp.c      | 1900 ---------------------------------
>  6 files changed, 2357 insertions(+), 1900 deletions(-)
>  create mode 100644 drivers/hid/hid-logitech-hidpp-base.c
>  create mode 100644 drivers/hid/hid-logitech-hidpp-base.h
>  create mode 100644 drivers/hid/hid-logitech-hidpp-ff.c
>  create mode 100644 drivers/hid/hid-logitech-hidpp-ff.h
>  delete mode 100644 drivers/hid/hid-logitech-hidpp.c
>
> --
> 2.5.0
>

You have my:
Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Note however that at least a V2 can be expected:
I did a review off-list just before this patchset made it to this
mailing list, and not all changes are applied yet.

Thanks,
Elias
