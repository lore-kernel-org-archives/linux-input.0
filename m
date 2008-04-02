From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] Build system and MAINTAINERS entry for WM97xx
	touchscreen drivers
Date: Wed, 2 Apr 2008 11:37:22 +0100
Message-ID: <20080402103722.GA3432@rakim.wolfsonmicro.main>
References: <20080401102825.GA30868@rakim.wolfsonmicro.main> <1207046169-2152-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-2-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-3-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-4-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-5-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-6-git-send-email-broonie@opensource.wolfsonmicro.com> <20080402050400.GA14189@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48289 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752086AbYDBKhY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Apr 2008 06:37:24 -0400
Content-Disposition: inline
In-Reply-To: <20080402050400.GA14189@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>

On Wed, Apr 02, 2008 at 01:04:00AM -0400, Dmitry Torokhov wrote:

> applied the series to wm97xx branch of my input tree. I also moved
> changes to Makefile/Kconfig to the appropriate patches instead of
> doing bulk update as a separate patch. Please take a look and let
> me know if you see anything wrong.

Everything looks good, thanks.

The build infrastructure was split off to ensure that the tree was
buildable with the partially applied series - the core is obviously
non-functional without the individual chip drivers.  In the past it
wouldn't build with missing chip drivers but that shouldn't be the case
any more.
