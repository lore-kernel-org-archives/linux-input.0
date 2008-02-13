From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [UPDATED v7] WM97xx touchscreen drivers
Date: Wed, 13 Feb 2008 14:06:48 +0000
Message-ID: <20080213140648.GD31617@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43598 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753848AbYBMOGv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 09:06:51 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Pete MacKay <linux01@architechnical.net>, Marc Kleine-Budde <mkl@penugtronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>, dbaryshkov@gmail.com

This patch series adds support for the touchscreen controllers provided
by Wolfson Microelectronics WM97xx series chips in both polled and
streaming modes.  The series can also be pulled via git from:

	git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

This version:
 - Has been rebased against v2.6.25-rc1
 - Fixes usage of the platform API to avoid double registration of the
   battery and touch devices.
 - Removes the use of the obsolete sound/driver.h.
