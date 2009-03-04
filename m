From: Richard Hughes <hughsient@gmail.com>
Subject: [PATCH] panasonic-laptop: use correct key names for sleep states
 in driver
Date: Wed, 04 Mar 2009 10:58:26 +0000
Message-ID: <1236164306.3936.20.camel@hughsie-work.lan>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pTTjnuC1JjDoeYHU7nk4"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:30271 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZCDK7V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 05:59:21 -0500
In-Reply-To: <1236164049.3936.17.camel@hughsie-work.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>


--=-pTTjnuC1JjDoeYHU7nk4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2009-03-04 at 10:54 +0000, Richard Hughes wrote:
> On Mon, 2009-03-02 at 08:24 -0300, Henrique de Moraes Holschuh wrote:
> > FWIW, I think it is a good idea, and I'd take patches for
> > thinkpad-acpi.
> 
> Patch attached for thinkpad-acpi. KEY_HIBERNATE is already in
> linux-next, but has not yet been pushed to master. Please review,
> thanks.

Patch also attached for panasonic-laptop. Harald, can you please review
this. Thanks.

Richard


--=-pTTjnuC1JjDoeYHU7nk4
Content-Disposition: attachment; filename*0=0003-panasonic-laptop-use-correct-key-names-for-sleep-ke.patc; filename*1=h
Content-Type: text/x-patch; name="0003-panasonic-laptop-use-correct-key-names-for-sleep-ke.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 11df58e5c55e6286f03b29b6b9820ed4b13095db Mon Sep 17 00:00:00 2001
From: Richard Hughes <richard@hughsie.com>
Date: Wed, 4 Mar 2009 10:57:36 +0000
Subject: panasonic-laptop: use correct key names for sleep keys in driver

Use the new key KEY_HIBERNATE and correct the use of KEY_SUSPEND.

KEY_HIBERNATE is used when the decal on the key indicates sleep to disk,
KEY_SUSPEND is used when the decal indicates sleep to memory, and
KEY_SLEEP is used when the sleep type is unknown or unspecified

We've already converted Xorg, HAL, and most of userspace to use the same names.

With this patch, the sleep keys can be labeled consistently all the way
through the stack. More patches to other device drivers are to follow.

Signed-off-by: Richard Hughes <hughsient@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index c47a44d..63a1828 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -205,10 +205,10 @@ static const int initial_keymap[KEYMAP_SIZE] = {
 	/*  4 */ KEY_MUTE,
 	/*  5 */ KEY_VOLUMEDOWN,
 	/*  6 */ KEY_VOLUMEUP,
-	/*  7 */ KEY_SLEEP,
+	/*  7 */ KEY_SUSPEND,
 	/*  8 */ KEY_PROG1, /* Change CPU boost */
 	/*  9 */ KEY_BATTERY,
-	/* 10 */ KEY_SUSPEND,
+	/* 10 */ KEY_HIBERNATE,
 };
 
 struct pcc_acpi {
-- 
1.6.1.3


--=-pTTjnuC1JjDoeYHU7nk4--

