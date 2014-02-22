From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: is it possible to temporarily not let user mode get hid input event
Date: Sat, 22 Feb 2014 17:56:15 +0100
Message-ID: <CANq1E4SJDz2q0Rgn1f7u_b0w-mjVTte8=G2_qL38QnahDkUC1Q@mail.gmail.com>
References: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59807 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaBVQ4Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Feb 2014 11:56:16 -0500
In-Reply-To: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: loody <miloody@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi

On Sat, Feb 22, 2014 at 5:35 PM, loody <miloody@gmail.com> wrote:
> hi all:
> is there any kernel hid module parameter or test program can
> temporarily not letting user mode program not receiving hid event?
> 1. My hid kos are still inserted in.
> 2. the kernel usb driver is working well; that mean kernel usb driver
> still handle interrupt transaction.
>
> I just not want user mode program see the hid event for a while,

For each connected HID device, there is a driver bound to it that
reads the events and forwards them to HID core. What you can do, is to
unbind a driver on a given device:
  echo "<your-device-name>" >/sys/bus/hid/drivers/<driver-name>/unbind
The device-name is the directory name in:
  /sys/bus/hid/devices/
The driver name is usually "hid-generic" but can be figured out for
each device by looking at the "driver" symlink in it's directry.
However, this is *really* just meant for debugging. This is not
recommended for anything serious. There is no support for that and if
you don't know what all this does, you shouldn't use it.

There is no proper way to disable a single device in the kernel.
User-space is supposed to control device-access so we probably won't
add such features to the kernel. If you describe your use-case in more
details, we can try to give hints how to get that working.

Thanks
David
