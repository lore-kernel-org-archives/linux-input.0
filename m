From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v1 23/49] hid: usbhid: prepare for enabling irq in complete()
Date: Thu, 22 Aug 2013 20:19:27 +0800
Message-ID: <CACVXFVPes_UE1gJ_DuifKTMNOvDv0cwm5k=Ea03TB05rDzKBEA@mail.gmail.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
	<1376756714-25479-24-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57207 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab3HVMTa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 08:19:30 -0400
In-Reply-To: <1376756714-25479-24-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb <linux-usb@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <ming.lei@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Sun, Aug 18, 2013 at 12:24 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Complete() will be run with interrupt enabled, so change to
> spin_lock_irqsave().
>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Jiri, could you review and give an Ack?


Thanks,
--
Ming Lei
