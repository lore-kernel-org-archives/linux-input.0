From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846 - cleanup GPIO initialization
Date: Tue, 28 Jun 2011 09:54:08 +0400
Message-ID: <944955f1-bb5e-4c82-b897-27ae2e38b606@email.android.com>
References: <1308949493-16380-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53176 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab1F1Fy0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 01:54:26 -0400
Received: by pvg12 with SMTP id 12so3275611pvg.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 22:54:26 -0700 (PDT)
In-Reply-To: <1308949493-16380-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-input@vger.kernel.org

Igor Grinberg <grinberg@compulab.co.il> wrote:

>Use gpio_request_one() instead of multiple gpiolib calls.
>This also simplifies error handling a bit.
>
>Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Applied, thanks Igor.


-- 
Dmitry
