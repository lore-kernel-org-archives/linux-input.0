From: Tino Keitel <tino.keitel@tikei.de>
Subject: HID blacklist for the Apple IR sensor
Date: Tue, 10 Jul 2007 20:26:36 +0200
Message-ID: <20070710182636.GA12522@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

in commit a417a21e10831bca695b4ba9c74f4ddf5a95ac06, the Apple IR sensor
was added to a blacklist so that no HID device is created anymore.
However, as of lirc 0.8.2, there is a lirc driver called "macmini" that
requires that HID device to work. There is also a driver that creates
an input device for the Apple IR sensor. It can be found in the
mactel-linux patches[1], but it is not in the kernel yet. I also don't
know how both sides behave if they are used concurrently.

I think that the blacklist entry for USB_DEVICE_ID_APPLE_IR should be
removed at least as long as the appleir.patch is not part of the
mainline kernel.

Please CC me in replies.

Regards,
Tino

[1] http://mactel-linux.svn.sf.net/viewvc/mactel-linux/trunk/kernel/mactel-patches-2.6.22/
