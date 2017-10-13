From: Rajat Jain <rajatja@google.com>
Subject: [usbhid] identifying a particular usbhid device as wakeup reason?
Date: Thu, 12 Oct 2017 17:38:55 -0700
Message-ID: <CACK8Z6EHE1=L1gTNpodaJdOsz_2YTXWCzr=EzFV3huPHqTpB3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@google.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi usbhid folks,

I'd like to identify after a wakeup from suspend, that my USB HID
keyboard was used to wake up the system.

I'm trying to understand why don't I see "wakeup_count" increase for
my USB keyboard or trackpad in /sys/kernel/debug/wakeup_sources, when
I indeed woke up the system using the keyboard? I do not see
wakeup_count increased for any device (including the underlying usb
device for usbhid) when I wake using the keyboard.

I do see that the wakeup_count increases for other devices when I wake
using them (e.g. wifi on a PCI bus, or bluetooth controller on USB
bus).

My questions:

1) How can I go about fixing this problem?

2) Is it because the usbhid driver does not call pm_wakeup_event() on
wake? In retrospect, is it because the usbhid driver cannot tell that
its key presses indeed woke up the system (as opposite to if the
system was already up)?

Thanks,

Rajat
