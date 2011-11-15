From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Build breakage in samsung-keypad driver
Date: Tue, 15 Nov 2011 12:53:20 +0000
Message-ID: <20111115125319.GF3077@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50016 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754271Ab1KOMxW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 07:53:22 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>

Hi Dmitry,

Your commit 5862c02 (Input: samsung-keypad - enable compiling on other
platforms) breaks the build on any platform using the driver as you've
moved the header defining the platform data without updating any of the
users.  Whenever doing updates to platform data you really need to grep
the tree for users and make sure they're updated otherwise there will be
build breakage.

I also can't see the patch on the list...

Thanks,
Mark
