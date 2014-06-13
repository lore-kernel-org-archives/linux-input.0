From: Denis Carikli <denis@eukrea.com>
Subject: Dust off the "arm imx25 touchscreen/ADC drivers" patch serie.
Date: Fri, 13 Jun 2014 17:21:33 +0200
Message-ID: <1402672899-6995-1-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:15353 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131AbaFMPVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jun 2014 11:21:46 -0400
In-Reply-To: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>


Hi,

I haven't seen any new comments on that serie since february,
so I picked it again and I tried to address all remaining comments.

To be able to test that patch, the following patch will need to be
cherry-picked.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263494.html

Denis.
