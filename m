From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] input: extend EV_LED
Date: Thu, 15 Feb 2007 17:40:10 +0000
Message-ID: <20070215174009.GA6535@ucw.cz>
References: <d120d5000702121031o1ea5ff20lf4e0946c8c1e2980@mail.gmail.com> <freemail.20070114200635.96983@fm13.freemail.hu> <d120d5000702141149g772840e7h87e4362b3f380bc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000702141149g772840e7h87e4362b3f380bc0@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> >I do not know the LED subsystem in detail, but I do not 
> >know
> >any possibility to access the i8042 from different 
> >subsystem
> >than the input subsystem.
> >
> >What do you think and recommend?
> 
> I think you need to use leds framework for what you are 
> trying to do.

I'm actually not sure if led framework can do that. It was designed
for leds on gpios, and handles blinking itself.

But he could export two leds :-).

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
