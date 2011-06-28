From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/12] HID: wiimote: Add output queue for wiimote driver
Date: Tue, 28 Jun 2011 08:51:16 +0400
Message-ID: <6467e906-9828-44e1-a903-1ceda41112fd@email.android.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com> <1309185013-484-7-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52792 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512Ab1F1Ev3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 00:51:29 -0400
Received: by pzk9 with SMTP id 9so3372684pzk.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 21:51:28 -0700 (PDT)
In-Reply-To: <1309185013-484-7-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org



avid Herrmann <dh.herrmann@googlemail.com> wrote:

>The raw hid output function that is supported by bluetooth low-level
>hid driver does not provide an output queue and also may sleep. The
>wiimote driver, though, may need to send data in atomic context so
>this patch adds a buffered output queue for the wiimote driver.
>
>We use the shared workqueue to send our buffer to the hid device.
>There is always only one active worker which reschedules itself until
>the wiimote queue is empty. This prevents the worker from occupying
>the shared workqueue for too long. 

With CWQ this is not a concern anymore, you should be able to flush your buffer at once.
-- 
Dmitry
