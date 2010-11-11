From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Wed, 10 Nov 2010 17:22:52 -0800
Message-ID: <20101111012251.GC2121@core.coreip.homeip.net>
References: <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com>
 <20101109065933.GA13921@core.coreip.homeip.net>
 <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com>
 <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com>
 <4CDB3D6C.2000507@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60349 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0KKBXD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 20:23:03 -0500
Received: by gxk23 with SMTP id 23so885487gxk.19
        for <linux-input@vger.kernel.org>; Wed, 10 Nov 2010 17:23:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDB3D6C.2000507@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pinglinux@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 01:48:44AM +0100, Henrik Rydberg wrote:
> On 11/11/2010 12:53 AM, Peter Hutterer wrote:
> 
> > On Wed, Nov 10, 2010 at 11:00:05AM +0100, Henrik Rydberg wrote:
> >> A comment on pixels and resolution:
> >>
> >> A pen and a thumb may have different resolution (signal-to-noise ratio), but
> >> there is no reason they cannot be reported on the same scale. In fact, it could
> >> be argued that it is natural for objects on the same surface to be reported in
> >> the coordinate system of the surface.
> > 
> > it may be natural from a human perspective, but the computer doesn't care
> > about it.
> 
> 
> The fact that we discuss a computer protocol suggests the computer does care.
> ;-) The question is whether we need to be able to support different scales for
> different tools types. I argue that among the three things value range, physical
> range and SN ratio, the one most naturally seen as an attribute of a tool is the
> SN ratio.
> 
> > And given that most input device interpretation is done in
> > software, the scale used doesn't matter as long as it's correct.
> 
> > in the UI, even with different ranges for different tools, top-left should
> > refer to whatever coordinate that is.
> > 
> > in other words, if the pure numbers matter in the UI, we've done something
> > wrong.
> 
> > 
> > what benefit do we get from reporting tools on the same scale if the HW
> > doesn't do so?
> 
> 
> The question is, given a set of tool types reported via MT events, what
> additional information is needed. Having tools share the same ABS axes, I would
> like to see that as a good thing. So what is missing from that picture?

I think that with devices that share the same working surface with
different tools (touch/pen) it would make sense to normalize the data in
the kernel. If for no other reason but to simplify the protocol.

In cases when tools are way to different driver writer might opt to
export the device as 2 separate logical input devices (and then take
care of coordinating them in userspace), in other cases treat them as
one input device and scale to the same range.

I tend to think [at the moment] that the latter would be most sensible
option for Bamboo...

Thanks.

-- 
Dmitry
