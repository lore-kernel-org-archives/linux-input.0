From: Matt Whitlock <linux@mattwhitlock.name>
Subject: Re: [PATCH] Input: bcm5974 - report highest finger pressure to Synaptics
Date: Wed, 03 Jun 2015 08:31:03 -0400
Message-ID: <119471698.ELkjzU3HSk@crushinator>
References: <1433332165-25342-1-git-send-email-linux@mattwhitlock.name> <556EF1F2.50907@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:39805 "EHLO
	resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933033AbbFCMjV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 08:39:21 -0400
In-Reply-To: <556EF1F2.50907@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wednesday, 3 June 2015, at 2:24 pm, Henrik Rydberg wrote:
> > This patch changes the report_synaptics_data() function so that it reports
> > the highest touch_major and highest tool_major of any touching finger as
> > ABS_PRESSURE and ABS_TOOL_WIDTH, respectively.
> 
> I appreciate the problem, but I would much rather have bcm5974 converted
> to use input_mt_report_pointer_emulation() instead. The emulation code
> has been left as is for a long while, but this seems to be a good time
> to convert it.

report_tp_state() calls input_mt_sync_frame(), which in turn calls input_mt_report_pointer_emulation() already. So does this mean that report_synaptics_data() can be removed entirely?
