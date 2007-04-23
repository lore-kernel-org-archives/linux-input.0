From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Mon, 23 Apr 2007 15:13:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231508490.5138@jikos.suse.cz>
References: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
 <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>  <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-input@vger.kernel.org

On Mon, 23 Apr 2007, Barton C Massey wrote:

> I just tried out the Bluetooth MM with 2.6.20.4 plus the bluez patches.  
> Everything seemed to work fine.  (Actually, it was horribly slow and 
> laggy, but all the buttons and knobs worked and made things go in the 
> right directions and stuff.  I'm hoping my USB BT dongle just sucks.)  
> I don't know if 2.6.21-rc6 is flipped from 2.6.20.4, though :-). I'll 
> try to grab a newer kernel eventually.

This is strange, I have a bugreport in our bugzilla which states that BT 
version of the mightymouse needs the very same quirk as USB version. 
Recent kernels contain a duplication of the USB quirk for Bluetooth 
version of the mouse, in order to make the scrollwheel work. But 
2.6.20.4+bluez patches don't provide this quirk yet.

What product/vendor ids does your mightymouse have?

Thanks,

-- 
Jiri Kosina
