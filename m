From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Tue, 28 Jun 2011 09:49:11 +0400
Message-ID: <ca4e286b-420b-4d36-bb97-243dcdc9a527@email.android.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com> <1309185013-484-5-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51684 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671Ab1F1Fta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 01:49:30 -0400
Received: by iyb12 with SMTP id 12so4663304iyb.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 22:49:29 -0700 (PDT)
In-Reply-To: <1309185013-484-5-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org



David Herrmann <dh.herrmann@googlemail.com> wrote:

>The wiimote first starts HID hardware and then registers the input
>device. We need to synchronize the startup so no event handler will
>start parsing events when the wiimote device is not ready, yet.
>

I believe this is generic HID layer problem. Would it be possible to fix this issue there?

Thanks.

-- 
Dmitry
