From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Tue, 16 Feb 2010 15:05:19 -0800
Message-ID: <1266361519.8849.28.camel@localhost.localdomain>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56057 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933276Ab0BPXGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 18:06:39 -0500
In-Reply-To: <1266356185-10324-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Matthew,

> Most laptops have keys that are intended to toggle all device state, not
> just wifi. These are currently generally mapped to KEY_WLAN. As a result,
> rfkill will only kill or enable wifi in response to the key press. This
> confuses users and can make it difficult for them to enable bluetooth
> and wwan devices.
> 
> This patch adds a new keycode, KEY_RFKILL. It indicates that the system
> should toggle the state of all rfkillable devices.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


