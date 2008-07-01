From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]suspend/resume support for yealink
Date: Tue, 1 Jul 2008 08:04:27 +0200
Message-ID: <200807010804.27758.oliver@neukum.org>
References: <200806301608.03788.oliver@neukum.org> <1214862428.6977.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:35405 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYGAGD5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 02:03:57 -0400
In-Reply-To: <1214862428.6977.27.camel@localhost>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Reitmayr <treitmayr@devbase.at>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Henk.Vergonet@gmail.com

Am Montag 30 Juni 2008 23:47:08 schrieb Thomas Reitmayr:
> Hi Oliver,
> I tested the suspend/resume support with my Yealink USB-P1K doing the
> following:
> 
> * Suspend to RAM:
>   The device suspends properly, I hear the audio subsystem turning off
> while the display keeps its current state.
>   Apparently the USB root hub gets reset during suspend/resume according
> to the kernel log. Then after resume the input events are generated
> again and the display can be updated. I noticed however that the display
> is reset to its default text, possibly because of the USB reset? Anyway,
> I appended a filtered kernel log about this scenario below.

Yes, the reset triggers a disconnect because the driver doesn't implement
reset_resume().

> * Suspend the device by "echo suspend > power/level"
>   Works too with the difference that the display is not modified during
> resume.

OK, it works. Thank you for testing.

	Regards
		Oliver
