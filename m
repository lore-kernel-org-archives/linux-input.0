From: Friedrich Strohmaier <damokles4-listen@bits-fritz.de>
Subject: Logitech wireless adaptor ID 046d:c52b not showing up xfce-powermanager
 since kernel 3.19
Date: Sun, 26 Apr 2015 19:47:22 +0200
Message-ID: <553D24AA.8030804@bits-fritz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zweiblum.4m2.net ([81.169.187.171]:43157 "EHLO smtp.4m2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbDZR4L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Apr 2015 13:56:11 -0400
Received: from [192.168.22.68] (p4FF023E6.dip0.t-ipconnect.de [79.240.35.230])
	by smtp.4m2.net (Postfix) with ESMTPA id DB0BF1B000E
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2015 19:47:22 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I'm not familiar writing to kernel lists so bear with me ;o))

subject
Since kernel update to 3.19 my logitech M570 trackball doesn't show up in
xfce4-power-manager as doesn't my logitech k230 keyboard.
My Logitech Mouse M315 still does.
All are connected via wireless usb Receiver.

That's what lsusb tells regarding Logitech devices:
Bus 007 Device 006: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 007 Device 011: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 007 Device 010: ID 046d:c52f Logitech, Inc. Unifying Receiver

Finally

this appears plugging in the mouse:
Bus 007 Device 010: ID 046d:c52f Logitech, Inc. Unifying Receiver

those appear plugin in trackball and keyboard :
Bus 007 Device 006: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 007 Device 011: ID 046d:c52b Logitech, Inc. Unifying Receiver

All devices work fine regarding functionality.

I run up to date archlinux 64-bit.

Proposal to post here I got at arch-general Mailinglist:
http://thread.gmane.org/gmane.linux.arch.general/53543/focus=53680

If of any interest for You please ask for more information if needed.

btw. I'm not subscribed to the list - please cc me.

regards
-- 
Friedrich
