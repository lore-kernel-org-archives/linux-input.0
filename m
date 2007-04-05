From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Thu, 5 Apr 2007 13:36:15 -0700
Message-ID: <20070405133615.6536eea5@localhost>
References: <20070221221629.59088fed@localhost>
	<200704040116.58366.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704040116.58366.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 4 Apr 2007 01:16:57 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> Hi Stephen,
> 
> On Thursday 22 February 2007 01:16, Stephen Hemminger wrote:
> > I did a little investigation and the touchscreen on B6210 is
> > attached via the 8250 serial port. I tried enabling it with
> > inputattach but seem to get garbage.
> > 
> > I can extract the initialization code from the evtouch driver
> > to a usermode program and read information from /dev/ttyS0.
> > 
> > The lifebook psmouse extension won't work because it tries
> > to grab the 8042 (touchpad) rather than the touch screen.
> > 
> > Ideas?
> > 
> 
> Please try the patch below. You will need to load 8250_pnp,
> serport and fujitsu_ts modules, then do
> 
>         inputattach -fjt /dev/ttyS0
>

inputattach runs (then waits). Data is arriving when I touch
the screen. Now what? Do I need an Xorg driver for it?
