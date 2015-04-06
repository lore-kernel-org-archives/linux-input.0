From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.0-rc6
Date: Mon, 6 Apr 2015 13:37:05 -0700
Message-ID: <20150406203705.GD36776@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38802 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbbDFUhK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Apr 2015 16:37:10 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Hans de Goede <hdegoede@redhat.com>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem - two more tweaks for ALPS
driver to work out kinks after splitting the touchpad, trackstick, and
potential external PS/2 mouse into separate input devices.

Changes to support ALPS SS4 devices (protocol V8) will be coming in
4.1...

Changelog:
---------

Hans de Goede (3):
      Input: alps - report interleaved bare PS/2 packets via dev3
      Input: alps - report V2 Dualpoint Stick events via the right evdev node
      Input: alps - document stick behavior for protocol V2


Diffstat:
--------

 Documentation/input/alps.txt |  8 ++++++++
 drivers/input/mouse/alps.c   | 37 +++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 14 deletions(-)


-- 
Dmitry

