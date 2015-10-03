From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/3] Input: db9 - store object at correct index
Date: Sat, 3 Oct 2015 11:14:28 +0530
Message-ID: <20151003054428.GB4428@sudip-pc>
References: <1443785315-31495-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151002181118.GI8437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36775 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbbJCFoe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Oct 2015 01:44:34 -0400
Content-Disposition: inline
In-Reply-To: <20151002181118.GI8437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 11:11:18AM -0700, Dmitry Torokhov wrote:
> Hi Sudip,
> 
> On Fri, Oct 02, 2015 at 04:58:33PM +0530, Sudip Mukherjee wrote:
> > The variable i is used to check the port to attach to and we are
> > supposed to save the reference of struct db9 in the location given by
> > db9_base[i]. But after finding out the index i is getting modified again
> > so we saved in a wrong index.
> > 
> > Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  drivers/input/joystick/db9.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> > index cf1f602..f6ecd4a 100644
> > --- a/drivers/input/joystick/db9.c
> > +++ b/drivers/input/joystick/db9.c
> > @@ -560,7 +560,7 @@ static void db9_attach(struct parport *pp)
> >  	const struct db9_mode_data *db9_mode;
> >  	struct pardevice *pd;
> >  	struct input_dev *input_dev;
> > -	int i, j;
> > +	int i, j, k;
> >  	int mode;
> >  	struct pardev_cb db9_parport_cb;
> >  
> > @@ -577,6 +577,7 @@ static void db9_attach(struct parport *pp)
> >  		pr_debug("Not using parport%d.\n", pp->number);
> >  		return;
> >  	}
> > +	k = i;
> 
> Hmm, I'd prefer we did not reuse 'i' at all. Can we instead of 'k' add
> 'port_idx' and use it instead of 'i' in the first loop?
Yes, that will be great. This reuse of i caused this mistake. Sorry
about that I should have been more carefull.

regards
sudip
