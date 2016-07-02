From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input-at32psif: Fine-tuning for OOM handling in
 psif_probe()
Date: Sat, 2 Jul 2016 21:00:36 +0200
Message-ID: <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54703 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbcGBTAv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Jul 2016 15:00:51 -0400
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 2 Jul 2016 20:50:09 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed kzalloc()
  Remove two OOM messages

 drivers/input/serio/at32psif.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.9.0

