From: Joe Perches <joe@perches.com>
Subject: Re: Input-gameport: Add the macro "pr_fmt" for module "joydump"
Date: Sat, 24 Sep 2016 11:01:03 -0700
Message-ID: <1474740063.23838.18.camel@perches.com>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
         <3345f7c1-b823-a819-aabf-5b4990068075@users.sourceforge.net>
         <20160924164108.GB40187@dtor-ws>
         <a9d9e2fc-4369-ba1a-e1a1-97b0873c28ce@users.sourceforge.net>
         <1474736592.23838.8.camel@perches.com>
         <40016728-7a21-df83-f6a3-d936c928ed30@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40016728-7a21-df83-f6a3-d936c928ed30@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sat, 2016-09-24 at 19:45 +0200, SF Markus Elfring wrote:
> > It's purposeless, creates unnecessary patches to review
> > and generally wastes other people's time.
> I have got an other opinion about this.

Nice for you, not nice for others that have to act on
your patch proposals to get them forwarded upstream.

> > Please don't purposefully waste other people's time.
> I do not want to "waste" your time.

When a chorus of voices says to you that you are wasting
their time, perhaps you listen to their song.

> > It makes your patch proposals _less_ likely to be applied.
> The acceptance varies as usual.

Usual for whom?

It seems to me your patch proposals have a relatively high
unapplied patch percentage and there is an increase in the
number of upstream maintainers that ignore you.

> I see also another option.
> 
> * Can the first three update steps from this small patch series be integrated
>   while the fourth needs further adjustments (where I went a bit too far)?
> 
> * Do you prefer to squash the last two update steps together?

Yes, the overall number of patches should be minimized when
the suggested patches are highly related.
