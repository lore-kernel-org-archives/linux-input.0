From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Fri, 13 Apr 2007 09:43:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
References: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Apr 2007, Barton C Massey wrote:

> These results are for the USB MM.  I have a Bluetooth MM now, and am 
> trying to find time to get it working also. Sorry I haven't had time to 
> do that yet.  Soon, honest.

Bart,

thanks for the information.

Regarding the Bluetooth mouse - I have a bug in bugzilla stating that the 
Bluetooth version of the mightymouse requires the very same quirky 
handling as the USB version. Now that bluetooth and USB are hooked to the 
same common HID layer, this is pretty easy thing to do.

Mainline kernel already contains the quirk for Bluetooth mouse, since 
2.6.21-rc6. It would be nice if you could verify that the Bluetooth 
version works fine with this kernel (or any newer).

Thanks,

-- 
Jiri Kosina
SUSE Labs
