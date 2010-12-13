From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 0/2] hid-mosart: small patches
Date: Mon, 13 Dec 2010 15:59:11 +0100
Message-ID: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39626 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004Ab0LMPJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 10:09:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi guys,

Just a few patch before introducing hid-multitouch. It would be great if
this could be in 2.6.38 (or even before...) as hid-multitouch is a bit late.

This small patch-set enhance the support of hid-mosart in the kernel:
the first patch allows X to handle it as an absolute device, and the second
one introduce suspend/resume support.

The patch work is against the branch next of Dmitry's tree.

Henrik, I think that you added a device in your ppa.
Do you want me to send it?

Cheers,
Benjamin


