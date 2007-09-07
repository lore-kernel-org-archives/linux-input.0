From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] fujtisu application panel driver
Date: Fri, 7 Sep 2007 12:02:20 +0000
Message-ID: <20070907120220.GB3901@ucw.cz>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net> <d120d5000707021216y1a3641b1rbc0c741e2d7d4e70@mail.gmail.com> <20070903095847.72245af4@oldman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070903095847.72245af4@oldman>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> > Thank you very much for updating the patch. I have a couple of requests though:
> > 
> > 1. LEDs shoud use the generic led subsystem instead of input layer. I
> > do not have plans of adding any more LED_XXX constants and I think
> > that adding any LEDs not directly relating to keyboard state was a
> > mistake.
> 
> No, way to much work for one stinking LED.

'Lets do it wrong way because right way is too much work'?

Come on... doing let driver is 30 minutes and 100-or-so lines of code.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
