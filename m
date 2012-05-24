From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Fri, 25 May 2012 06:26:55 +0900
Message-ID: <20120524212655.GA16113@kroah.com>
References: <20120524083216.GD10562@core.coreip.homeip.net>
 <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 24, 2012 at 10:33:49AM -0700, Linus Torvalds wrote:
> On Thu, May 24, 2012 at 1:32 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Linus,
> >
> > to receive updates for the input subsystem. You will get:
> 
> I get an annoying conflict, and the reason I call it annoying is not
> because it's hard to resolve, it's because doing that shows that you
> seem to have preferred using
> 
>    dev_dbg(&input->dev.parent, ...)
> 
> over the much more natural
> 
>    dev_dbg(&input->dev, ...)
> 
> which would seem to make more sense.
> 
> Why? Are the input layer device names so bad that using them for debug
> output is useless? And if so, why *are* they so bad?
> 
> I'm going to take your version over Greg's more straightforward one,
> because I assume Greg did things a bit more mindlessly and I think you
> presumably had a *reason* for your extra (stupid) ".parent" part. But
> I'm unhappy with it, because I suspect the reason you did that implies
> that the input layer does something bad.

I reworked these patches 3 different times, they were anything but
"mindless" (well, maybe the first ones were...)  Dmitry and I seem to
disagree on showing useful names to the users, but as he is the one who
needs to handle user issues when they report things, I'll defer to his
version of the changes.

thanks,

greg k-h
