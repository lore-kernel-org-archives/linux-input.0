From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] HID: hid-input: default HID_BATTERY_STRENGTH to no
Date: Wed, 18 Apr 2012 15:24:50 +0100
Message-ID: <20120418142450.GA30083@srcf.ucam.org>
References: <20120418140517.GM19507@zod.bos.redhat.com>
 <1334758134.8818.132.camel@novo.hadess.net>
 <20120418141131.GN19507@zod.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418141131.GN19507@zod.bos.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 18, 2012 at 10:11:31AM -0400, Josh Boyer wrote:
> On Wed, Apr 18, 2012 at 03:08:54PM +0100, Bastien Nocera wrote:
> > Don't. The only bit of user-space that's broken is upower, and it's
> > getting a fixed release shortly.
> 
> Matthew suggested that additional kernel patches were required to add a
> scope parameter so upower could understand that the battery is powering
> a device and not the system.
> 
> Also, when did it become OK to force-enable a new feature that is
> _known_ to not work properly on recent userspace?  That makes no sense
> to me.

I agree. It's a great feature, but it shouldn't be default y if 
userspace isn't ready for it yet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
