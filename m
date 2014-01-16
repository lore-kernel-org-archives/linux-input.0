From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] HID: logitech-dj: Fix USB 3.0 issue
Date: Thu, 16 Jan 2014 22:50:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401162249150.23018@pobox.suse.cz>
References: <1389219529-29671-1-git-send-email-benjamin.tissoires@redhat.com> <1389219529-29671-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53278 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaAPVuJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 16:50:09 -0500
In-Reply-To: <1389219529-29671-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Andrew de los Reyes <adlr@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 8 Jan 2014, Benjamin Tissoires wrote:

> From: Benjamin Tisssoires <benjamin.tissoires@redhat.com>
> 
> This fix (not very clean though) should fix the long time USB3
> issue that was spotted last year. The rational has been given by
> Hans de Goede:

Man this is so ugly ... makes one wonder how come that other OSes don't 
suffer from this. Are they really *that much* slower? :)

I have applied this (and just this) one for 3.14.

Thanks,

-- 
Jiri Kosina
SUSE Labs
