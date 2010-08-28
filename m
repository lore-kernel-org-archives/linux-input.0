From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/3] hid: 3m: Complete MT support
Date: Sat, 28 Aug 2010 16:27:29 +0200
Message-ID: <1283005652-3198-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51975 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753546Ab0H1O2e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Aug 2010 10:28:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Jiri, Stephane, Dmitry,

Please find enclosed a set of patches which enables full support for
the 60-finger, 22-inch 3M touchscreen. Two of the patches fix actual
problems, and one patch converts the driver to the MT slots protocol.

The changes depend on two recent patches:
     - hid: Add a hid quirk for input sync override
     - input: mt: Initialize slots to unused

The tested hardware was provided by Canonical Ltd.

Cheers,
Henrik

Henrik Rydberg (3):
  hid: 3m: Adjust to sequential MT HID protocol
  hid: 3m: Convert to MT slots
  hid: 3m: Correct touchscreen emulation

 drivers/hid/hid-3m-pct.c |  111 +++++++++++++++++++++++++---------------------
 1 files changed, 61 insertions(+), 50 deletions(-)

