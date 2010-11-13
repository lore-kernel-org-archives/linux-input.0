From: Julien Cristau <jcristau@debian.org>
Subject: Re: Touchpad toggle mess
Date: Sat, 13 Nov 2010 19:10:13 +0100
Message-ID: <20101113181013.GM5063@radis.liafa.jussieu.fr>
References: <1288915209.5418.72.camel@novo.hadess.net>
	<20101106153031.GA2215@piware.de>
	<1289059101.5418.93.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces+gcfx-xorg-2=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1289059101.5418.93.camel@novo.hadess.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces+gcfx-xorg-2=m.gmane.org@lists.freedesktop.org
Errors-To: xorg-bounces+gcfx-xorg-2=m.gmane.org@lists.freedesktop.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, Martin Pitt <martin.pitt@ubuntu.com>, xorg@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org

On Sat, Nov  6, 2010 at 15:58:21 +0000, Bastien Nocera wrote:

> On Sat, 2010-11-06 at 11:30 -0400, Martin Pitt wrote:
> > Hello Bastien,
> > 
> > Bastien Nocera [2010-11-05  0:00 +0000]:
> > > The patches in https://bugs.freedesktop.org/show_bug.cgi?id=31300
> > > implement this for the kernel, and for X.org.
> > > 
> > > Then we have the problem that udev's keymaps seem to use different
> > > function keys depending on the hardware [1], when X.org (because of the
> > > limitations of XKB) standardised on F22 for "XF86TouchpadToggle".
> > 
> > Thanks for bringing this up, indeed there's some cleanup in order
> > here.
> > 
> > > So we'll need to standardise on the keys used. I selected F21 for
> > > XF86TouchpadToggle, F22 for XF86TouchpadOn and F23 for XF86TouchpadOff.
> > > See the patch in:
> > > https://bugs.freedesktop.org/show_bug.cgi?id=31333
> > > 
> > > The remaining fixes would need to be in udev's keymaps, to set hardware
> > > handled keys to F22 and F23, and software ones to F21. Patch is attached
> > > for that.
> > 
> > Indeed the maps which don't currently use f22 should be fixed,
> > regardless of what happens in X/kernel/userspace. My main concern is
> > that F22 has acted as touchpad toggle key for years
> 
> No, for about a year:
> http://cgit.freedesktop.org/xkeyboard-config/commit/?id=1d05eda8dfc706d6450cab5883120e0d5e1100c0
> 
That seems long enough that moving touchpad toggle from f22 to something
else for no particular reason will break stuff...

Cheers,
Julien
_______________________________________________
xorg@lists.freedesktop.org: X.Org support
Archives: http://lists.freedesktop.org/archives/xorg
Info: http://lists.freedesktop.org/mailman/listinfo/xorg
Your subscription address: gcfx-xorg-2@m.gmane.org
