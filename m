From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Atmel AT42QT1070 driver, version 2
Date: Sun, 13 Mar 2011 22:57:58 -0700
Message-ID: <20110314055758.GA30295@core.coreip.homeip.net>
References: <1299655137>
 <1300068901-14209-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56640 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab1CNF6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2011 01:58:07 -0400
Received: by iwn34 with SMTP id 34so4603289iwn.19
        for <linux-input@vger.kernel.org>; Sun, 13 Mar 2011 22:58:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300068901-14209-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: voice <voice.shen@atmel.com>
Cc: linux-input@vger.kernel.org, mohan1234@gmail.com, jm.lin@atmel.com

On Mon, Mar 14, 2011 at 10:15:01AM +0800, voice wrote:
> Add driver for Atmel AT42QT1070 QTouch sensor chip.
> The AT42QT1070 QTouch sensor support up to 7 keys.
> The driver has been tested on Atmel AT91SAM9M10-G45-EK board, it should work fine on other platform.
> 
> [v1] Modify the driver according to the suggestion from Mohan
> 
> [v2] Modify the driver according to the suggestion from Dmitry

Excellent, thank you very much for maing the changes. I am ready to
apply the patch, however I am missing your "Signed-off-by: ..." for
this version.

Thanks.

-- 
Dmitry
