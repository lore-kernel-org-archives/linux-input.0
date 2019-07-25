From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Regression] 5.3-rc1: hid_llogitech_dj does not work
Date: Thu, 25 Jul 2019 12:07:14 +0200
Message-ID: <2480108.bWkXKoXas6@kreacher>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Hans,

This is similar to a problem I reported some time ago:

https://lore.kernel.org/lkml/2268131.Lc39eCoc3j@kreacher/

and the device affected by it is the same.

The symptom is simply that the mouse just doesn't work (no reaction).  If I do
"rmmod hid_llogitech_dj", it says "Killed", but the module does go away and
the mouse starts to work (through the generic code I suppose), but then
the machine hangs on attempts to suspend (nasty).

Reverting all of the hid_llogitech_dj changes between 5.2 and 5.3-rc1:

dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
39d21e7e0043 HID: logitech-dj: make const array template static
423dfbc362b7 HID: logitech-dj: Add usb-id for the 27MHz MX3000 receiver

helps here, but the first two don't really look like they can make any difference,
so I guess I'm an unlucky owner of a MX3000 that doesn't quite work as expected.

Any help will be appreciated. :-)

Cheers,
Rafael
