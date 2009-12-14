From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Add Clickpad support to synaptics driver
Date: Mon, 14 Dec 2009 11:01:27 +0100
Message-ID: <1260784889-5205-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34607 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755342AbZLNKBh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 05:01:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The following small patches are to add the support of new "Clickpad"
devices from Synaptics.  The first patch implements the very basic
change to enable the click reporting while the second one implements
the ClickZone mode support.


[Please add me to Cc as I'm not subscribed to the list.]

thanks,

Takashi
