From: "George Spelvin" <linux@horizon.com>
Subject: Hacking on ati_remote driver
Date: 22 Sep 2010 21:27:20 -0400
Message-ID: <20100923012720.14819.qmail@science.horizon.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:20256 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751953Ab0IWBeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 21:34:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux@horizon.com

I dusted off my ATI all-in-wonder remote and was trying to get it to
work with VLC (so far unsuccessfully; I'm still untangling the
multiple mapping layers between hardware scancode and X event), and
I had a look at the ati_remote.c driver.

I started hacking on it.  Mostly I thought the ati_remote_tbl[]
array was wastefully large.  It gets a lot simpler when you
realize that, in the 4-byte report, data[1] is actually a checksum
and not part of the keycode.  data[1] = data[2] + data[3] + 0xE5.

Having looked over the input layer documentation, I have decided that
the ati_remote driver could use some love.  I'd like to convert it to
use the generic scancode to keycode mapping and autorepeat logic.

However, RTFMing and RTFSing left me with a few questions:

- Should the keybit[] bitmap be an exact map of possible buttons, or
  is a superset okay?  The driver handles several models of remote,
  and the later ones added a few buttons.  Can I use a single superset
  scancode map, or is there some benefit to supplying an exact "which
  keys exist" list?  (EVIOCGBIT ioctl?)

- Is there some all-in-one function to report "scancode arrived" to the
  input layer, or do I have to call input_get_keycode and input_report_key
  separately?

- Is the input device required to ensure that the key-up keycode matches
  the key-down, even if someone reprograms the scancode map in between?

- I read somewhere that the EV_KEY event's value should be 0 for up,
  1 for down, and 2 for autorepeat.  But the input_report_key function
  canonicalizes values to 0/1.  What's the right value to use for
  autorepeat?

- The remote doesn't generate key-up events on most of its buttons.
  It does, however, have hardware autorepeat, so the current code figures
  it out with a timeout.  Should I synthesize key-up events this way,
  even though they're not very accurate?  Or can I just use the timeout
  to guess between key-down and autorepeat, and omit key-up events
  entirely?

- The receiver supports up to 16 transmitters.  Currently, they're all
  funneled through a single input device with a mask available in the
  device driver to suppress unwanted ones.  Is it worth splitting this
  into multiple input devices instead?  Or is there some other way I
  should pass the "channel number" into the input layer?

- Should the 0-9 buttons on the remote generate KEY_0 through KEY_9 or
  KEY_NUMERIC_0 through KEY_NUMERIC_9?

- More generally, the current driver has a few dubious default key
  code assignments.  Should I fix these or carefully preserve them for
  compatibility?

- Likewise, the ati_remote2 driver assigns remotes 1-16 (numbered 0-15
  in the internal protocol) to mask bits 0-15.  The ati_remote driver
  uses mask bits 1-16, and ignores bit 0.  The former convention
  makes more sense to me.  Convert ati_remote or preserve backward
  compatibility?

(Note that in either case, I'll segregate the backward compatibility
breaks into their own patches.)

Thank you for any guidance.


P.S.
I can also have a look at the remote wonder plus patches some folks
developed at
http://www.mythtv.org/wiki/ATI_Remote_Wonder_Plus
