From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: HID blacklist for the Apple IR sensor
Date: Wed, 11 Jul 2007 16:48:59 +0200
Message-ID: <1184165339.15323.32.camel@localhost>
References: <20070710182636.GA12522@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070710182636.GA12522@dose.home.local>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Nicolas Boichat <nicolas@boichat.ch>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-07-10 at 20:26 +0200, Tino Keitel wrote:
> Hi,
> 
> in commit a417a21e10831bca695b4ba9c74f4ddf5a95ac06, the Apple IR sensor
> was added to a blacklist so that no HID device is created anymore.
> However, as of lirc 0.8.2, there is a lirc driver called "macmini" that
> requires that HID device to work. There is also a driver that creates
> an input device for the Apple IR sensor. It can be found in the
> mactel-linux patches[1], but it is not in the kernel yet. I also don't
> know how both sides behave if they are used concurrently.

Sorry for the `late' reply... I was travelling...

> I think that the blacklist entry for USB_DEVICE_ID_APPLE_IR should be
> removed at least as long as the appleir.patch is not part of the
> mainline kernel.

If there is indeed a lirc driver for this providing all the
functionality why would one ever want to have any appleir.patch in the
future? I meant to pave the way for appleir to go in, but now I don't
see a need for it as an in-kernel driver anymore.

So I am fine with reverting the blacklist entry... and I am CC'ing this
to Nicolas as I think the appleir.patch should be removed from the
mactel svn for future releases.

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
