From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Add maxtouch to I2C table for
 module autoload
Date: Fri, 11 Dec 2015 13:24:22 -0800
Message-ID: <20151211212422.GA32425@dtor-ws>
References: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
 <20151120191558.GD26895@dtor-ws>
 <566A05C3.30204@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33077 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbLKVY0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2015 16:24:26 -0500
Content-Disposition: inline
In-Reply-To: <566A05C3.30204@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Hi Javier,

On Thu, Dec 10, 2015 at 08:07:47PM -0300, Javier Martinez Canillas wrote:
> Hello Dmitry,
> 
> On 11/20/2015 04:15 PM, Dmitry Torokhov wrote:
> > On Fri, Nov 20, 2015 at 04:09:42PM -0300, Javier Martinez Canillas wrote:
> >> The Atmel maxtouch DT binding documents that the compatible string for
> >> the device is "atmel,maxtouch" and the I2C core always reports a module
> >> alias of the form i2c:alias where alias is the compatible string model:
> >>
> >> $ grep MODALIAS /sys/devices/platform/12e00000.i2c/i2c-8/8-004b/uevent
> >> MODALIAS=i2c:maxtouch
> > 
> > Do we know why we are not reporting modalias as "of:..." so that
> > autoloading using the of table works properly?
> > 
> > It sounds like the of matching and modalias is quite a mess at the
> > moment.
> >
> 
> I already explained the issues with OF modalias and why I believe
> $SUBJECT is the least bad solution for now until the I2C subsystem
> is changed to properly report OF modalias.
> 
> Please let me know if you are considering applying this or if
> module autoloading will be broken for this driver in the meantime.

My bad, I was going to apply it several times but then my attention
would wander to some other patchset and I'd forget.

Applied now.

-- 
Dmitry
