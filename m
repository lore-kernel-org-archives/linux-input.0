From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Thu, 9 Feb 2017 13:38:48 -0800
Message-ID: <20170209213848.GE8862@dtor-ws>
References: <20170114191425.GA31309@dtor-ws>
 <20170118205712.GA5333@gmail.com>
 <20170118224946.GC11881@dtor-ws>
 <20170131081942.GC8311@dtor-ws>
 <20170201191058.GA8453@gmail.com>
 <20170201192053.GB40720@dtor-ws>
 <20170201192331.GC40720@dtor-ws>
 <20170201193023.GD40720@dtor-ws>
 <20170201193554.GB8453@gmail.com>
 <20170201224734.GF40720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33776 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBIVl0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2017 16:41:26 -0500
Content-Disposition: inline
In-Reply-To: <20170201224734.GF40720@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Feb 01, 2017 at 02:47:34PM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 01, 2017 at 08:35:55PM +0100, Jelle van der Waa wrote:
> > On 02/01/17 at 11:30am, Dmitry Torokhov wrote:
> > > On Wed, Feb 01, 2017 at 11:23:31AM -0800, Dmitry Torokhov wrote:
> > > > On Wed, Feb 01, 2017 at 11:20:53AM -0800, Dmitry Torokhov wrote:
> > > > > On Wed, Feb 01, 2017 at 08:10:59PM +0100, Jelle van der Waa wrote:
> > > > > > On 01/31/17 at 12:19am, Dmitry Torokhov wrote:
> > > > > > > Hi Jelle,
> > > > > > > 
> > > > > > > On Wed, Jan 18, 2017 at 02:49:46PM -0800, Dmitry Torokhov wrote:
> > > > > > > > On Wed, Jan 18, 2017 at 09:57:14PM +0100, Jelle van der Waa wrote:
> > > > > > > > > > I also have been looking at you previosu submission and had some draft
> > > > > > > > > > changes. I reconciled them in the patch below, if it still works for you
> > > > > > > > > > then I'll fold everything together and apply. Please let me know.
> > > > > > > > > 
> > > > > > > > > I'll find some time to test the patch below, I've one small suggestion
> > > > > > > > > to the patch below.
> > > > > > > 
> > > > > > > It would be very helpful if you let me know if the patch actually works
> > > > > > > on the hardware: the merge window for 4.11 will be opening fairly soon.
> > > > > > 
> > > > > > Sorry, I had a busy week and at first it didn't work since I didn't have
> > > > > > a regulator and I think the code for the regular might be wrong.
> > > > > > 
> > > > > > I think that you want the regulators to be optional, but
> > > > > > devm_regulator_get_optional errors out when no vcc/vio is configured.
> > > > > > Changing it to devm_regulator_get makes the driver work. I guess this is
> > > > > > since devm_regulator_get_optional doesn't allow the creation of a dummy
> > > > > > device while devm_regulator_get does.
> > > > > 
> > > > > Ah, yes, these should have been non-optional. I'll fix it up and apply
> > > > > then.
> > > > 
> > > > Hmm.. but no, we only acess regulators if they are non-NULL in
> > > > zet6223_power_on(). I used devm_regulator_get_optional() to avoid
> > > > needless sleep in zet6223_power_on() when we do not have regulators
> > > > defined. Let me look some more...
> > > 
> > > What is the error you are getting from devm_regulator_get_optional()?
> > > What kind of system is that? Do you have system with full constraints?
> > 
> > The system is an ARM tablet, I don't know what regulator it uses for the
> > touchscreen (since I don't have any schematics).
> > 
> > The error I get is:
> > 
> > [    1.274337] zet6223 1-0076: failed to get 'vio' regulator: -19
> 
> OK, I see what is going on. I CCed you on a mail to Mark Brown regarding
> regulator_get_optional(), depending on his response we'll know the way
> forward.

OK, I changed them to be non-optional: I think we can spare 30 msec on
startup for now, we may revisit later if/when we get new regulator API
to check when regulators were turned off/on last.

I'll queue it for 4.11.

Thanks.

-- 
Dmitry
