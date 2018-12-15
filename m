From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Date: Sat, 15 Dec 2018 11:12:21 +0100
Message-ID: <20181215101221.GA23879@suse.com>
References: <20181214232437.GA8310@amd>
 <20181215085510.GB12930@suse.com>
 <20181215094722.GA5804@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215094722.GA5804@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Sat, Dec 15, 2018 at 10:47:22AM +0100, Pavel Machek wrote:

> > > b) would it be acceptable if done properly? (cmd line option to
> > > enable, avoiding duplicate/wrong events?)
> > 
> > Well, for one, you shouldn't be using a timer, all the debouncing can be
> > done by math on the event timestamps.
> 
> Not... really, right? You need to send an release some time after
> button indicates release if bounce did not happen. It is similar to
> autorepeat needing a timer.

You can send the first release and ignore all presses and releases in a
time window after that.

> Let me gain some experience with the patch. I don't think hardware
> does as heavy debouncing as you describe.

Microswitches vibrate significantly when clicked. Without hardware
debouncing, you'd have many clicks instead of one even on a new mouse.


-- 
Vojtech Pavlik
