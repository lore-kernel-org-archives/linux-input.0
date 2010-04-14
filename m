From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Synaptics Clickpad support
Date: Wed, 14 Apr 2010 17:10:21 +0200
Message-ID: <1271257823-23566-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45627 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab0DNPKw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 11:10:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

here are small patches to add a support of Synaptics Clickpad devices;
more exactly, it adds the way for X11 synaptics driver detecting the
Clickpad device to handle its specific features.

Unlike my previous patch, this version gives little additions in the
kernel side.  It changes the bit-mask of supported buttons and
converts the button event to the left-button.  And, with the second
patch, it adds a capability of LED input event.

The corresponding patches required for xorg synaptics driver will be
posted to xorg ML soon later.  If anyone needs them beforehand, I can
mail them beforehand, of course.


thanks,

Takashi
