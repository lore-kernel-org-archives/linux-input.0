From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: multi-input quirk and skip output reports quirk
Date: Tue, 1 Apr 2008 16:12:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804011610450.5541@jikos.suse.cz>
References: <47F21BA7.8030306@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40387 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754939AbYDAOMS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2008 10:12:18 -0400
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

Hi Anssi,

as long as we still have the possibility to see the coming data in debug 
mode, I don't have objection to that.

Are you going to make that patch?

Thanks,

-- 
Jiri Kosina
