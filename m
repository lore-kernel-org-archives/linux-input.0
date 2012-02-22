From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: [PATCH 1/1] HID: new driver for non-compliant Saitek devices
Date: Wed, 22 Feb 2012 13:20:31 +0100
Message-ID: <20120222122028.GA1634@tapura>
References: <1329873006-29473-1-git-send-email-andreas@k4n.de>
 <alpine.LNX.2.00.1202221134040.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:33874 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2BVMU3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 07:20:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1202221134040.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looking through the patch again this morning, I noticed I made a mistake
in hid-ids.h. (copy'n'paste error, maybe it was a bit too late yesterday)


How do you want me to handle this? Resubmit the original patch?

Andreas

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="saitek.patch"

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index dc3dee5..9d18ec0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -613,7 +613,7 @@
 
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
-#define USB_DEVICE_ID_SAITEK_PS1000	0xff17
+#define USB_DEVICE_ID_SAITEK_PS1000	0x0621
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001

--yrj/dFKFPuw6o+aM--
