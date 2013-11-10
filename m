From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: HID: RFC: Would HID_QUIRK_HAS_SPECIAL_DRIVER make sense?
Date: Sun, 10 Nov 2013 15:32:06 +0100
Message-ID: <1384093926.5711.64.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:45370 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab3KJOcI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Nov 2013 09:32:08 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 637FB1985E9
	for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 15:32:07 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 5CFB628A9E2
	for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 15:32:07 +0100 (CET)
Received: from [192.168.0.7] (dslb-092-074-045-009.pools.arcor-ip.net [92.74.45.9])
	(Authenticated sender: screamingfist@arcor.de)
	by mail-in-10.arcor-online.net (Postfix) with ESMTPSA id 36CB12D63A7
	for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 15:32:07 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

devices that have special drivers in the kernel are added to
hid_core.c:hid_have_special_driver[] so that the hid-generic driver does
not bind the device.

Drivers not in the kernel have to rely on a mechanism of unbinding the
device from hid-generic and binding it to the right driver with an udev
rule or something.

I realized that on some modern distributions (namely Ubuntu13.10 and
Fedora19) this seems not to work anymore for my Roccat drivers. After
rebinding the device to the target driver the /dev/input/event* devices
show no output.
In Ubuntu13.10 this problem can be bypassed by adding the target module
to initrd, but not on Fedora19.

While I'm further investigating this issue it doesn't look like a basic
kernel problem, as the newer kernel versions work on older distros
flawlessly.

But I stumbled over the following idea which does not fix the problem,
but be an alternative to rebinding:

What about a HID_QUIRK_HAS_SPECIAL_DRIVER quirk that has the same
functionality as an entry in hid_have_special_driver[]?

In my eyes it looks like a suitable accommodation to the existing quirks
NOGET and IGNORE.

Mabe I'm overlooking something and a solution already exists?

Also, I would be glad to hear any hints on the rebind issue.

Thanks and have a nice day 
Stefan Achatz


