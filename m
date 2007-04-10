From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Logitech Spring FF
Date: Tue, 10 Apr 2007 02:31:24 -0400
Message-ID: <200704100231.25295.dtor@insightbb.com>
References: <461117A0.80905@cs.utexas.edu> <4617B392.4010704@gmail.com> <461B2496.8010304@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <461B2496.8010304@cs.utexas.edu>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Bolkey <rbolkey@cs.utexas.edu>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Anssi Hannula <anssi.hannula@gmail.com>, johann deneux <johann.deneux@gmail.com>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Tuesday 10 April 2007 01:45, Richard Bolkey wrote:
> First off, I've never made a patch before, which I guess I better learn, 
> but for now if anyone wants to add the device_type for the Logitech 
> Force 3D Pro Joystick to hid-lgff.c, it's { 0x046d, 0xc286, ff_joystick }.
>

That would be Jiri Kosina (CCed).
 
> Now for a few follow up questions (this is a whole lot of new stuff, so 
> bear with me).
> 
> 1) I'm gathering that Logitech keeps their hid reports secret and 
> non-standard, or else I'd just be using the HID PID driver?  So, were 
> the values in the reports found in hid_lgff_play discovered through 
> trial and error?  How would I find what the report for FF_SPRING should 
> look like?
> 
> 2) Previous question assumes that is where I should implement the effect 
> since ml->play_effect is referencing that function in ff_memless.c.  But 
> it sounded like Anssi was recommending doing a spring->constant 
> conversion akin to what looks like a periodic->rumble conversion in 
> ml_combine_effects?
> 
> Thanks,
> Rick
> 

-- 
Dmitry
