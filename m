From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Mon, 14 Nov 2011 11:43:51 +0100
Message-ID: <201111141143.52120.marek.vasut@gmail.com>
References: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com> <201111140015.30787.marek.vasut@gmail.com> <alpine.LNX.2.00.1111140945520.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38109 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab1KNKn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 05:43:56 -0500
Received: by fagn18 with SMTP id n18so2856129fag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 02:43:55 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111140945520.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, chris@cnpbagwell.com, linux-input@vger.kernel.org

> On Mon, 14 Nov 2011, Marek Vasut wrote:
> > Well there's another one in Acer W500. But that one handles 5
> > simulaneous MT events. I submitted a patch already, but it was held
> > because ... I dunno why anymore.
> 
> Hmm, I don't recall seeing that one. Could you please resubmit? Thanks,

I'm just rebuilding 3.1.0+ kernel with the patch so I can resubmit it rebased 
against fresh kernel. There was some discussion about detecting how many 
fingers/points does the device support, so I'm also testing with that.

M
