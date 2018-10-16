From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Tue, 16 Oct 2018 11:44:34 +0200
Message-ID: <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
         <20181015195612.GB29649@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015195612.GB29649@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Pavel,

On Mon, 2018-10-15 at 21:56 +0200, Pavel Machek wrote:
> Hi!
> 
> > This makes keyboard/touchpad work on a DT MMP2 platform.
> > 
> > I believe that it would be a good idea if this, once reviewed, went
> > in
> > via the input tree. The DT and CLK parts got reviews/acks.
> > 
> > Changes from v1:
> > - Basically none, just re-send, including Ack and Review tags in
> > patches
> >   that received them. Plus an extra Cc.
> >   I'd be very thankful for reviews.
> 
> Ok, I believe I have OLPC 1.75, and it is actually a nice
> machine. Can I get recent kernel working there in useful fashion? (Is
> there docs somewhere)?

A lovely machine indeed. I've written this now:

https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75

I didn't test it yet -- will do when I get home in the evening. But
chances are it's good enough and I guess you'd be able to get it
working even if I messed up some details.

Please let me know if it works for you -- I'm having trouble getting
reviews/acks/tested-bys for the XO-1.75 patch sets [1] and will be
super thankful if I get some feedback from you.

[1] https://lore.kernel.org/patchwork/bundle/lkundrak/OLPC%20XO%201.75/

> 
> Thanks,
> 									
> Pavel

Cheers,
Lubo
