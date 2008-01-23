From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 0/12] improve pxa27x keypad driver
Date: Wed, 23 Jan 2008 15:15:35 +0800
Message-ID: <f17812d70801222315g6114a11frebd63c8eebfbba39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:23488 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbYAWHPf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:15:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4879952wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:15:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Most of the code are actually identical to the previous pxa3xx version
I sent to this list month ago. These are separated patches based on
the existing pxa27x_keyboard.c, as requested.

The series of the patches can actually be divided into two groups:
---
      pxa: rename the pxa27x_keyboard to pxa27x_keypad
      pxa: remove the pin configuration from the keypad driver
      pxa: introduce driver structure and use KEY() to define matrix keys
      pxa: introduce pxa27x_keypad_config() for keypad registers configuration
      pxa: enable both rotary encoders and direct keys for keypad
      pxa: use device resources for I/O memory mapping and IRQ
      pxa: add debounce_interval configuration to the keypad platform data
      pxa: make pxa27x_keypad.c support both pxa27x and pxa3xx

---
      pxa: add pxa27x_keypad device and pxa_set_keypad_info()
      pxa: add partial keypad support for mainstone
      pxa: add keypad support for zylonite
      pxa: add keypad support for littleton

I'll send the below 4 patches to RMK's tree if the above 6 are merged.
I'm listing them here for the purpose of completeness and illustration
of the usage.

-- 
Cheers
- eric
