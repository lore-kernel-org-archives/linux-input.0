From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: bcm5974 - report highest finger pressure to Synaptics
Date: Wed, 03 Jun 2015 14:24:18 +0200
Message-ID: <556EF1F2.50907@bitmath.org>
References: <1433332165-25342-1-git-send-email-linux@mattwhitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.public.one.com ([91.198.169.124]:61388 "EHLO
	mailrelay1.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbbFCMk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 08:40:28 -0400
In-Reply-To: <1433332165-25342-1-git-send-email-linux@mattwhitlock.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Whitlock <linux@mattwhitlock.name>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Matt,

> This patch changes the report_synaptics_data() function so that it reports
> the highest touch_major and highest tool_major of any touching finger as
> ABS_PRESSURE and ABS_TOOL_WIDTH, respectively.

I appreciate the problem, but I would much rather have bcm5974 converted
to use input_mt_report_pointer_emulation() instead. The emulation code
has been left as is for a long while, but this seems to be a good time
to convert it.

Thanks,
Henrik

