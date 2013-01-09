From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hid-samsung: Fix checkpatch errors
Date: Wed, 9 Jan 2013 15:33:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301091532470.12134@pobox.suse.cz>
References: <1357721803-31363-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49873 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab3AIOdq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jan 2013 09:33:46 -0500
In-Reply-To: <1357721803-31363-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On Wed, 9 Jan 2013, Sachin Kamat wrote:

> Fixes the following type of checkpatch errors:
> ERROR: trailing statements should be on next line
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

I am not applying this, sorry.

This format has been used in hid-input.c ages before checkpactch has been 
introduced. Look at hidinput_configure_usage(). I don't think splitting 
the lines makes this particular case more readable.

Thanks,

-- 
Jiri Kosina
SUSE Labs
