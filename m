From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - use %ph to form F34
 configuration ID
Date: Tue, 30 May 2017 10:23:54 -0700
Message-ID: <1496165034.2618.26.camel@perches.com>
References: <20170530044944.GA33451@dtor-ws>
         <20170530082358.GB1293@mail.corp.redhat.com>
         <20170530165913.GD12922@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530165913.GD12922@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2017-05-30 at 09:59 -0700, Dmitry Torokhov wrote:
> On Tue, May 30, 2017 at 10:23:58AM +0200, Benjamin Tissoires wrote:
> > On May 29 2017 or thereabouts, Dmitry Torokhov wrote:
> > > Instead of printing bytes one by one, let's use %phN to print the buffer in
> > > one go.
> > > 
> > > Also use hweight8 to count number of partitions instead of inspecting it
> > > bit by bit.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > 
> > Looks good to me:
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Hm, I just realized taht we'd go from upper to lowercase hex digits. I
> think it should be OK, but I'd like to hear interested parties (Nick).
> 
> Or we'd need to introduce %pH I guess.

As it's debugging output, I'd hazard to guess it doesn't matter.

If someone _really_ needs upper-case output in *ph, I'd also
suggest adding another qualifier to keep the number of letter
prefixes used down.  %ph[CDNU].

A pity that %ph[cdnCDN] isn't possible as that's the style used
by %pU[blBL] for lower/upper case output.

There are < 80 uses of %[\*\d]+ph[CDN], maybe it'd be reasonable
to do a treewide sed to lowercase for them.  Dunno.
