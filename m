From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Revoke and multiple user ids
Date: Sun, 7 Nov 2010 10:08:49 -0500
Message-ID: <AANLkTinyz3v=VqzL1fKhPX3Ln5sYxt8CwM09899BvPSh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38621 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab0KGPIu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 10:08:50 -0500
Received: by wwb39 with SMTP id 39so3009981wwb.1
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 07:08:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

There was some discussion at plumbers about how to handle input when
the input device is shared between multiple user ids and you want to
make sure that one of those users doesn't insert a key logger. Since
Linux doesn't have a revoke system call there isn't a good way to
implement this.

A random idea for handling this would be to implement a pseudo revoke
inside the input subsystem. You could do this by creating a set of
evdev device nodes in a subdirectory of the /dev tree for each logged
in user.  Policy kit (or whatever handles user switching) would ask
for a set of these device nodes to be created whenever someone logs
in. The appropriate privs would be set on them. They get deleted when
the user logs out. One set of nodes for each logged in user.

When policy kit (which has root privs) hands the system over to a
different user it would use and ioctl to tell the input core to move
the evdev events over to another set of evdev nodes. The evdev events
only appear on the device nodes of the logged in user.

1) each logged in user has a set of evdev nodes with ownership and
permission set to only them
2) users can't look at each other's evdev nodes because they don't
have permission to open them
3) the privileged task that swaps users tells the kernel to move the events
4) tasks can insert key loggers and keep the device nodes open,
because now it doesn't matter.

This can probably be built as a small module that load on top of the
existing evdev system. The base evdev nodes would always be root
owned.

I forgot who was asking me how to do this, it was someone working on X
to make it run as non-root.

-- 
Jon Smirl
jonsmirl@gmail.com
