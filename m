From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] input: extend EV_LED
Date: Thu, 15 Feb 2007 23:36:04 +0000
Message-ID: <1171582564.5839.44.camel@localhost.localdomain>
References: <freemail.20070115234756.58787@fm13.freemail.hu>
	 <1171580944.5839.38.camel@localhost.localdomain>
	 <20070215232438.GB4176@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070215232438.GB4176@elf.ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@ucw.cz>
Cc: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2007-02-16 at 00:24 +0100, Pavel Machek wrote:
> > The led framework is generic. If you can write a function to turn it
> > on/off you can drive it with the LED framework.
> 
> Even if that function is slow and sleeps?

The LED class itself can call in interrupt context so you'd have to
schedule a workqueue if you need to sleep.

> > One way I've come up with is adds capability to the class to have LED
> > specific triggers and you can then expose these hardware capabilities as
> > an extra trigger specific to the LED.
> > 
> > Another proposal more specific to this use case was to have some
> > information behind the scenes which the software timer based trigger
> > could use to turn on the "hardware acceleration" if present and capable
> > of the requested mode. This might just need a function pointer in the
> > core so could be quite neat.
> 
> I do not think we want to permit this led to run in "not accelerated"
> mode. I believe i8042 accesses are pretty expensive.

Which means they probably won't work well with the standard triggers.
Not something we can do much about though...

> > Nether patch exists yet.
> 
> Yep, interested party should create one of them :-). (And I'd prefer
> the first one, due to i8042 slowness).

Right, patches welcome :)

Cheers,

Richard
