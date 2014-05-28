From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: Set report quirk for Microsoft
 Surface
Date: Wed, 28 May 2014 16:29:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405281629330.17241@pobox.suse.cz>
References: <1401175750-3008-1-git-send-email-reyad.attiyat@gmail.com> <alpine.LNX.2.00.1405281541100.17241@pobox.suse.cz> <20140528135358.GA27859@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58807 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbaE1O3u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 10:29:50 -0400
In-Reply-To: <20140528135358.GA27859@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 28 May 2014, Benjamin Tissoires wrote:

> I guess this should be fine:
> f3b0cbce01 has no more impact (there is no USB_DEVICE_ID_MS_*_2
> anymore)
> 
> e24d0d399b2f will properly add the HID_GROUP_SENSOR_HUB to the sensors
> if the report descriptor is properly set.
> 
> Given that the group SENSOR_HUB will be set, no other hid driver will
> pick them, so this patch just adds the HID_SENSOR_HUB_ENUM_QUIRK to the
> actual sensors in the surface 2.
> 
> So:
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
