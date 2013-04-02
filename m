From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] sysrq: supplementing reset sequence with timeout
 functionality
Date: Mon, 1 Apr 2013 22:16:38 -0700
Message-ID: <20130402051638.GA21123@core.coreip.homeip.net>
References: <1364844711-32302-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:44731 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3DBFQm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Apr 2013 01:16:42 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so25660daj.36
        for <linux-input@vger.kernel.org>; Mon, 01 Apr 2013 22:16:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364844711-32302-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: arve@android.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

On Mon, Apr 01, 2013 at 01:31:51PM -0600, mathieu.poirier@linaro.org wrote:
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> 
> Some devices have too few buttons, which it makes it hard to have
> a reset combo that won't trigger automatically.  As such a
> timeout functionality that requires the combination to be held for
> a given amount of time before triggering is introduced.
> 
> If a key combo is recognized and held for a 'timeout' amount of time,
> the system triggers a reset.  If the timeout value is omitted the
> driver simply ignores the functionality.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Applied, thank you Mathieu.

-- 
Dmitry
