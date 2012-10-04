From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Communicating tablet mode status to userspace
Date: Thu, 4 Oct 2012 14:35:52 +0100
Message-ID: <20121004133551.GB1275@sirena.org.uk>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
 <20121002233640.GB8542@core.coreip.homeip.net>
 <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43879 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab2JDNfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Oct 2012 09:35:54 -0400
Content-Disposition: inline
In-Reply-To: <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>

On Wed, Oct 03, 2012 at 08:52:31AM -0600, Daniel Drake wrote:

> The disadvantage here is that it doesn't work as a global solution to
> the problem - every embedded distro in the same situation would have
> to add a custom rule thing, and "generic distros" would have no such
> solution at this time.

> Maybe not such a big deal while OLPC is the only user. But I did come
> across another request for SW_TABLET_MODE access:
> https://bugs.freedesktop.org/show_bug.cgi?id=43935

We went through the same routine with the jack status in ALSA too (which
has for a long time been reported as input events), where we've now
achieved the glorious triumph of three independant userspace ABIs for
reporting the same information.
