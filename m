From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Fri, 1 Jun 2007 14:13:24 +0100
Message-ID: <20070601131324.GB12204@srcf.ucam.org>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705312333.11477.dtor@insightbb.com> <20070601040824.GA5042@srcf.ucam.org> <200706010037.59496.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200706010037.59496.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 01, 2007 at 12:37:58AM -0400, Dmitry Torokhov wrote:
> On Friday 01 June 2007 00:08, Matthew Garrett wrote:
> > If you let users alter the kernel keymap, then you need to implement 
> > support for resetting the kernel keymap on exit. Otherwise it's a 
> > trivial DoS.
> > 
> 
> You already do - do you let your users play games with force-feedback
> joysticks? To load force feedback effect you need write permissions for
> corresponding event device.

That's much less of a problem, especially since (realistically) any 
force feedback-aware application will reset the values on first use. 
That's not the case for the keymap.

> > The standard setup in an office environment is likely to be  
> > multiuser.
> 
> Huh? In my limited experience everyone in the office gets its own box.
> And I am not talking about software shop.

Standard is that everyone gets their own machine, but usually everyone 
has an account on all of them.

> > No, but it makes it significantly more confusing. User 1 chooses a 
> > setup. This gets saved. User 2 remaps keys based on User 1's settings 
> > (which have been restored at bootup). User 1 alters key mapping. User 2 
> > suddenly becomes hugely confused.
> 
> One user is an administrator. He can alter the global keymap. If there
> are multiple users he may need to be cautious.

Or we could just leave the mapping up to individual users, which avoids 
the problem.

> > How many users plug external keyboards with unlabelled keys into a 
> > laptop? No, I really don't think that's a common case at all.
> 
> I think quite a few people use external keyboards. I know that in my office
> everyone with a laptop has a docking station and uses full keyboard with
> it. I use external AT keyboard at home...
> 
> As far as unlabeled goes - they may be labeled but we may not know their
> labels.

If a key is labelled in a non-generic way then it shouldn't generate 
KEY_PROGwhatever. That's a separate problem.

> > The solution that satisfies the largest number of users with the 
> > smallest amount of work is the one where pressing a key on the keyboard 
> > results in X events being generated. Right now, that requires that the 
> > key generate a real keycode.
> > 
> 
> Again, it is not only about X. What if X is not running (or running but
> nobody is logged in)? There are number of events (SUSPEND, WLAN switch,
> undock request, etc) that should be handled by daemons not depending
> on X.

The existing implementations use X. I don't think any of the desktop 
distributions really care about the non-X case for this sort of thing.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
