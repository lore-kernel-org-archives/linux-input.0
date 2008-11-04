From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27] AM300 kit support
Date: Tue,  4 Nov 2008 08:55:08 +0800
Message-ID: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbYKDAzT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:55:19 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:55:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org

Hi Eric, Dmitry, Geert, Krzysztof, lak, input, fbdev,

This is my first pass at adding support for things on the AM300 kit from
E-Ink. The main two new things are the Wacom w8001 support and the
AM300/broadsheetfb display support. The other 3 patches are for cleanup.

There are still issues I intend to debug (latency on the display, usb
issues) but will lose access to the hardware for a while so this seems like
a good point to post the code. I would greatly appreciate your feedback.

Thanks,
jaya


