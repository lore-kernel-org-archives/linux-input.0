From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] IR: ene_ir: few bugfixes
Date: Fri, 15 Oct 2010 22:24:55 +0200
Message-ID: <1287174295.1867.1.camel@MAIN>
References: <1287158799-21486-1-git-send-email-maximlevitsky@gmail.com>
	<1287158799-21486-4-git-send-email-maximlevitsky@gmail.com>
	<20101015200212.GK9658@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101015200212.GK9658-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=lirc-list>
List-Post: <mailto:lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 2010-10-15 at 16:02 -0400, Jarod Wilson wrote:
> On Fri, Oct 15, 2010 at 06:06:37PM +0200, Maxim Levitsky wrote:
> > This is a result of last round of debug with
> > Sami R <maesesami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.
> > 
> > Thank you Sami very much!
> > 
> > The biggest bug I fixed is that,
> > I was clobbering the CIRCFG register after it is setup
> > That wasn't a good idea really
> > 
> > And some small refactoring, etc.
> > 
> > Signed-off-by: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/media/IR/ene_ir.c |   43 ++++++++++++++++++++-----------------------
> >  1 files changed, 20 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/media/IR/ene_ir.c b/drivers/media/IR/ene_ir.c
> > index dc32509..8639621 100644
> > --- a/drivers/media/IR/ene_ir.c
> > +++ b/drivers/media/IR/ene_ir.c
> ...
> > @@ -282,6 +287,7 @@ static void ene_rx_setup(struct ene_device *dev)
> >  		ene_set_reg_mask(dev, ENE_CIRCFG, ENE_CIRCFG_CARR_DEMOD);
> >  
> >  		/* Enable carrier detection */
> > +		ene_write_reg(dev, ENE_CIRCAR_PULS, 0x63);
> 
> Looks sane, though I'd prefer to see symbolic bit names or some such thing
> here instead of 0x63. Not something to hold up the patch though.
> 
> Acked-by: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
63 isn't a bitfileld, but rather two numbers.
3 is number of carrier pulses to skip, and 6 is number of carrier pulses
to average.

I have a note about that in header.

Best regards,
	Maxim Levitsky


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
