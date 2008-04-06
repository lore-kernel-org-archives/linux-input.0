From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Sun, 6 Apr 2008 10:06:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804061003490.26562@twin.jikos.cz>
References: <47F21BA7.8030306@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:46028 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbYDFIGI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Apr 2008 04:06:08 -0400
In-Reply-To: <47F21BA7.8030306@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 1 Apr 2008, Anssi Hannula wrote:

> I've encountered another multi-input device that needs the skip output 
> reports quirk (as it contains force feedback output reports), 0925:8866.
> However, maybe we should use another approach, dropping
> HID_QUIRK_SKIP_OUTPUT_REPORTS. Why not just *not* register the input
> device for that report in case the report didn't contain anything that
> was mapped by hidinput_configure_usage(), in hidinput_connect()?

Oh, and I seem to have completely forgotten -- is this quirk needed at 
all? Since commit 82eb12198 we ignore the non-LED output reports in 
hidinput_configure_usages() altogether.

Do you still actually see issues of devices being misconfigured due to 
output reports confusion in hidinput_configure_usage() even in kernels 
having this commit included?

Thanks,

-- 
Jiri Kosina
SUSE Labs

