From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 15:49:39 +0100
Message-ID: <20080815144939.GV4462@implementation.uk.xensource.com>
References: <20080814044337.GA11632@emu>
	<1218725645.907.27.camel@thor.sulgenrain.local>
	<1218736209.4467.11.camel@localhost.localdomain>
	<20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi>
	<20080815080247.GA17613@fooishbar.org>
	<20080815082629.GB16680@sci.fi>
	<20080815100717.ZZRA012@mailhub.coreip.homeip.net>
	<20080815143921.GC16680@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20080815143921.GC16680@sci.fi>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michel D?nzer <michel@tungstengraphics.com>, xorg@lists.freedesktop.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Ville Syrj=E4l=E4, le Fri 15 Aug 2008 17:39:21 +0300, a =E9crit :
> This also affect DirectFB and it was the original reason why I added
> EVIOCGRAB code to DirectFB's linux-input driver. Grabbing didn't cause
> problems back then but now that the input subsystem is used by
> rfkill/acpi/etc. functionalitys is lost when the devices are grabbed.

Also note that some (root-launched) daemons like brltty would like to be
notified of some given keyboard shortcut.  What they end up doing for
now is grabbing all the keyboard, and re-emiting all the keys through a
uinput.

Samuel
