From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: Logitech Spring FF
Date: Tue, 10 Apr 2007 14:21:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704101420010.31796@twin.jikos.cz>
References: <461117A0.80905@cs.utexas.edu> <4615D762.4090206@it.uu.se>
 <4616DC56.80301@cs.utexas.edu> <38b3b7c0704070016m27deaa18hf818d21a080c7ba6@mail.gmail.com>
 <4617B392.4010704@gmail.com> <461B2496.8010304@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <461B2496.8010304@cs.utexas.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Bolkey <rbolkey@cs.utexas.edu>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, johann deneux <johann.deneux@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 10 Apr 2007, Richard Bolkey wrote:

> First off, I've never made a patch before, which I guess I better learn, but
> for now if anyone wants to add the device_type for the Logitech Force 3D Pro
> Joystick to hid-lgff.c, it's { 0x046d, 0xc286, ff_joystick }.

Queued support for 0x046d/0xc286 in my tree for upstream. Thanks.

> 1) I'm gathering that Logitech keeps their hid reports secret and 
>    non-standard, or else I'd just be using the HID PID driver?  So, were 
>    the values in the reports found in hid_lgff_play discovered through 
>    trial and error?  How would I find what the report for FF_SPRING 
>    should look like?

You can monitor how other already existing drivers behave, and try to 
simulate the behavior in your driver.

-- 
Jiri Kosina
