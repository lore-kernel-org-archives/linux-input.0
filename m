From: "Cedric Sodhi" <ManDay@gmx.net>
Subject: HID-USB Touchpad not working again
Date: Fri, 05 Oct 2012 18:03:12 +0200
Message-ID: <20121005160312.6710@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:39188 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752782Ab2JEQDO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Oct 2012 12:03:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, I changed my tablet from an ASUS EEE Slate w/ EEFI eGalax Multitouch device to a SAMSUNG XE700T1A w/ AtmelmaXTouch Digitizer 03eb:211c

Both evdev and wacom give strange results. In particular, only a percentage of the touches are registered as clicks (all are registered as moves, but only a few of them as clicks).

I'll submit evtest logs as soon as I can. In the meantime, has anyone heard of this? There have been similar regressions in the past for usb-hid, so perhaps this is another.

Thank you, I'll get evtest logs as soon as I can.

Cedric
