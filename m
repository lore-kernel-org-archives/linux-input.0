From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] sh: maple: add support for the Maple mouse on the SEGA
 Dreamcast
Date: Mon, 29 Dec 2008 22:17:53 +0000
Message-ID: <1230589073.6496.30.camel@localhost.localdomain>
References: <1230578246.6496.25.camel@localhost.localdomain>
	 <200812291602.18572.vapier@gentoo.org>
	 <1230586215.6496.28.camel@localhost.localdomain>
	 <200812291636.36303.vapier@gentoo.org>
	 <1230586714.6496.29.camel@localhost.localdomain>
	 <20081229214634.GA27064@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081229214634.GA27064@uranus.ravnborg.org>
Sender: linux-sh-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mike Frysinger <vapier@gentoo.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2008-12-29 at 22:46 +0100, Sam Ravnborg wrote:

> Look for an increase in section mismatch warning or try to
> build with:
> make CONFIG_DEBUG_SECTION_MISMATCH=y
> 

Just rebuilt the whole thing from scratch with that turned on and no
extra warnings at all.

