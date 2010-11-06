From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: ir-core and default IR maps
Date: Sat, 6 Nov 2010 18:08:57 -0400
Message-ID: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51423 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0KFWI6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 18:08:58 -0400
Received: by wyb36 with SMTP id 36so2252539wyb.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 15:08:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I thought about this some more and I think the default maps should
stay in the drivers. The maps are marked __init so they don't take any
room after they are loaded. This is an important piece and plug and
play and we should keep it. Only the keymaps for default remote
controls that ship with the specific hardware should be included in
the driver. All other keymaps are in user space.

Upsides:
  plug and play
  no requirement to have a user space IR component installed

Downsides:
  compile time - minor and it only impacts developers
  maintaining two copies - one in the kernel source and another in the
user space package. This can be handled via scripts.

If you have user space support installed, you should be able to:
  1) delete/replace the pre-loaded keymaps
  2) load any number of your own maps (receivers should support an
arbitrary number of remotes if the hardware can do it).
  3) use unhandled key events to search through the library of maps to
find the right one and then modify init scripts to load it.

All of the hundred plus in-kernel driver keymaps should also be
duplicated into the user space package. That lets you use these
remotes with other receivers.

Per the discussions at plumbers all decoders that the receiver
supports should be enabled all of the time. If we get data saying this
is a bad idea it can be changed. But disabling multiple drivers does
nothing to improve the performance of another driver. For example if
you have an RC5 remote and you disable the Sony protocol, the decode
error rate on the RC5 decoders is not going to change since the
protocol decoders don't talk to each other. Worst case the command
will decode in both protocols and be filtered by the loaded keymaps.
This is just one less thing for the user to be concerned with. It also
makes the identification of new remotes easier since all of the
protocols will be turned on.  Of course modify this appropriately for
non-general purpose hardware. (Now that Linux supports generate
purpose decoding, vendors can build general purpose receives and save
some money).

-- 
Jon Smirl
jonsmirl@gmail.com
