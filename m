From: Alessio Sangalli <alesan@manoweb.com>
Subject: "soft" USB keyboard and mouse driver
Date: Tue, 21 Apr 2009 01:48:23 -0700
Message-ID: <49ED8857.9010809@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61507 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbZDUIsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2009 04:48:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi I would need a hint what is best to do; I have an embedded device
that can do a "soft" implementation of USB for embedded
applications. The aim is to be compatible with low-speed HID USB
devices.

The fact is, it does not implement a full USB stack but only
point-to-point communication with the aforementioned devices. I know it
sounds weird but it's more like a "PS/2" port than a USB thing.

Now, I have a generic character device driver that can read keyboard and
mouse data. Of course I get what a USB device would send when you press
keys etc.

How do you think it would be the best way to integrate it with the input
subsystem?

Any idea would be appreciated.

Thank you!
Alessio


