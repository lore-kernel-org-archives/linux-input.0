From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] Atari input patches
Date: Sun,  8 May 2011 11:17:24 +0200
Message-ID: <1304846247-12401-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:43514 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1EHJRh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2011 05:17:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

	Hi Dmitry,

Here are 3 patches to fix keyboard and mouse on Atari, after conversion to
the "new" (several years old) input framework.

  [1/3] input/atari: Use the correct mouse interrupt hook
  [2/3] input/atari: Fix atarimouse init
  [3/3] input/atari: Fix mouse movement and button mapping

Will you take them for 2.6.40, or can I get them in through my m68k tree?

Thanks in advance!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
