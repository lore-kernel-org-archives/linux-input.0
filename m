From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Modifying keycodes or scancodes of keyboard devices
Date: Wed, 12 Sep 2012 22:49:21 +0200
Message-ID: <20120912224921.45d3e383@neptune.home>
References: <op.wkg8x5kq486orv@labs03>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:33424 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab2ILUuQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Sep 2012 16:50:16 -0400
In-Reply-To: <op.wkg8x5kq486orv@labs03>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Laurenz Baumann <marenz@supradigital.org>
Cc: linux-input@vger.kernel.org

Hallo Mathias,

On Tue, 11 September 2012 "Mathias Laurenz Baumann" <marenz@supradigital.org> wrote:
> I want to write a kernel module that hooks in somewhere between the  
> keyboard driver and whatever
> uses the resulting key events (e.g. evdev or xkb).

You can usually just tell the kernel to map scancodes to different keycodes
unless the driver you are targetting does something really weird.


Have a look at the following ioctls to change the scancode-keycode mappings
or even just find out what the current mappings are:
  EVIOCGKEYCODE
  EVIOCSKEYCODE
They both take and int[2] as argument for which the first int is the scancode
and the second one the keycode (there is a new revision of those ioctls that
work differently, for you to look them up).

Just issue the ioctls on your event device.


Sample userspace code for looking up mappings (note that you will eventually
need to adjust the scancode search range, brute-force 0x0..0xffffffff, best is
to capture a few evdev events to determine how the scancodes look like):

  int evdev = open("/dev/input/eventX", O_RDONLY);
  int codes[2];

  printf("Scancode mapping table:\n");
  for (codes[0] = 0x70000; codes[0] < 0x70060; codes[0]++) {
    if (ioctl(evdev, EVIOCGKEYCODE, codes) >= 0) {
      if (codes[1] == 0)
        continue;
      printf("0x%04x        => %s  (%d)\n", codes[0], get_key_name(codes[1]), codes[1]);
    } else if (errno != EINVAL) {
      fprintf(stderr, "Failed to get mapping for scancode %d: %s\n", codes[0], strerror(errno));
    } else
      continue;
  }


For the meaning of the keycodes, see linux/input.h (KEY_*)

Bruno
