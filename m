From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] input: Clean up maple keyboard driver
Date: Sat, 19 Jul 2008 13:17:59 +0100
Message-ID: <1216469879.8959.0.camel@localhost.localdomain>
References: <1213559019.22707.12.camel@localhost.localdomain>
	 <20080718224323.GA19263@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080718224323.GA19263@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, 2008-07-19 at 07:43 +0900, Paul Mundt wrote:
> On Sun, Jun 15, 2008 at 08:43:39PM +0100, Adrian McMenamin wrote:
> > Have a single probe function instead of a probe and a connect function.
> > Also tidy a comment.
> > 1 files changed, 33 insertions(+), 48 deletions(-)
> > 
> > 
> > Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
> Ok, so I was going to take this through my tree, but it doesn't apply any
> more. Please send an updated version that can be merged.

What is the problem? Is it just a badly formed patch or has something
changed elsewhere?

I'll have a look but as I have no issues I'm not sure what is wrong.

