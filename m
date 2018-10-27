From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Oops in current tree in i2c
Date: Sat, 27 Oct 2018 09:08:16 -0700
Message-ID: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Julian Sax <jsbc@gmx.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Julian, Jiri,
 On my laptop I'm getting a kernel page fault with the current git
tree, and I'm tentatively blaming commit

  9ee3e06610fd ("HID: i2c-hid: override HID descriptors for certain devices")

but that's simply because it's the only thing that seems to touch this
particular area in this merge window.

The oops looks like this:

  BUG: unable to handle kernel paging request at 000000007a25d598
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 1 PID: 888 Comm: systemd-udevd Not tainted 4.19.0-07715-g345671ea0f92 #4
  Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.7.0 01/16/2018
  RIP: 0010:strstr+0x19/0x70

where the code disassembly (and the register contents) shows that the
wild pointer is the first argument to "strstr()", which just has a
bogus value that is not a valid kernel pointer (RDI: 000000007a25d598
- which is obviously also the address of the page fault)

The call trace is:

   dmi_matches+0x55/0xc0
   dmi_first_match+0x26/0x40
   i2c_hid_get_dmi_i2c_hid_desc_override+0x16/0x40 [i2c_hid]
   i2c_hid_probe+0x28c/0x760 [i2c_hid]
   i2c_device_probe+0x1e7/0x260
   really_probe+0xf8/0x3e0
   driver_probe_device+0x10f/0x120
   bus_for_each_drv+0x66/0xb0
   __device_attach+0xd9/0x150
   bus_probe_device+0x8a/0xa0
   device_add+0x48e/0x660
   i2c_new_device+0x162/0x350

which is why I suspect that new i2c_hid_get_dmi_hid_report_desc_override() code.

I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
isn't terminated by a NULL entry, and I will test that next.

What makes me *very* unhappy about this is that if I'm right, I think
it means that code was literally not tested at all by anybody who
didn't have one of the entries in that list.

                  Linus
