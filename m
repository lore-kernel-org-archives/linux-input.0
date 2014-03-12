From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Input: fix dependencies of OLPC AP-SP driver
Date: Wed, 12 Mar 2014 14:04:50 +0100
Message-ID: <20140312140450.657f1639@endymion.delvare>
References: <20140311194253.23daf5e3@endymion.delvare>
	<20140312061134.GA2263@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45220 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbaCLNEx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 09:04:53 -0400
In-Reply-To: <20140312061134.GA2263@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, 11 Mar 2014 23:11:34 -0700, Dmitry Torokhov wrote:
> On Tue, Mar 11, 2014 at 07:42:53PM +0100, Jean Delvare wrote:
> > I don't think the OLPC AP-SP driver is generally useful without OLPC
> > support. So make it depend on OLPC, unless build testing is enabled.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/serio/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-3.14-rc6.orig/drivers/input/serio/Kconfig	2014-02-09 16:53:02.931633818 +0100
> > +++ linux-3.14-rc6/drivers/input/serio/Kconfig	2014-03-11 18:52:42.280541110 +0100
> > @@ -263,7 +263,7 @@ config SERIO_APBPS2
> >  
> >  config SERIO_OLPC_APSP
> >  	tristate "OLPC AP-SP input support"
> > -	depends on OF
> > +	depends on OLPC || (OF && COMPILE_TEST)
> 
> Actually for compile coverage we do not actually need OF, I'll make it
> 
> 	depends on OLPC || COMPILE_TEST
> 
> instead.

Ah, you're right. Thanks for spotting it, your solution is easier and
cleaner :)

-- 
Jean Delvare
SUSE L3 Support
