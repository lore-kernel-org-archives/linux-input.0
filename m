From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: Make ADS7846 independent on regulator
Date: Wed, 6 Oct 2010 18:52:47 +0100
Message-ID: <20101006175247.GB2874@sirena.org.uk>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com> <AANLkTindRMOmo8CrFuUsWqNRn6CZVKOMQZS2LXJ63=YC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34877 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759113Ab0JFRxA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 13:53:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTindRMOmo8CrFuUsWqNRn6CZVKOMQZS2LXJ63=YC@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, vapier@gentoo.org, pavel@ucw.cz, akpm@linux-foundation.org, khilman@deeprootsystems.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eric.y.miao@gmail.com

On Wed, Oct 06, 2010 at 07:16:05PM +0200, Linus Walleij wrote:
> 2010/7/31 Marek Vasut <marek.vasut@gmail.com>:

> > +#ifdef CONFIG_REGULATOR

> Skip the #ifdef, if the regulators are configured out, there will be
> a stub providing NULL for all get_regulator() calls anyway.

While ifdefs on CONFIG_REGULATOR should indeed be skipped I'd not expect
the stubs to be returning NULL for anything (but then as discussed
elsewhere this whole approach of doing everything in the drivers is a
poor one).
