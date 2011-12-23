From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH 1/1] input: sentelic: Releasing mutex upon register
 writing failure
Date: Fri, 23 Dec 2011 09:08:26 +0800 (CST)
Message-ID: <11122309072018.21736@cnaqrzbavhz.fragryvp.pbz>
References: <1324019274-15508-1-git-send-email-avatar@sentelic.com>
 <20111222175206.GD21103@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:9223 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab1LWBIf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Dec 2011 20:08:35 -0500
In-Reply-To: <20111222175206.GD21103@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Paul Fox <pgf@laptop.org>

On Thu, 22 Dec 2011, Dmitry Torokhov wrote:
> Hi Tai-hwa,
> 
> On Fri, Dec 16, 2011 at 03:07:54PM +0800, Tai-hwa Liang wrote:
> > Making sure that mutex is released upon register writing failure.
> > This fixes boot freezing observed on ARM based OLPC
> > (http://dev.laptop.org/ticket/11357).
> > 
> > Signed-off-by: Paul Fox <pgf@laptop.org>
> > Acked-by: Tai-hwa Liang <avatar@sentelic.com>
> 
> Since you are actually passing the patch to me there should be your
> "Signed-off-by:.. " instead of (or in addtion to) your "Acked-by".
> 
> Thanks!

   Sure.  Thank you.

Signed-off-by:	Tai-hwa Liang <avatar@sentelic.com>

> 
> > ---
> >  drivers/input/mouse/sentelic.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> > index 5babc47..7e96a5d 100644
> > --- a/drivers/input/mouse/sentelic.c
> > +++ b/drivers/input/mouse/sentelic.c
> > @@ -162,7 +162,7 @@ static int fsp_reg_write(struct psmouse *psmouse, int reg_addr, int reg_val)
> >  	ps2_sendbyte(ps2dev, v, FSP_CMD_TIMEOUT2);
> > 
> >  	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> > -		return -1;
> > +		goto out;
> > 
> >  	if ((v = fsp_test_invert_cmd(reg_val)) != reg_val) {
> >  		/* inversion is required */
> > @@ -261,7 +261,7 @@ static int fsp_page_reg_write(struct psmouse *psmouse, int reg_val)
> >  	ps2_sendbyte(ps2dev, 0x88, FSP_CMD_TIMEOUT2);
> > 
> >  	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
> > -		return -1;
> > +		goto out;
> > 
> >  	if ((v = fsp_test_invert_cmd(reg_val)) != reg_val) {
> >  		ps2_sendbyte(ps2dev, 0x47, FSP_CMD_TIMEOUT2);
> > -- 
> > 1.7.7.3
