From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice and keyboards
Date: Sat, 26 Dec 2009 22:38:20 +0100
Message-ID: <200912262238.20690.rjw@sisk.pl>
References: <20091221070951.GA4170@core.coreip.homeip.net> <magh07-258.ln1@chipmunk.wormnet.eu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58707 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbZLZVhi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Dec 2009 16:37:38 -0500
In-Reply-To: <magh07-258.ln1@chipmunk.wormnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Clouter <alex@digriz.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Saturday 26 December 2009, Alexander Clouter wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > I am asking everyone to give this patch a try. It is reported to speed
> > up suspend process, however there is a risk that there are boxes out
> > there that do require full reset and I would prefer to know that sooner
> > than later.
> > 
> Seems to work on my ICH8 lapdog (a Fujitsu T2010), can't say it actually 
> speeds the suspend/resume cycle up though.

With 2.6.33-rc2, if you do

dmesg | grep "of devices"

that will give you total device suspend/resume times.  By comparing the times
with and without the patch you should be able to tell the difference (if any).

Rafael
