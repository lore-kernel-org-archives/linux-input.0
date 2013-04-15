From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Adding graceful shutdown to sysrq key reset
Date: Mon, 15 Apr 2013 13:45:36 -0700
Message-ID: <20130415204535.GB4374@core.coreip.homeip.net>
References: <1365169112-7999-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61359 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3DOUpt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Apr 2013 16:45:49 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so2701163pdj.2
        for <linux-input@vger.kernel.org>; Mon, 15 Apr 2013 13:45:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365169112-7999-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-input@vger.kernel.org, arve@android.com, kernel-team@android.com, john.stultz@linaro.org

Hi Mathieu,

On Fri, Apr 05, 2013 at 07:38:32AM -0600, mathieu.poirier@linaro.org wrote:
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> 
> Attempt to reboot the system gracefully when a key combo
> is detected.  The system is force to go down if the first
> attempt failed and the key combo is pressed a second time.
> 

If system can gracefully shutdown can;t we request it through normal
means?

Thanks.

-- 
Dmitry
