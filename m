From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 3/5] Skip matrix size check
Date: Thu, 03 Feb 2011 16:04:53 +0200
Message-ID: <4D4AB605.4080106@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:65439 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab1BCOEk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 09:04:40 -0500
In-Reply-To: <20110203074318.GA5814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

Input: qt602240_ts - Skip matrix size check

From: Iiro Valkonen <iiro.valkonen@atmel.com>

Skip the mxt224-specific matrix size check

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 6ef8290..a88ec93 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -862,10 +862,17 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
 
+      /*
+       * Skip this and trust what's on the chip, as the current check
+       * is not compatible with mXT1386. Revisit and fix.
+       */
 	/* Check X/Y matrix size */
+
+	/*
 	error = mxt_check_matrix_size(data);
 	if (error)
 		return error;
+	*/
 
 	error = mxt_make_highchg(data);
 	if (error)
-- 
1.7.0.4
