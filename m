From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Thu, 24 May 2012 10:33:49 -0700
Message-ID: <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
References: <20120524083216.GD10562@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120524083216.GD10562@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 24, 2012 at 1:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Linus,
>
> to receive updates for the input subsystem. You will get:

I get an annoying conflict, and the reason I call it annoying is not
because it's hard to resolve, it's because doing that shows that you
seem to have preferred using

   dev_dbg(&input->dev.parent, ...)

over the much more natural

   dev_dbg(&input->dev, ...)

which would seem to make more sense.

Why? Are the input layer device names so bad that using them for debug
output is useless? And if so, why *are* they so bad?

I'm going to take your version over Greg's more straightforward one,
because I assume Greg did things a bit more mindlessly and I think you
presumably had a *reason* for your extra (stupid) ".parent" part. But
I'm unhappy with it, because I suspect the reason you did that implies
that the input layer does something bad.

Hmm?

                     Linus
