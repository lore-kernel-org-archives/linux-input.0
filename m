From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB bus
Date: Mon, 11 Feb 2013 12:22:11 +0100
Message-ID: <CAN+gG=ECOFVjeWtgxixd6iMdp5HkSBJQE3LPzsLtowjY6D=4tA@mail.gmail.com>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
	<1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:46015 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3BKLWN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 06:22:13 -0500
In-Reply-To: <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

On Mon, Feb 11, 2013 at 11:31 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> We now have two transport mediums: USB and I2C, where sensor hubs can
> exists. So instead of constraining the driver to only these two we let it
> to match any HID bus as long as the group is HID_GROUP_SENSOR_HUB.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Mika for this series!

Cheers,
Benjamin
