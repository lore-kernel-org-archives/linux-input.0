From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: wacom: Add fuzz and scale features
Date: Thu, 2 Sep 2010 13:26:56 -0700
Message-ID: <20100902202655.GB22482@core.coreip.homeip.net>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
 <1283451517-1711-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54656 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab0IBU1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 16:27:01 -0400
Received: by iwn5 with SMTP id 5so805361iwn.19
        for <linux-input@vger.kernel.org>; Thu, 02 Sep 2010 13:27:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283451517-1711-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

Hi Henrik,

On Thu, Sep 02, 2010 at 08:18:35PM +0200, Henrik Rydberg wrote:
> The signal-to-noise ratio varies between devices, but currently all
> devices are treated the same way. In addition, some devices report
> very low resolution, which makes the fuzz algorithm ineffective.
> Add fuzz and scale parameters to the feature struct, allowing for
> tailored treatment of devices.
> 

While we may adjust fuzz depending on the resolution scaling of the
data is not kernel's task and should be left to userspace.

Thanks.

-- 
Dmitry
