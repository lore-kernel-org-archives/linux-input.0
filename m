From: Vincenzo Scotti <vinc94@gmail.com>
Subject: Perixx reprogrammable mouse
Date: Sun, 5 Oct 2014 12:59:51 +0200
Message-ID: <20141005105951.GA1935@vinc94-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40372 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaJEK76 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Oct 2014 06:59:58 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so4475143wgg.25
        for <linux-input@vger.kernel.org>; Sun, 05 Oct 2014 03:59:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello.
I just bought some new mouses from Perixx MX's series. They work out of the
box with usbhid, even though they don't have an official driver under Linux to
remap buttons, and online I couldn't find anything useful.
So I was planning as a spare time project to write some sort of driver.
I read that usbmon could be useful to understand the protocol, if using
something like a Virtualbox VM with Windows running on it.
Given that, would it be better to make the driver as a kernel module, or as a
userspace application? I couldn't find any reprogrammable mouse driver in the
kernel drivers directory.
I think that the more games will be ported to Linux, the more we'll need soon
to have some support for this gamers-equipment.

I hope you'll give me some hints.

Regards,
Vincenzo.
