From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Date: Sat, 15 Dec 2018 09:55:10 +0100
Message-ID: <20181215085510.GB12930@suse.com>
References: <20181214232437.GA8310@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214232437.GA8310@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Sat, Dec 15, 2018 at 12:24:37AM +0100, Pavel Machek wrote:

> Patch is obviously not ready; but:
> 
> a) would it be useful to people

Probably not.

Mice already do internal software/hardware debouncing on switches. If you
see duplicate clicks making it all the way to the kernel driver, something
is very wrong with the switch, to the point where it'll soon fail
completely.

Hence the value of doing extra processing in the kernel is very limited.

> b) would it be acceptable if done properly? (cmd line option to
> enable, avoiding duplicate/wrong events?)

Well, for one, you shouldn't be using a timer, all the debouncing can be
done by math on the event timestamps.

You'd also have a hard time distinguishing between doubleclicks and bounces.

Since the mice already filter the quick bounces and there is significant
delay (100ms on USB, similar on PS/2) between updates from the hardware, a
real doubleclick can look absolutely the same as what you observe as a
bounce.

As such, it couldn't be enabled by default.

If you really want to go this way, a userspace solution is the better choice.

-- 
Vojtech Pavlik
