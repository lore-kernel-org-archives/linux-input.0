From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 0/5] HID: roccat: Achieve userspace notification on sysfs
 attribute creation
Date: Fri, 26 Nov 2010 20:57:24 +0100
Message-ID: <1290801444.18750.161.camel__17034.2169156813$1290801464$gmane$org@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:52894 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab0KZT52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 14:57:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, linux-doc@vger.kernel.orgl

Adding sysfs attributes to an already created device raises no userland
notification.

Instead of fiddling around in the depths of busses and devices I reuse the
event char device (module hid-roccat). This device gets now created with
a hardware specific class that contains the device attributes.

For this I had to introduce support for binary attributes into struct class.

This is afaik the easiest way to achieve said goal. If these patches get
applied I can upload a new version of my userland tools that is compatible
with old and new drivers in an instant.

As there are quite a couple of unapplied patches flying around, I decided
to base these patches on 2.6.37-rc2 and designed them to contain everything
pending and so make all unapplied patches obsolete.

