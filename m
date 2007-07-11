From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: HID blacklist for the Apple IR sensor
Date: Wed, 11 Jul 2007 23:37:46 +0200
Message-ID: <20070711213746.GA11256@dose.home.local>
References: <20070710182636.GA12522@dose.home.local> <1184165339.15323.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <1184165339.15323.32.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Nicolas Boichat <nicolas@boichat.ch>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 11, 2007 at 16:48:59 +0200, Soeren Sonnenburg wrote:

[...]

> If there is indeed a lirc driver for this providing all the
> functionality why would one ever want to have any appleir.patch in the
> future? I meant to pave the way for appleir to go in, but now I don't
> see a need for it as an in-kernel driver anymore.

When I didn't had lirc running using the input device, some Gnome
thingie seemed to react on key presses, so that the volume could be
adjusted. With the hiddev, this won't work anymore, but I think that
this was just generic functionality because the appleir driver
generated the proper key events for volume adjustments, so nothing
specific to the Apple IR.

Regards,
Tino
