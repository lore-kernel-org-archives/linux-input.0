From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] HID: hid-led: add support for Delcom Visual Signal
 Indicator G2
Date: Mon, 4 Jul 2016 21:05:24 +0200
Message-ID: <c924280c-88e6-5f9a-8d06-71fd243996cb@gmail.com>
References: <9cf86442-7038-4513-b3d9-fb127030e60b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35318 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbcGDTFa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2016 15:05:30 -0400
Received: by mail-wm0-f41.google.com with SMTP id z126so51443151wme.0
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2016 12:05:29 -0700 (PDT)
In-Reply-To: <9cf86442-7038-4513-b3d9-fb127030e60b@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Am 03.07.2016 um 17:42 schrieb Heiner Kallweit:
> Add support for the HID-compliant Delcom Visual Signal Indicator
> generation 2 devices.
> 
> Successfully tested with part no 904000 from the family of these devices.
> 
I forgot to update the help info for HID_LED in Kconfig.
Will send a v2 also including another change.

