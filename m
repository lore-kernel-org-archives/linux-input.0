From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Logitech Spring FF (effect on/off)
Date: Wed, 11 Apr 2007 06:01:56 +0300
Message-ID: <461C4FA4.5070105@gmail.com>
References: <461117A0.80905@cs.utexas.edu> <4615D762.4090206@it.uu.se>	 <4616DC56.80301@cs.utexas.edu>	 <38b3b7c0704070016m27deaa18hf818d21a080c7ba6@mail.gmail.com>	 <4617B392.4010704@gmail.com> <461B2496.8010304@cs.utexas.edu> <38b3b7c0704100251v485d6fdu1ff8e2524a4f023b@mail.gmail.com> <461C4E24.9060408@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <461C4E24.9060408@cs.utexas.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Bolkey <rbolkey@cs.utexas.edu>
Cc: johann deneux <johann.deneux@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Richard Bolkey kirjoitti:
> Alright, I can turn the spring effect on; however, I can't turn it off 
> right now.  There is a separate report that needs to be sent to turn off 
> the spring effect for each axis.  I can't see an obvious place to put 
> that kind of functionality into the framework of ff-memless.  I'm 
> wondering if this means my device isn't "memoryless"?  Any advice?

For the FF_RUMBLE and FF_CONSTANT effects, if I remember correctly, 
ff-memless sends a zero-magnitude effect to the device driver when the 
effect is supposed to be turned off. You can do it similarly for the 
spring effect.

-- 
Anssi Hannula
