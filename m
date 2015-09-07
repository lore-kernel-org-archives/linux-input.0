From: Stephan Mueller <smueller@chronox.de>
Subject: USB HID devices not linked to RNG
Date: Mon, 07 Sep 2015 02:10:16 +0200
Message-ID: <1735492.1FWVU9y0M8@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.eperm.de ([89.247.134.16]:33786 "EHLO mail.eperm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbbIGAKX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Sep 2015 20:10:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-crypto@vger.kernel.org, linux-input@vger.kernel.org
Cc: tytso@mit.edu

Hi,

While analyzing the entropy sources for the random number generator in 
drivers/char/random.c, I saw that a USB mouse and a USB keyboard does trigger 
the add_input_randomness function to be triggered.

Is that intended? 

-- 
Ciao
Stephan
