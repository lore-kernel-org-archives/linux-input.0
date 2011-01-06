From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Thu, 6 Jan 2011 12:15:56 +0000
Message-ID: <20110106121556.GE17184@sirena.org.uk>
References: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20110105221432.GA6086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56183 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab1AFMQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 07:16:00 -0500
Content-Disposition: inline
In-Reply-To: <20110105221432.GA6086@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Jan 05, 2011 at 02:14:32PM -0800, Dmitry Torokhov wrote:

> Please change to guard .pm = &ad7879_i2c_pm with #ifdef.

I've sent out updated versions of this and the other affected patches;
the rest were already either not guarding at all or had the define due
to following the idiom of the existing driver.
