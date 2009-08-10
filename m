From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3] input: PCAP2 misc input driver
Date: Mon, 10 Aug 2009 20:23:15 +0200
Message-ID: <20090810182314.GB9547@sortiz.org>
References: <1249678456-15381-1-git-send-email-drwyrm@gmail.com> <20090810072431.D2068526EC9@mailhub.coreip.homeip.net> <20090810111300.6c9abe57.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52590 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbZHJSVS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 14:21:18 -0400
Content-Disposition: inline
In-Reply-To: <20090810111300.6c9abe57.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, openezx-devel@lists.openezx.org, Ilya Petrov <ilya.muromec@gmail.com>

Hi Antonio,

On Mon, Aug 10, 2009 at 11:13:00AM +0200, Antonio Ospite wrote:
> On Sun, 9 Aug 2009 23:54:07 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Fri, Aug 07, 2009 at 10:54:16PM +0200, Daniel Ribeiro wrote:
> > > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > > index 0d979fd..679bae3 100644
> > > --- a/drivers/input/misc/Makefile
> > > +++ b/drivers/input/misc/Makefile
> > > @@ -26,3 +26,4 @@ obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
> > >  obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
> > >  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
> > >  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
> > > +obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
> > 
> > Btw, could we please keep Makefile sorted alphabetically? This should
> > help with merge conflicts a bit (I know Kconfig is still not sorted).
> >
> 
> Ok, do I need to send another version?
> 
> And, is Samuel taking this one and the pcap_ts one?
> They depends on changes already in his for-next branch.
I'm taking this one, and I'll sort the Makefile alphabetically.

Cheers,
Samuel.


> Thanks,
>    Antonio
> 
> -- 
> Antonio Ospite
> http://ao2.it
> 
> PGP public key ID: 0x4553B001
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?



-- 
Intel Open Source Technology Centre
http://oss.intel.com/
