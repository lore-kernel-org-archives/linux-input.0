From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 09:53:55 +1000
Message-ID: <20101110235355.GB4473@barra.bne.redhat.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
 <20101108035121.GA4630@barra.bne.redhat.com>
 <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com>
 <20101109065933.GA13921@core.coreip.homeip.net>
 <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com>
 <4CDA6D25.4070501@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:63380 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0KJXyI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 18:54:08 -0500
Content-Disposition: inline
In-Reply-To: <4CDA6D25.4070501@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>

On Wed, Nov 10, 2010 at 11:00:05AM +0100, Henrik Rydberg wrote:
> A comment on pixels and resolution:
> 
> A pen and a thumb may have different resolution (signal-to-noise ratio), but
> there is no reason they cannot be reported on the same scale. In fact, it could
> be argued that it is natural for objects on the same surface to be reported in
> the coordinate system of the surface.

it may be natural from a human perspective, but the computer doesn't care
about it. And given that most input device interpretation is done in
software, the scale used doesn't matter as long as it's correct.
in the UI, even with different ranges for different tools, top-left should
refer to whatever coordinate that is.

in other words, if the pure numbers matter in the UI, we've done something
wrong.

what benefit do we get from reporting tools on the same scale if the HW
doesn't do so?

> So, if anything, the resolution is object/sensor dependent, and adding a
> possibility to specify resolution per object type would be good. It would also
> be good to know the physical dimensions of the surface.

well, the physical dimensions are exported through the resolution, isn't it?
if I have a range of 0-1000 and a resolution of 100 units per cm, I can
guesstimate the phys size of the device.

I know that in the X protocol resolution is specified in units/m, but given
previous threads the kernel seems to be ambiguous here, alternating between
in and mm.

Cheers,
  Peter
