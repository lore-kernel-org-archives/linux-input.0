From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Bringing IR (common remote controls) into the input fold
Date: Fri, 7 Nov 2008 14:57:55 -0500
Message-ID: <9e4733910811071157o30629f69xce03e5f6a1f68324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:55726 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYKGT54 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Nov 2008 14:57:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1419814rvb.1
        for <linux-input@vger.kernel.org>; Fri, 07 Nov 2008 11:57:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I just found the linux-input list. I've been working on integrating IR
support into the kernel in a manner consistent with the design of the
rest of the input subsystem. I'm aware of LIRC. I'm posting this code
to the LIRC mailing list and asking for feedback/help but none has
been forth coming.

LIRC exists outside of the kernel and builds its device drivers
externally. It has an independent design as an input system and
requires apps to be aware of it. It needs a daemon running.  LIRC has
been around ten years and works fine, it's just not integrated with
the rest of input.

I'm looking for feedback and help designing a more optimal way of
integrating IR into the input framework.

I posted V4 of my in-kernel IR system to LKML.  It supports mapping
from IR events to key strokes now.
http://lkml.org/lkml/2008/11/5/233

To do the mapping it uses configfs (part of the kernel).  The main
directory is remotes. You use a shell script to build mappings between
the IR event and key stroke.

mkdir /config/remotes/sony
  -- this creates a new evdev device
mkdir remotes/sony/one
echo 7 >remotes/sony/one/procotol
echo 264 >remotes/sony/one/command
echo 2 >remotes/sony/one/keycode

This transforms a button push of 1 on my remote into a key stroke for KEY_1

 *   configfs root
 *   --remotes
 *   ----specific remote
 *   ------keymap
 *   --------protocol
 *   --------device
 *   --------command
 *   --------keycode
 *   ------repeat keymaps
 *   --------....
 *   ----another remote
 *   ------more keymaps

You can map the 1 button from multiple remote to KEY_1 if you want. Or
you can use a single remote to create multiple virtual keyboards.

I'm always looking for help with this code. I've implemented support
for my embedded GPIO based receiver and Microsoft MCEUSB. I'd really
like to see IR added to existing Linux input family of keyboards,
mice, joystick, tablet, touchscreen and gameport.

-- 
Jon Smirl
jonsmirl@gmail.com
