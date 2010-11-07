From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Keyboard support in Wayland
Date: Sun, 7 Nov 2010 15:02:54 -0500
Message-ID: <AANLkTim5UpEFTZZPtoh3LPrFz12P2gMa1UhoLJtQhknP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35482 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab0KGUC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 15:02:56 -0500
Received: by wwb39 with SMTP id 39so3129438wwb.1
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 12:02:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, wayland-devel@lists.freedesktop.org, krh@bitplanet.net

A repost now that I found the Wayland discussion list...
Who is doing the libxkbcommon work? Please add them to the thread.

---------------------------------------------------------

Wayland presents and opportunity to ditch xkeys. What do you think
about having Wayland apps use the kernel keysyms and drop the whole
legacy xkey world? Of course we would keep that library around for
legacy purposes. The goal is to build a key mapping system usable by
all apps/windowing systems, not just X.

We have a opportunity here to redesign the keymap system for direct
Wayland apps and not repeat the legacy problems from X. Clearly there
is more to this than just using scan codes out of the kernel. I'm no
expert on keymapping but I'll try and get the discussion started.

There's some discussion here about the deficiencies in X keyboard handling...
http://www.freedesktop.org/wiki/Software/LibXklavier

----------------------------

Another thought on this would be to move the kernel definitions of
multimedia keys to a private space in Unicode. Currently they are
defined on top of existing characters in Unicode. Doing this will
remove the need to remap them.

The Unicode people have been asked to directly support multimedia keys
in Unicode and they have declined to do so since there are too many
variations.

-- 
Jon Smirl
jonsmirl@gmail.com
