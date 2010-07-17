From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] trivial: rename config-token QT2160
Date: Sat, 17 Jul 2010 17:35:44 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007171734420.2802@lynx>
References: <alpine.DEB.2.00.1007160434590.13824@lynx> <1279322143.4064.11.camel@lovely.krouter> <20100717212932.GA20623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:49863 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab0GQVfv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jul 2010 17:35:51 -0400
In-Reply-To: <20100717212932.GA20623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org

On Sat, 17 Jul 2010, Dmitry Torokhov wrote:

> I'll take the Kconfig change part however I am not going to touch
> defconfig files (and probably others should stay away from them for
> a while ;) ).

  the understanding i've always had is that the defconfig files are
regenerated on a regular basis so there's little value in messing with
them manually.

rday

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Top-notch, inexpensive online Linux/OSS/kernel courses
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
