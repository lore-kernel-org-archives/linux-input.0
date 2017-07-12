From: Olof Johansson <olof@lixom.net>
Subject: Regression during 4.13 merge window: Mouse not working (under X)
Date: Wed, 12 Jul 2017 14:45:18 -0700
Message-ID: <CAOesGMheE95s75AAz7+H5SPSF068XxAZudWOrEi_FQj_Krkffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry,

I installed current mainline (as of 3b06b1a744) on a z840 here, and
lost the mouse.

Bisecting down, it seems like "HID: usbhid: remove custom locking from
usbhid_open/close" (e399396a6b0) is at fault, and if I revert that and
283a21da1239 I get a working system again. Userspace is Ubuntu 16.04.


Looking at X and dmesg logs, the only delta I see is that in the
_good_ case I have a couple of these in dmesg:

usb 3-12: Device not responding to setup address.
usb 3-12: Device not responding to setup address.

3-12 unrelated to keyboard/mouse though (it's a 4-port hub, likely
internal to the PC), so seems like a red herring.

So, not sure just what's the root cause here, but allowing concurrent
opens seems to make for unhappiness. It's a pretty small patch and
nothing in it seems wrong, besides the change in behavior on allowing
concurrent opens (removal of the mutex).



-Olof
