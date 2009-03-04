From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] DVB-USB: correct the comment about KEY_SLEEP
Date: Wed, 04 Mar 2009 11:09:37 +0000
Message-ID: <1236164977.3936.30.camel@hughsie-work.lan>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eg88bVTcU++du7cL5R28"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:24248 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbZCDLKc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 06:10:32 -0500
In-Reply-To: <1236164049.3936.17.camel@hughsie-work.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antti Palosaari <crope@iki.fi>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>


--=-eg88bVTcU++du7cL5R28
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

Antti, I've included a fix to the Afatech AF9015 DVB-T USB2.0 receiver
header file. It corrects the comment about KEY_SLEEP. Please review.

Thanks,

Richard.


--=-eg88bVTcU++du7cL5R28
Content-Disposition: attachment; filename*0=0004-DVB-USB-use-correct-key-names-for-sleep-keys-in-dri.patc; filename*1=h
Content-Type: text/x-patch; name="0004-DVB-USB-use-correct-key-names-for-sleep-keys-in-dri.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 839a18f6663f416b484d496824beb7ad9cfe9215 Mon Sep 17 00:00:00 2001
From: Richard Hughes <richard@hughsie.com>
Date: Wed, 4 Mar 2009 11:01:31 +0000
Subject: DVB-USB: correct the comment about KEY_SLEEP

KEY_HIBERNATE is used when the decal on the key indicates sleep to disk,
KEY_SUSPEND is used when the decal indicates sleep to memory, and
KEY_SLEEP is used when the sleep type is unknown or unspecified

We've already converted Xorg, HAL, and most of userspace to use the same names.

With this patch, the sleep keys can be labeled consistently all the way
through the stack. More patches to other device drivers are to follow.

Signed-off-by: Richard Hughes <hughsient@gmail.com>
---
 drivers/media/dvb/dvb-usb/af9015.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/af9015.h b/drivers/media/dvb/dvb-usb/af9015.h
index 21c7782..e01587c 100644
--- a/drivers/media/dvb/dvb-usb/af9015.h
+++ b/drivers/media/dvb/dvb-usb/af9015.h
@@ -244,7 +244,7 @@ static struct dvb_usb_rc_key af9015_rc_keys_twinhan[] = {
 	{ 0x01, 0x17, KEY_SUBTITLE },     /* Subtitle / CC */
 	{ 0x00, 0x10, KEY_MUTE },
 	{ 0x01, 0x19, KEY_AUDIO },        /* L/R */ /* TODO better event */
-	{ 0x01, 0x16, KEY_SLEEP },        /* Hibernate */
+	{ 0x01, 0x16, KEY_SLEEP },        /* Sleep */
 	{ 0x01, 0x16, KEY_SWITCHVIDEOMODE },
 					  /* A/V */ /* TODO does not work */
 	{ 0x00, 0x06, KEY_AGAIN },        /* Recall */
-- 
1.6.1.3


--=-eg88bVTcU++du7cL5R28--

