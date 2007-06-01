From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Fri, 1 Jun 2007 00:37:58 -0400
Message-ID: <200706010037.59496.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705312333.11477.dtor@insightbb.com> <20070601040824.GA5042@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070601040824.GA5042@srcf.ucam.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday 01 June 2007 00:08, Matthew Garrett wrote:
> On Thu, May 31, 2007 at 11:33:10PM -0400, Dmitry Torokhov wrote:
> > On Thursday 31 May 2007 21:44, Matthew Garrett wrote:
> > > It's not trivial at all. You need to introduce a mechanism for noting a 
> > > KEY_UNKNOWN keypress. It then needs to signal the user (dbus is probably 
> > > the best layer for this), but you need to ensure that you only signal 
> > > the user who is currently at the keyboard. This needs to be presented to 
> > > the user via some sort of UI, which will then need to signal some sort 
> > > of privileged process to actually change the keymap.
> > 
> > Not necessarily priveleged - you most likely already change ownership
> > of event devices to user who is logged at console (so your force feedback
> > joysticks work).
> 
> If you let users alter the kernel keymap, then you need to implement 
> support for resetting the kernel keymap on exit. Otherwise it's a 
> trivial DoS.
> 

You already do - do you let your users play games with force-feedback
joysticks? To load force feedback effect you need write permissions for
corresponding event device.

And we are talking about console owner here - with current desktop-oriented
distributions they already get access to host of otherwise restricted
devices.

> > > When the user logs  
> > > out, you'll then need to unmap the key again and repeat as necessary for 
> > > any new user who logs in.
> > 
> > I think we should aim at the most common case - when there are no multiple
> > users on the box. Then the utility that detects KEY_UNKNOWN just saves the
> > mapping user chose and automatically reload keymap upon next reboot.
> 
> The standard setup for home machines tends to be an account per family 
> member.

That could be... Although it is desktops that are usually shared.
Hmm, I am trying to remember setup of the people I know... I think
the most common setup is a desktop in an easily accessible place
(kitchen) with a single account. Older kids/parents may have their
own desktop/laptops that are not shared.

> The standard setup in an office environment is likely to be  
> multiuser.

Huh? In my limited experience everyone in the office gets its own box.
And I am not talking about software shop.

> 
> > Note that KEY_UNKNOWN solution does not preculde futher customization on
> > per-user base once default action is established.
> 
> No, but it makes it significantly more confusing. User 1 chooses a 
> setup. This gets saved. User 2 remaps keys based on User 1's settings 
> (which have been restored at bootup). User 1 alters key mapping. User 2 
> suddenly becomes hugely confused.

One user is an administrator. He can alter the global keymap. If there
are multiple users he may need to be cautious.
 
> > > 
> > > Alternatively, we could generate a keycode and then let the user map 
> > > that to an X keysym. We've even already got code to do this.
> > >
> > 
> > There is world outside of X.
> 
> On machines like we're discussing (laptops, basically) it's a tiny 
> world. Optimise for the common case, not the rare one.
> 
> > > That's a ridiculously niche case, and can be handled in userspace. Just 
> > > have udev do remapping when it detects multiple keyboards that both have 
> > > KEY_PROG* layers, or let X have different keymaps for different input 
> > > devices. We shouldn't make the (by far) common case significantly more 
> > > difficult to deal with this one.
> > > 
> > 
> > No, it is not a niche case. I think it is much more common than the case where
> > you have multiple users for the same box using different keymaps. Even if box
> > is shared there most likely will be one person setting it up in the beginning
> > and the rest will follow his/her setup.
> 
> How many users plug external keyboards with unlabelled keys into a 
> laptop? No, I really don't think that's a common case at all.

I think quite a few people use external keyboards. I know that in my office
everyone with a laptop has a docking station and uses full keyboard with
it. I use external AT keyboard at home...

As far as unlabeled goes - they may be labeled but we may not know their
labels.

> The solution that satisfies the largest number of users with the 
> smallest amount of work is the one where pressing a key on the keyboard 
> results in X events being generated. Right now, that requires that the 
> key generate a real keycode.
> 

Again, it is not only about X. What if X is not running (or running but
nobody is logged in)? There are number of events (SUSPEND, WLAN switch,
undock request, etc) that should be handled by daemons not depending
on X.

-- 
Dmitry
