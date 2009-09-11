From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: special HID & Kconfig: odd behavior in gconfig
Date: Fri, 11 Sep 2009 15:57:07 +0100
Message-ID: <1252681027.2282.23.camel@castor>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

I use gconfig & and cannot turn off any of the special HID devices.

the Kconfig for them all have the same pattern e.g.

config HID_DRAGONRISE
	tristate "DragonRise Inc. support" if EMBEDDED
	depends on USB_HID
	default !EMBEDDED

The 'if EMBEDDED' on the tristate line seems to confuse gconfig and it
sets them all to m & does not let me set them to N. I'm building this on
a standard desktop machine.

Any idea what the intention of this was? or can we just remove the if
embedded part?

thanks

Richard


