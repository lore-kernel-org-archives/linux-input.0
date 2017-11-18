From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Sat, 18 Nov 2017 10:32:15 -0800
Message-ID: <20171118183215.v25cyjfewba6lsxv@dtor-ws>
References: <20171117141720.GB17880@kroah.com>
 <20171117203313.l7lqzrun5bnuj2ht@dtor-ws>
 <20171118102724.GF8368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:41837 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423318AbdKRScS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 13:32:18 -0500
Content-Disposition: inline
In-Reply-To: <20171118102724.GF8368@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, linux-input@vger.kernel.org

On Sat, Nov 18, 2017 at 11:27:24AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 17, 2017 at 12:33:13PM -0800, Dmitry Torokhov wrote:
> > On Fri, Nov 17, 2017 at 03:17:20PM +0100, Greg Kroah-Hartman wrote:
> > > There is no need to #define the license of the driver, just put it in
> > > the MODULE_LICENSE() line directly as a text string.
> > > 
> > > This allows tools that check that the module license matches the source
> > > code license to work properly, as there is no need to unwind the
> > > unneeded dereference.  For some of these drivers, the #define is just a
> > > few lines above the MODULE_LICENSE() line, which is extra pointless.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > > Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/input/misc/keyspan_remote.c | 3 +--
> > >  drivers/input/tablet/acecad.c       | 3 +--
> > >  drivers/input/tablet/hanwang.c      | 3 +--
> > >  drivers/input/tablet/kbtab.c        | 3 +--
> > >  4 files changed, 4 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
> > > index 77c47d6325fe..4f13b2f7bf4f 100644
> > > --- a/drivers/input/misc/keyspan_remote.c
> > > +++ b/drivers/input/misc/keyspan_remote.c
> > > @@ -20,7 +20,6 @@
> > >  #define DRIVER_VERSION	"v0.1"
> > >  #define DRIVER_AUTHOR	"Michael Downey <downey@zymeta.com>"
> > >  #define DRIVER_DESC	"Driver for the USB Keyspan remote control."
> > > -#define DRIVER_LICENSE	"GPL"
> > 
> > If we do this, can we also get rid of other DIRVER_* macros that are not
> > useful?
> 
> Please do, I got rid of all of the DRIVER_VERSION crap in the
> drivers/usb/ tree a release or so ago, as they make no sense at all.
> The other defines are also really silly and can be cleaned up too.
> 
> Want me to do that for drivers/input/ for you?
> 

That would be great, yes.

Thanks.

-- 
Dmitry
