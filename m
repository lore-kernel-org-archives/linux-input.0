From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Wed, 09 May 2012 14:23:54 -0700
Message-ID: <3680102.m0lTgVbfcu@dtor-d630.eng.vmware.com>
References: <1336597795.45073.YahooMailClassic@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37025 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758650Ab2EIVYA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 17:24:00 -0400
Received: by dady13 with SMTP id y13so816834dad.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 14:24:00 -0700 (PDT)
In-Reply-To: <1336597795.45073.YahooMailClassic@web29017.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: philipp.zabel@gmail.com, linux-input@vger.kernel.org

On Wednesday, May 09, 2012 10:09:55 PM Paul Parsons wrote:
> Hello Dmitry,
> 
> --- On Wed, 9/5/12, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > The driver looks excellent now, I have just a few nits:
> > 
> > - you do not need separate mutex and counter; it is
> > perfectly fine to
> >   use input device's ones;
> > 
> > - we don't really need min/max for coordinates: the defaults
> > are good
> >   for your device and if more devices come with
> > different limits one
> >   could adjust limits via EVIOCSABS ioctls.
> > 
> > I also took libertu if rearranging the code a bit so it
> > flows more like
> > the rest of the input drivers. Could you please tell me if
> > the patch
> > below breaks your device or if it still works?
> 
> It still works! Thanks.
> 
> Will you apply a combined patch (my patch v8 + your patch),
> or should I submit them as patch v9?

If you have not made any changes to the patch I sent then there is no need
to send v9, I'll fold everything together on my end.

Thanks.

-- 
Dmitry
