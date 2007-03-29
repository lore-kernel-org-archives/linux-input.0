From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux-2.6.20.4-ck1 / evdev / hub crash
Date: Thu, 29 Mar 2007 10:56:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0703291051500.19566@jikos.suse.cz>
References: <3aa654a40703282007xabf2fefi97c04162204ec091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3aa654a40703282007xabf2fefi97c04162204ec091@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 28 Mar 2007, Avuton Olrich wrote:

> I've been having problems lately with my mouse, and I know that the
> kernel is tainted. If that's a problem please just ignore this dump.
> I just restarted my computer with a ck[1] kernel, which I had been on
> for a couple of days before this, when X started I noticed that my MX
> Revolution mouse didn't work, so I tried to restart KDM (every now and
> again evdev fails, has problems). When that didn't work I decided to
> remove and reinstall the receiver from the hub, when I did I noticed X
> wouldn't start any more and my dmesg[2] had a dump. Also including a
> copy of my .config[3] (slightly modified for use with a newer kernel).
> This isn't a reoccurring issue, yet, just wanted to report it in case
> it's of any use, thanks. I'm not on the list, please CC me if anything
> is needed.
> 1.
> http://ck.kolivas.org/patches/pre-releases/2.6.20.4/2.6.20.4-ck1/patch-2.6.20.4-ck1.bz2
> 2. http://avuton.googlepages.com/evdev_dump
> 3. http://avuton.googlepages.com/config

Hi,

I added Dmitry and linux-input mailinglist to CC. This is the second time 
I see oops on dereferencing 0x00100100 pointer in evdev_disconnect() 
called from input_unregister_device()
- the first one is DVB-T related thing reported a few days ago here - 
http://lkml.org/lkml/2007/3/9/212

-- 
Jiri Kosina
