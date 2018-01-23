From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: quirks: Fix keyboard + touchpad on Toshiba Click
 Mini not working
Date: Tue, 23 Jan 2018 15:48:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231548040.11852@cbobk.fhfr.pm>
References: <20180117200555.22990-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51391 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbeAWOsO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 09:48:14 -0500
In-Reply-To: <20180117200555.22990-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, 17 Jan 2018, Hans de Goede wrote:

> The Toshiba Click Mini uses an i2c attached keyboard/touchpad combo
> (single i2c_hid device for both) which has a vid:pid of 04F3:0401,
> which is also used by a bunch of Elan touchpads which are handled by the
> drivers/input/mouse/elan_i2c driver, but that driver deals with pure
> touchpads and does not work for a combo device such as the one on the
> Toshiba Click Mini.
> 
> The combo on the Mini has an ACPI id of ELAN0800, which is not claimed
> by the elan_i2c driver, so check for that and if it is found do not ignore
> the device. This fixes the keyboard/touchpad combo on the Mini not working
> (although with the touchpad in mouse emulation mode).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

