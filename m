From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 10:11:31 -0400
Message-ID: <20120418141131.GN19507@zod.bos.redhat.com>
References: <20120418140517.GM19507@zod.bos.redhat.com>
 <1334758134.8818.132.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1334758134.8818.132.camel@novo.hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org, Richard Hughes <richard@hughsie.com>, mjg@redhat.com
List-Id: linux-input@vger.kernel.org

On Wed, Apr 18, 2012 at 03:08:54PM +0100, Bastien Nocera wrote:
> On Wed, 2012-04-18 at 10:05 -0400, Josh Boyer wrote:
> > Commit 4f5ca836b "HID: hid-input: add support for HID devices reporting
> > Battery Strength" added the CONFIG_HID_BATTERY_STRENGTH option to report
> > the battery strength of HID devices.  The commit log explicitly mentions
> > it not working properly with recent userspace, but it is default y
> > anyway.  This is rather odd, and actually causes problems on real
> > systems.
> > 
> > This works around Fedora bug
> > https://bugzilla.redhat.com/show_bug.cgi?id=806295
> 
> Don't. The only bit of user-space that's broken is upower, and it's
> getting a fixed release shortly.

Matthew suggested that additional kernel patches were required to add a
scope parameter so upower could understand that the battery is powering
a device and not the system.

Also, when did it become OK to force-enable a new feature that is
_known_ to not work properly on recent userspace?  That makes no sense
to me.

josh
