From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Tue, 01 Apr 2008 17:15:24 +0300
Message-ID: <47F2437C.6060203@gmail.com>
References: <47F21BA7.8030306@gmail.com> <Pine.LNX.4.64.0804011610450.5541@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:60151 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633AbYDAOP1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2008 10:15:27 -0400
In-Reply-To: <Pine.LNX.4.64.0804011610450.5541@jikos.suse.cz>
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
> Hi Anssi,
> 
> as long as we still have the possibility to see the coming data in debug 
> mode, I don't have objection to that.

Okay.

> Are you going to make that patch?

Not right now, maybe in a few weeks.

-- 
Anssi Hannula
