From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Sun, 06 Apr 2008 17:12:40 +0300
Message-ID: <47F8DA58.10705@gmail.com>
References: <47F21BA7.8030306@gmail.com> <Pine.LNX.4.64.0804061003490.26562@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:33936 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbYDFOMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Apr 2008 10:12:42 -0400
In-Reply-To: <Pine.LNX.4.64.0804061003490.26562@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Tue, 1 Apr 2008, Anssi Hannula wrote:
> 
>> I've encountered another multi-input device that needs the skip output 
>> reports quirk (as it contains force feedback output reports), 0925:8866.
>> However, maybe we should use another approach, dropping
>> HID_QUIRK_SKIP_OUTPUT_REPORTS. Why not just *not* register the input
>> device for that report in case the report didn't contain anything that
>> was mapped by hidinput_configure_usage(), in hidinput_connect()?
> 
> Oh, and I seem to have completely forgotten -- is this quirk needed at 
> all? Since commit 82eb12198 we ignore the non-LED output reports in 
> hidinput_configure_usages() altogether.
> 
> Do you still actually see issues of devices being misconfigured due to 
> output reports confusion in hidinput_configure_usage() even in kernels 
> having this commit included?

Yes.

The point was that hidinput_connect() doesn't care whether all reports
were ignored by hidinput_configure_usage() or not.

-- 
Anssi Hannula
