From: Matt Whitlock <linux@mattwhitlock.name>
Subject: Re: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove redundant emulation code
Date: Mon, 06 Jul 2015 14:37:24 -0400
Message-ID: <7271343.oGOpcDThz2@crushinator>
References: <556EF8AB.6090704@bitmath.org> <1433812075-16622-1-git-send-email-linux@mattwhitlock.name> <1433812075-16622-2-git-send-email-linux@mattwhitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:44313 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753492AbbGFSha (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jul 2015 14:37:30 -0400
In-Reply-To: <1433812075-16622-2-git-send-email-linux@mattwhitlock.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

It's been four weeks, and I haven't heard back on this patch. I believe I've implemented what was requested. Is there a problem with it?


On Monday, 8 June 2015, at 9:07 pm, Matt Whitlock wrote:
> Now that input_mt_report_pointer_emulation() can synthesize ABS_TOOL_WIDTH
> from ABS_MT_WIDTH_MAJOR, the report_synaptics_data() function in bcm5974.c
> is entirely redundant. This patch removes this function and introduces
> reporting of ABS_MT_PRESSURE (faked from f->touch_major) to cause the
> emulation code to synthesize ABS_PRESSURE.
> 
> Signed-off-by: Matt Whitlock <linux@mattwhitlock.name>
