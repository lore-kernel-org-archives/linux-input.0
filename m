From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 08:37:46 +0200
Message-ID: <201110070837.46926.oliver@neukum.org>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com> <20111006223835.GA30738@core.coreip.homeip.net> <20111006231954.GA32029@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:37421 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab1JGGuB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 02:50:01 -0400
In-Reply-To: <20111006231954.GA32029@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, rydberg@euromail.se

Am Freitag, 7. Oktober 2011, 01:19:54 schrieb Matthew Garrett:
> You're completely right. I have absolutely no idea how I missed that - I 
> checked and didn't find any other puts. I'll fix and resend.

Please also note that for a device to generate wakeup events the kernel has to
enable them which drivers have to request, like the usbhid driver does.
If you do this you better have a test device, because I found that most
generic mice generate wakeup events only if you press a button, not move
the mouse. We are simply not equipped in our API to use that capability.

	Regards
		Oliver
