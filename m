From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 0/6] suggested changes to gpio_buttons driver
Date: Wed, 24 Nov 2010 16:01:34 -0500
Message-ID: <cover.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38235 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:43 -0500
Received: by mail-gy0-f172.google.com with SMTP id 13so112220gyb.3
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:42 -0800 (PST)
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org

These are just some suggested changes from the review in patch-form. I will
do my best to make time for reviewing and testing any future versions of the
patch that you submit but I will regrettably be moving to other projects 
for awhile. Until then I will not be able to spend much time on integration.

With these patches applied I was able to build the da850-evm buttons and keys
support with minimal changes.As I said, these are just suggested changes,
please feel free to squash, edit or drop them as you see fit. My motivation 
here is that if you pickup the driver name and config symbol names as-is then
I will have no remaining integration to perform in the da850-evm series. I
hope you don't mind that I have to patch and run here.

I look forward to your next version of the patch. 

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca

Ben Gardiner (6):
  fixup gpio_buttons: use the same debounce_interval member found in
    gpio_key to obtain a threshold count based on polling interval
  fixup gpio_buttons: use existing gpio_keys_button structure instead
    of introducing new gpio_button structure
  fixup gpio_buttons: detect and error-out if a button is requested for
    wakeup
  fixup gpio_buttons: show units of poll_interval platform data member
  fixup gpio_buttons: move gpio_buttons.c to drivers/input/keyboard
    from drivers/input/misc
  fixup gpio_buttons : rename gpio-buttons / gpio_buttons to
    gpio-keys-polled / gpio_keys_polled

 drivers/input/keyboard/Kconfig                     |   16 ++++
 drivers/input/keyboard/Makefile                    |    2 +
 .../gpio_buttons.c => keyboard/gpio_keys_polled.c} |   86 +++++++++++---------
 drivers/input/misc/Kconfig                         |   16 ----
 drivers/input/misc/Makefile                        |    1 -
 .../linux/{gpio_buttons.h => gpio_keys_polled.h}   |   15 +---
 6 files changed, 69 insertions(+), 67 deletions(-)
 rename drivers/input/{misc/gpio_buttons.c => keyboard/gpio_keys_polled.c} (64%)
 rename include/linux/{gpio_buttons.h => gpio_keys_polled.h} (60%)

