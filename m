From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Input: wm831x-ts - Fix races with IRQ management
Date: Fri, 18 Mar 2011 11:20:44 +0000
Message-ID: <20110318112043.GA27129@sirena.org.uk>
References: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1300142701-22260-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52591 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1CRLUp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2011 07:20:45 -0400
Content-Disposition: inline
In-Reply-To: <1300142701-22260-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Mon, Mar 14, 2011 at 10:45:01PM +0000, Mark Brown wrote:

> This revision reworks the close() implementation, hopefully more
> robustly, which should address the main thrust of your comments
> previously.  As I said in my previous e-mail the restrictions on
> enable_irq() seem reasonable to me, the thing that's nasty here is that
> we need to enable and disable the IRQs at all.

It'd be good to get something for this into 2.6.39.  At the very least
this version of the patch avoids issues while the device is open and
keeps any issues in close() which is an improvement.  If this approach
isn't going to be OK please let me know so I can look into alternatives.
