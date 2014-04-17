From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] synaptics: Add min/max quirk for ThinkPad T431s,
 L440, L540, S1 Yoga and X1
Date: Thu, 17 Apr 2014 08:35:00 -0700
Message-ID: <20140417153500.GA17495@core.coreip.homeip.net>
References: <1397734903-26088-1-git-send-email-hdegoede@redhat.com>
 <1397734903-26088-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:37025 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaDQPfF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 11:35:05 -0400
Content-Disposition: inline
In-Reply-To: <1397734903-26088-2-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Hans,

On Thu, Apr 17, 2014 at 01:41:43PM +0200, Hans de Goede wrote:
> We expect that all the Haswell series will need such quirks, sigh.

Given this statement do we really want this to be handled in kernel?
Maybe we simply want udev to fix up the limits with EVIOSABS(),
similarly to how we adjust keymaps for laptops?

Thanks.

-- 
Dmitry
