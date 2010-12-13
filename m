From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/2] hid-mosart: support suspend/resume
Date: Mon, 13 Dec 2010 09:52:11 -0800
Message-ID: <4D065D4B.2070203@canonical.com>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr> <1292252353-3029-3-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34423 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613Ab0LMRwQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 12:52:16 -0500
In-Reply-To: <1292252353-3029-3-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On 12/13/2010 06:59 AM, Benjamin Tissoires wrote:
> The device has 2 modes. The first one is an emulation of a touchscreen
> by sending left and right button, and the second mode is the one used in
> dual-touch (sending trackingID, touch and else).
> 
> In case of a suspend/resume, the device switch back to the first mode
> described above (with left and right buttons).
> This adds a hook in .reset_resume for the device to be switched to
> the correct mode (I just copied the code in mosart_probe).
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Acked-by: Chase Douglas <chase.douglas@canonical.com>

Please add "Cc: stable@kernel.org" here too.

Thanks!

-- Chase
