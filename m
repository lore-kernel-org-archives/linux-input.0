From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 09:00:43 -0800
Message-ID: <1450655.FGD6Ze0vGz@dtor-d630.eng.vmware.com>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com> <4F3A7C84.4000901@canonical.com> <CAPHpN5NY=1jCaa2yADzvYXkFc4a_1Nkb8JVpbM4pVqy7ZHOYkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36188 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab2BNRAy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 12:00:54 -0500
Received: by yhoo21 with SMTP id o21so149094yho.19
        for <linux-input@vger.kernel.org>; Tue, 14 Feb 2012 09:00:54 -0800 (PST)
In-Reply-To: <CAPHpN5NY=1jCaa2yADzvYXkFc4a_1Nkb8JVpbM4pVqy7ZHOYkg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tuesday, February 14, 2012 04:28:18 PM Mohamed Ikbel Boulabiar wrote:
> On Tue, Feb 14, 2012 at 4:23 PM, Chase Douglas
> 
> <chase.douglas@canonical.com> wrote:
> > I can add that, it's just superfluous. It doesn't really tell the reader
> > anything if they need to know what is going on. Unless the message is
> > supposed to copy the definition of the properties themselves, which is
> > rather pointless.
> > 
> > It's like documenting a function:
> > 
> > bool is_object_mutable();
> > Returns true if object is mutable;
> > 
> > There's really no point.
> 
> We don't always have the message+code. In the end we have only commit
> msgs like the raw changelog here :
> http://www.kernel.org/pub/linux/kernel/v3.0/ChangeLog-3.2.6

The summary of the patch would still be in the changelog:

	bcm5974: Add pointer and buttonpad properties

and I rally do not see the point of trying to expand it into the body
of the changelog if there isn't anything more to say. It's the same
as checkpatch complaining that some Kconfig options are too short
when full description does indeed fit into 1 line (for example enabling
SPI or I2C support module for a certain device when driver split
into core and bus-specific parts - there is literally nothing else to
say).

Thanks.

-- 
Dmitry
