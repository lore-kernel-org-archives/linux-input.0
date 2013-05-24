From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: register HID devices async
Date: Fri, 24 May 2013 15:53:28 +0200
Message-ID: <CANq1E4RLoJQWBehsbLhgtd8hYDUDFj61eDQOPvM+Wk8i56qHxw@mail.gmail.com>
References: <1369307425-5993-1-git-send-email-dh.herrmann@gmail.com>
	<CACo8zOc=zYVQ3dSooEjGRCD_YenczwCPepC=85pbXv0T7fxb5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58063 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3EXNx2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 May 2013 09:53:28 -0400
In-Reply-To: <CACo8zOc=zYVQ3dSooEjGRCD_YenczwCPepC=85pbXv0T7fxb5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Fri, May 24, 2013 at 12:46 AM, Daniel Nicoletti <dantti12@gmail.com> wrote:
> Ok, just tested with my two Apple mouses (Trackpad & MagicMouse),
> and with the ENODATA patch it now works perfectly, the other mouse
> doesn't freeze when connecting and the udev signals are also properly
> emitted, is there some formal way of adding a tested-by?
>
> tested-by: Daniel Nicoletti <dantti12@gmail.com>

Just this line is enough. Thanks!

It's weird, though, that the other patch is required. With this patch
here, hid_get_raw_report() should work just fine on bluetooth _and_
usb devices. And the fact that you no longer get a delay means that
I/O is working properly. However, the GET_REPORT request seems to fail
after device-initialization for some reason.

My guess is that we send REPORT_INIT requests in hid_start() and
Bluetooth devices seem to not work well with that. Hence, they send an
HANDSHAKE error for each report once. This seems to fall into the same
time-span where we send our first battery-request during registration
and hence HIDP-core thinks the battery-request failed.
@Jiri, @Marcel are you sure report-initialization is needed for
BT-HIDP devices? BT-HID-profile doesn't mention it, but it relies
heavily on USB-HID (which I haven't read..)..

Anyway, would be nice to see both patches applied.

Cheers
David
