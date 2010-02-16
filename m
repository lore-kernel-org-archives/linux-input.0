From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] rfkill: Add support for KEY_RFKILL
Date: Tue, 16 Feb 2010 15:04:45 -0800
Message-ID: <1266361485.8849.27.camel@localhost.localdomain>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
	 <1266356185-10324-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56054 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933276Ab0BPXGG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 18:06:06 -0500
In-Reply-To: <1266356185-10324-2-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Matthew,

> Add support for handling KEY_RFKILL in the rfkill input module. This
> simply toggles the state of all rfkill devices. The comment in rfkill.h
> is also updated to reflect that RFKILL_TYPE_ALL may be used inside the
> kernel.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


