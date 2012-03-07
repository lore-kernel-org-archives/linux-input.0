From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] input: altera_ps2: Store struct serio in struct ps2if
Date: Wed, 7 Mar 2012 21:03:25 +0100
Message-ID: <20120307200325.GE21503@distanz.ch>
References: <1331127864-7667-1-git-send-email-tklauser@distanz.ch>
 <20120307172523.GA29568@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:52860 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757043Ab2CGUMd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Mar 2012 15:12:33 -0500
Content-Disposition: inline
In-Reply-To: <20120307172523.GA29568@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

On 2012-03-07 at 18:25:24 +0100, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Wed, Mar 07, 2012 at 02:44:24PM +0100, Tobias Klauser wrote:
> > It doesn't make much sense to allocate struct ps2if and struct serio
> > separately as they're allocated and used in conjunction.
> > 
> 
> Actually, it does. Serio is a refcounted structure and has different
> lifetime rules than struct ps2if. It may get deleted by
> serio_unregister_port() or it may live on until after ps2if is freed and
> altera_ps2 module is unloaded and it should stay allocated separately.

Oh, sorry. I didn't look careful enough then. Thanks a lot for clearing
that up!

I was looking at xilinx_ps2 and figured they do it like this. Would that
mean a "bug" there, or am I mislead again?

Thanks
Tobias
