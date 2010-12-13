From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/2] Input: synaptics - emit multitouch data
Date: Mon, 13 Dec 2010 15:14:45 -0800
Message-ID: <4D06A8E5.90808@canonical.com>
References: <1292280948-1933-1-git-send-email-rydberg@euromail.se> <1292280948-1933-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57751 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab0LMXOv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 18:14:51 -0500
In-Reply-To: <1292280948-1933-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/13/2010 02:55 PM, Henrik Rydberg wrote:
> In multitouch mode, two data packets are sent from the device.  Due to
> limitations in the hardware detection mechanism, individual contacts
> cannot be reliably extracted. However, the bounding rectangle of the
> individual contacts can be accurately reproduced. This patch emits the
> MT data as envelope coordinates, allowing userspace to track the
> bounding rectangle and produce appropriate gestures.
> 
> Acked-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

I agree with the patch in theory, but I still have reservations about
MT_TOOL_ENVELOPE. Once that's sorted out I'll add my ACK.

Thanks,

-- Chase
