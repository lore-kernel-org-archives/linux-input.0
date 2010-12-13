From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] hid-mosart: support suspend/resume
Date: Mon, 13 Dec 2010 19:56:59 +0100
Message-ID: <4D066C7B.8060109@euromail.se>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr> <1292252353-3029-3-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:50283 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899Ab0LMS5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 13:57:50 -0500
In-Reply-To: <1292252353-3029-3-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

On 12/13/2010 03:59 PM, Benjamin Tissoires wrote:

> The device has 2 modes. The first one is an emulation of a touchscreen
> by sending left and right button, and the second mode is the one used in
> dual-touch (sending trackingID, touch and else).
> 
> In case of a suspend/resume, the device switch back to the first mode
> described above (with left and right buttons).
> This adds a hook in .reset_resume for the device to be switched to
> the correct mode (I just copied the code in mosart_probe).


Defining a static function for the mode switch would be nice.

Thanks,
Henrik
