From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Fri, 11 May 2012 09:06:55 -0700
Message-ID: <20120511160655.GB6542@core.coreip.homeip.net>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
 <20120507070424.GC22074@core.coreip.homeip.net>
 <4FACCDA6.7040506@atmel.com>
 <CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53842 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab2EKQHD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 12:07:03 -0400
Received: by yenm10 with SMTP id m10so2772126yen.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 09:07:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Josh Wu <josh.wu@atmel.com>, Bo Shen <voice.shen@atmel.com>, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi Javier,

On Fri, May 11, 2012 at 11:13:41AM +0200, javier Martin wrote:
> 
> Moreover, if you try a grep for IRQ_TRIGGER_NONE in the kernel tree
> you won't find any driver doing this strange thing.

That is because most of the driver simply use '0', which is the same
thing - trust board code to perform setup using irq_set+_irq_type().

Thanks.

-- 
Dmitry
