From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/1] Input: inline macros for MODULE_LICENSE, etc
Date: Tue, 26 Dec 2017 19:10:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1712261906440.5715@hadrien>
References: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr> <1514311471.3468.8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514311471.3468.8.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org



On Tue, 26 Dec 2017, Joe Perches wrote:

> On Tue, 2017-12-26 at 18:05 +0100, Julia Lawall wrote:
> > Inline macro for MODULE_LICENSE to make the license information easy to
> > find, eg with grep.  Inline the other module-related macros at the same
> > time.
>
> Perhaps it'd be better to not make this
> dependent on a MODULE_LICENSE use, but allow
> any #define foo/#define MODULE_<FOO> foo
> where foo is used once to be converted.

Well, I wanted something that could be checked in a finite (small) amount
of time...  There seemed to be a slightly more compelling argument for
inlining the license, so I decided to focus on that.  What you suggested
resulted in around 5000 lines of patch code, mostly inlining authors and
descriptions.

But maybe you have already done the things done in my patch and it hasn't
been picked up yet?

julia
