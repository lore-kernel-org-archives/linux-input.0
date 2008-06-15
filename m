From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] input: add support for SEGA Dreamcast controller as
	joystick
Date: Sun, 15 Jun 2008 17:19:30 +0100
Message-ID: <1213546770.10290.0.camel@localhost.localdomain>
References: <1211138322.6354.5.camel@localhost.localdomain>
	 <20080519010928.GA8797@linux-sh.org>
	 <20080519114515.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080519114515.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2008-05-19 at 11:47 -0400, Dmitry Torokhov wrote:

> 
> In addition to Pauls comments - is there a reson why maple drivers
> need to brovide both connect/disconnect and probe/remove functions?
> Normally the layer has generic probe/remove defined on bus level and
> individual drivers provide connect/disconnect (or their equivalent)
> which is called from the bus's probe/remove.
> 

Cruft from another era. I will try to clean all that up.

