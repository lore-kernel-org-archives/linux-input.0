From: Barton C Massey <bart@cs.pdx.edu>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Mon, 23 Apr 2007 03:27:05 -0700
Message-ID: <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
References: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
	<200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: Your message of "Fri, 13 Apr 2007 09:43:44 +0200."
	<Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-input@vger.kernel.org

In message <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz> you wrote:
> On Thu, 12 Apr 2007, Barton C Massey wrote:
> 
> > These results are for the USB MM.  I have a Bluetooth MM now, and am 
> > trying to find time to get it working also. Sorry I haven't had time to 
> > do that yet.  Soon, honest.
> 
> Regarding the Bluetooth mouse - I have a bug in bugzilla stating that the 
> Bluetooth version of the mightymouse requires the very same quirky 
> handling as the USB version. Now that bluetooth and USB are hooked to the 
> same common HID layer, this is pretty easy thing to do.
> 
> Mainline kernel already contains the quirk for Bluetooth mouse, since 
> 2.6.21-rc6. It would be nice if you could verify that the Bluetooth 
> version works fine with this kernel (or any newer).

I just tried out the Bluetooth MM with 2.6.20.4 plus the
bluez patches.  Everything seemed to work fine.  (Actually,
it was horribly slow and laggy, but all the buttons and
knobs worked and made things go in the right directions and
stuff.  I'm hoping my USB BT dongle just sucks.)  I don't
know if 2.6.21-rc6 is flipped from 2.6.20.4, though :-).
I'll try to grab a newer kernel eventually.

	Bart
