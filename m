From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Mon, 23 Apr 2007 16:07:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231555570.5138@jikos.suse.cz>
References: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
 <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>  <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
  <Pine.LNX.4.64.0704231508490.5138@jikos.suse.cz> <1177335818.3528.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1177335818.3528.8.camel@johannes.berg>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Barton C Massey <bart@cs.pdx.edu>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
List-Id: linux-input@vger.kernel.org

On Mon, 23 Apr 2007, Johannes Berg wrote:

> > This is strange, I have a bugreport in our bugzilla which states that 
> > BT version of the mightymouse needs the very same quirk as USB 
> > version. Recent kernels contain a duplication of the USB quirk for 
> > Bluetooth version of the mouse, in order to make the scrollwheel work. 
> > But 2.6.20.4+bluez patches don't provide this quirk yet.
> Same problem I had maybe with X or GTK or something flipping the axis?

Hi Johannes,

no, that's not the case, the bugreport states that scrolling the wheel 
produces no input events at all, i.e. mapping of HID_GD_Z to REL_HWHEEL 
(HID_QUIRK_MIGHTYMOUSE quirk) is needed.

-- 
Jiri Kosina
