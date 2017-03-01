From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 01 Mar 2017 12:46:22 -0800
Message-ID: <1488401182.20731.11.camel@perches.com>
References: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
         <20170301181628.GD30349@dtor-ws>
         <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avraham Shukron <avraham.shukron@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2017-03-01 at 21:59 +0200, Avraham Shukron wrote:
> > 
> > This kind of change is definitely not helpful. The original table was
> > Nx16, you converted it to Nx14. Why do you think original table used 16
> > columns?
> > 
> > Regardless, it's a very old driver, just let it be.
> > 
> > Thanks.
> > 
> 
> I can make it Nx8 :)
> 
> Seriously now - I don't understand what is so wrong with checkpatch fixes?

Some say is makes following logical changes more difficult.
git blame, etc...  I'm not a big adherent of that though.

> I'm a new to kernel development, and the natural place to start is to do some
> coding style fixes.
> I thought fixing a driver that I actually use daily will be more satisfying.
> Why driver being old is a good reason to ignore the coding style conventions?

The space after comma rule _should_ be broken when
alignment is more obvious.  The existing code is just fine.

Conventions are just that.  It's OK to be unconventional.

It's better to know when to follow and when not to follow
those conventions.

checkpatch messages should be considered guides and not
dicta that must be followed to the last letter.

To me, the rest of the patch was OK though.

If you want to learn the kernel patch process, modifying files
in drivers/staging is a good place to start.

Otherwise, it's probably best to find/fix some actual defect
and suggest actual logical changes that reduce code size,
improve performance, expand test coverage, better document
the code, etc..

cheers, Joe
