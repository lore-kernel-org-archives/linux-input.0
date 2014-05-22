From: Ferruh Yigit <fery@cypress.com>
Subject: ABS_MT_TOUCH_MAJOR metric
Date: Thu, 22 May 2014 14:03:40 +0300
Message-ID: <537DD98C.5090800@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43603 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaEVLDq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 07:03:46 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2383792pab.6
        for <linux-input@vger.kernel.org>; Thu, 22 May 2014 04:03:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>

Hi,

What is the metric of ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR events?

The Linux documentation
<https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt> says:
"The length of the major axis of the contact. The length should be given
in surface units. ..."

What does "surface units" means, is it millimeter or pixels?

-- 

Thanks,
ferruh

