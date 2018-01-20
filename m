From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Input-sur40: Adjustments for sur40_probe()
Date: Sat, 20 Jan 2018 22:26:59 +0100
Message-ID: <a7e25da3-587a-f0e8-d574-8066b340d9a6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:56298 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756652AbeATV1I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Jan 2018 16:27:08 -0500
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Echtler <floe@butterbrot.org>, Johan Hovold <johan@kernel.org>, Martin Kaltenbrunner <modin@yuri.at>, Martin Kepplinger <martink@posteo.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 22:20:10 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/touchscreen/sur40.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.15.1

