From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Wed, 10 Nov 2010 11:00:05 +0100
Message-ID: <4CDA6D25.4070501@euromail.se>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com> <20101108035121.GA4630@barra.bne.redhat.com> <4CD7B012.1030809@cena.fr> <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com> <20101109033149.GC19313@barra.redhat.com> <20101109065933.GA13921@core.coreip.homeip.net> <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com> <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com> <20101110050219.GB29110@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:36045 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755227Ab0KJKCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 05:02:45 -0500
In-Reply-To: <20101110050219.GB29110@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>

A comment on pixels and resolution:

A pen and a thumb may have different resolution (signal-to-noise ratio), but
there is no reason they cannot be reported on the same scale. In fact, it could
be argued that it is natural for objects on the same surface to be reported in
the coordinate system of the surface.

So, if anything, the resolution is object/sensor dependent, and adding a
possibility to specify resolution per object type would be good. It would also
be good to know the physical dimensions of the surface.

Cheers,
Henrik
