From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Logitech Spring FF
Date: Sat, 07 Apr 2007 18:06:58 +0300
Message-ID: <4617B392.4010704@gmail.com>
References: <461117A0.80905@cs.utexas.edu> <4615D762.4090206@it.uu.se>	 <4616DC56.80301@cs.utexas.edu> <38b3b7c0704070016m27deaa18hf818d21a080c7ba6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0704070016m27deaa18hf818d21a080c7ba6@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Richard Bolkey <rbolkey@cs.utexas.edu>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

johann deneux wrote:
> I'm forwarding this mail to linux-input, that's a better place for
> this discussion.
> Richard is working on adding support for spring force feedback effects
> to the hid-lgff driver.
> 
> On 4/7/07, Richard Bolkey <rbolkey@cs.utexas.edu> wrote:
>> johann deneux wrote:
>> > Yes. It's possible to implement everything using a constant force
>> > effect updated at regular intervals.
>> > Are you working to extending the driver in the kernel, or are you
>> > doing the work in user-space?
>> Working off the driver in the kernel.  Can/should I do this in user
>> space?  I also noticed with the latest kernels there is a ff-memless.c.
> 
> I'm not sure. Doing in the kernel would allow for a shorter update
> cycle, I think. I had initially intended to do what you are doing in
> the kernel, but I never actually finished the task.

The correct way to implement this is to do it in ff-memless.c, and it
already has the framework to do effect conversions.

> One of the problem I remember encountering was related to computing
> sine values when simulating a periodic effect. Is there a math lib
> available in the kernel?

There is your fixp-arith.h in /drivers/input and apparently some random
math functions in /lib.

(and I think the fixp-arith.h should really be in /lib as well)

>> Is that an attempt to do all effect calculations in a single module, and
>> a driver like hid-lgff.c would just need to do the device recognitions?
> 
> I guess so, but you should check with the author.
> 

Yes, it is.


-- 
Anssi Hannula
