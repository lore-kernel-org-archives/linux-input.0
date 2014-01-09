From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bqreaders.com>
Subject: [PATCH 0/3] Input: add dt support to zforce driver
Date: Thu, 09 Jan 2014 22:19:15 +0100
Message-ID: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34215 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089AbaAIVTh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jan 2014 16:19:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

This adds the binding documentation and necessary parsing code to make
zforce based touchscreen usable on devicetree platforms.

Heiko Stuebner (3):
  dt-bindings: bindings for zforce touchscreens
  Input: zforce: Use internal pdata pointer instead of dev_get_platdata
  Input: zforce: add devicetree support

 .../bindings/input/touchscreen/zforce_ts.txt       |   30 ++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/touchscreen/zforce_ts.c              |   63 ++++++++++++++++++--
 3 files changed, 89 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

-- 
1.7.10.4


