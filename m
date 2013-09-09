From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: ALPS Touchpad- Improve the performance of
 alps v5-protocol's touchpad
Date: Mon, 9 Sep 2013 09:26:25 -0700
Message-ID: <20130909162624.GB25107@core.coreip.homeip.net>
References: <89B48266C4EEC447B3A3A031C8DE21870263AF88@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63770 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3IIQ02 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 12:26:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so6389675pdj.16
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 09:26:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <89B48266C4EEC447B3A3A031C8DE21870263AF88@SIXPRD0410MB394.apcprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "yunkang.tang@cn.alps.com" <yunkang.tang@cn.alps.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Tommy,
 
On Thu, Sep 05, 2013 at 05:50:48AM +0000, yunkang.tang@cn.alps.com wrote:
> <Change list>
> - Calculate the device's dimension in alps_identify().
> - Change the logic of packet decoding.
> - Add the new data process logic.

It appears that your mailer damaged the patch converting all tabs to
single spaces. Please consider using an alternative MTA (mutt, or maybe
git send-email) to post your patches.

It also apperas that there are several changes (support for never
hardware, tweaks to the older protocols) going rolled into a single
patch, would it be possible to split them into separate patches,
please?

> - Change the dev2's name from "PS/2 Mouse" to "ALPS Touchpad".

Hmm, the secondary device is never a touchpad but either trackpoint (for
confirmed dualpoint devices) or "something" we do not quite know what.
Why are you marking it as a touchpad?

Also, you forgot to add your "Signed-off-by: ..." as per
Documentation/SubmittingPatches

Thanks!

-- 
Dmitry
