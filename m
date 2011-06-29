From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 07/12] HID: wiimote: Add output queue for wiimote driver
Date: Wed, 29 Jun 2011 14:53:49 +0200
Message-ID: <BANLkTi=U4HPStOFYbZs7Z1gVgapjer33Nw@mail.gmail.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
	<1309185013-484-7-git-send-email-dh.herrmann@googlemail.com>
	<6467e906-9828-44e1-a903-1ceda41112fd@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48338 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab1F2Mxu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 08:53:50 -0400
Received: by vxb39 with SMTP id 39so842592vxb.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 05:53:49 -0700 (PDT)
In-Reply-To: <6467e906-9828-44e1-a903-1ceda41112fd@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

On Tue, Jun 28, 2011 at 6:51 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>
> avid Herrmann <dh.herrmann@googlemail.com> wrote:
>
>>The raw hid output function that is supported by bluetooth low-level
>>hid driver does not provide an output queue and also may sleep. The
>>wiimote driver, though, may need to send data in atomic context so
>>this patch adds a buffered output queue for the wiimote driver.
>>
>>We use the shared workqueue to send our buffer to the hid device.
>>There is always only one active worker which reschedules itself until
>>the wiimote queue is empty. This prevents the worker from occupying
>>the shared workqueue for too long.
>
> With CWQ this is not a concern anymore, you should be able to flush your buffer at once.

Thanks, I wasn't sure about this. I've now changed:
-       if (wdata->head != wdata->tail) {
+       while (wdata->head != wdata->tail) {
and removed the if(...) schedule_work(...);

> --
> Dmitry

Regards
David
