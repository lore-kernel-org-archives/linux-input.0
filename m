From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 15:55:18 +0100
Message-ID: <20111116145518.GA7080@slate>
References: <20111116095030.GC3335@slate>
 <CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
 <20111116102514.GA3831@slate>
 <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:52834 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754872Ab1KPOzl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 09:55:41 -0500
Content-Disposition: inline
In-Reply-To: <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 07:41:04AM -0600, Chris Bagwell wrote:
> And a little extra info.  Cedric tested the patch that is now in
> Jiri's upstream-fixes branch for this new 0xa0001 and got success so I
> sent in patch.  After several days, he tested closer and realized it
> was getting X/Y movement and what I'll call unpredictable Touch
> behaviour.  It would either act like a stylus hovering but never
> touching or it would always act like touching and never release.
> 
> Events are working and you can test with evtest.  I've verified at
> least one test stream he emailed that it is not correctly sending
> BTN_TOUCH but it is sending good X/Y using MT and pointer emulation
> events.
> 
> It would probably be easy to see the issue if debug/hid/*/events were
> being displayed but for some reason "cat rdesc" outputs stuff but "cat
> events" does not.  I couldn't come up with more ideas remotely.
> 
> The redesc shows it reports ContactID's range of 0-16 and features
> says only 10 touches max (seen in above paste link).  So my last guess
> is that we may be using the wrong quirk for this one since it sounds
> like ContactID is not 1-to-1 with touches.  Hard to tell without
> sample events though.
> 
> Chris

Chris, it might interest you that the event node now fires and outputs
events, when letting hid-multitouch handle the device through Benjamin's
patch (Writing "3 0eef a001 1" to new_id).

I think when adding the MULTITOUCH5 in the source in the exact same
manner MULTITOUCH[1-4] are added I must have copied some quirks which
interfere with the event node. Now, adding the device by Benjamin's way
does not load any quirks by default, so the event node works.

Either Benjamin or I will tell you more once we discovered something
definite.

regards,
Cedric
