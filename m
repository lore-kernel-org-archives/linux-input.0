From: Matt Hsu <matt@0xlab.org>
Subject: Re: Duplicated driver for LIS302-like device.
Date: Mon, 14 Dec 2009 11:29:18 +0800
Message-ID: <4B25B10E.1010409@0xlab.org>
References: <4B21B40B.2010007@0xlab.org> <4B2241D0.3050504@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61353 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbZLND3h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 22:29:37 -0500
Received: by yxe17 with SMTP id 17so2292282yxe.33
        for <linux-input@vger.kernel.org>; Sun, 13 Dec 2009 19:29:34 -0800 (PST)
In-Reply-To: <4B2241D0.3050504@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Samu Onkalo <samu.p.onkalo@nokia.com>, Eric Piel <eric.piel@tremplin-utc.net>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>

Jonathan Cameron wrote:
> Hi Matt
>   
> Gah, Not again!  So far we have had two patch sets implementing just
> this.  Looking at the latest from Samu, Eric's patch has been sent on
> to Andrew Morton for the current merge window (and is listed as being in
> his mm tree).  May even have merged since I last pulled mainline.
>
> You have my sympathies as the whole duplicating work thing happens to
> us all from time to time.  The answer is as ever, post early and post
> often to the relevant mailing lists. (though of course hardly anyone
> actually keeps to this!)
>   
    Hi Jonathan,

    Thanks for your information.
    Previously, I only went through input subsystem instead of lm-sensors.
    And now the upstream driver seems to be implemented and merged. I 
will cherry pick them into 0xlab kernel repository.

    Cheers,
    Matt
> I've cc'd in everyone I know has an interest in this driver for any
> thing else they might want to add.
>
> Jonathan
>   

