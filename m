From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 16:38:38 +0200
Message-ID: <201110121638.38747.oliver@neukum.org>
References: <20111012135439.GA25266@srcf.ucam.org> <Pine.LNX.4.44L0.1110121014550.2093-100000@iolanthe.rowland.org> <20111012142621.GA25803@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44560 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1JLOiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 10:38:18 -0400
In-Reply-To: <20111012142621.GA25803@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Am Mittwoch, 12. Oktober 2011, 16:26:21 schrieb Matthew Garrett:
> Sorry, yes, you're right. In that case it's probably working for me 
> because the keyboard is another interface on the same device, so the 
> wakeup bit is being set from there.

Very good. A mystery is solved. Indeed you may have found
a deficiency in the USB spec.

	Regards
		Oliver
