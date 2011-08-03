From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH v2] input: add EETI eGalax I2C capacitive multi touch
 driver.
Date: Wed, 03 Aug 2011 13:48:35 -0700
Message-ID: <4E39B423.2060402@gmail.com>
References: <20110801063409.GB32118@core.coreip.homeip.net> <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52359 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab1HCUsl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 16:48:41 -0400
Received: by gwaa12 with SMTP id a12so711637gwa.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 13:48:40 -0700 (PDT)
In-Reply-To: <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dima@android.com, kzjeef@gmail.com

On 08/03/2011 04:29 AM, Zhang Jiejing wrote:
> Hi Dmitry,
> 
> This is the patch after change to mt Protocol-B.
> but I have a issue with test tool, in the orignal patch, I use
> android to do the test, but android still not support Protocol B.
> 
> I also have a arm based ubuntu, could you which tool can test protocol B?

There are some tools as part of the Ubuntu uTouch stack that you could
use. If you want to see the raw touch data you can use
utouch-frame-test-mtdev from the utouch-frame-tools package. If you want
to see if gestures work you can use geistest from utouch-geis-tools.

-- Chase
