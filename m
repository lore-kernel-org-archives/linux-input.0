From: Michael Poole <mdpoole@troilus.org>
Subject: Apple Magic Mouse multitouch support
Date: Wed, 20 Jan 2010 21:15:02 -0500
Message-ID: <877hrckxuh.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52890 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751663Ab0AUCUg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 21:20:36 -0500
Received: by mail-qy0-f177.google.com with SMTP id 7so3046777qyk.10
        for <linux-input@vger.kernel.org>; Wed, 20 Jan 2010 18:20:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

A number of messages around the net have observed that the Magic Mouse
peripheral only distinguishes between left and right clicks, doesn't
emulate a scroll wheel, etc.

The multitouch input data from the mouse uses a proprietary format[1] --
the HID report descriptor lists X, Y, button, battery and a 64-byte
usage on a vendor-specific usage page -- so it doesn't parse using a
standard HID parser.

My questions:

How do I know whether it's easier to write this as a heavily customized
HID driver or a generic input driver (one which happens to talk to a
Bluetooth HID device)?

The mouse reports when it stops seeing a reflection from its laser.  How
should that be passed to applications?

Because the mouse can only classify clicks based on touch position, a
driver might as well classify clicks for three buttons.  Would there be
objections to a driver having a writable parameter to make it emulate a
three-button mouse instead of a two-button mouse?

Similarly, would there be objections to a driver having a writable
parameter to make it emulate a scroll wheel?

Is there a plan for some higher level to perform middle-click or scroll
wheel emulation rather than have each driver do the work?  (It seems
plausible that other touch-sensitive hardware has the same limit.)

[1]- Except for __le24 not existing, the touch data has to be enabled by
sending HID SET_REPORT sequences, and the data looks approximately like
this, using report 0x29:
struct magic_mouse_touch {
  __s8 x;
  __s8 y;
  __le24 timestamp_and_buttons;
  struct {
    __le24 x_y;
    __u8 probably_minor_length;
    __u8 apparently_major_length_and_flags;
    __u8 angle;
    __u8 state_and_touch_id;
  } touch[];
};
where the two lsbs of the timestamp_and_buttons contain 0, 1 or 2 to
indicate inferred click type, and the touch[] array can range from 0 to
at least 4 elements.  I'm not 100% sure about the format or meaning of
the two axis length bytes.  The SET_REPORT enable byte sequences are
0x53, 0xd7, 0x01 and 0x53, 0xf8, 0x01, 0x32 respectively -- 0x53 being
the Bluetooth HID binding value for SET_REPORT with type Feature; I'm
not sure about the other bytes.

Michael Poole
