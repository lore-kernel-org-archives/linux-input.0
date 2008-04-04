From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suspend
Date: Fri, 4 Apr 2008 10:59:09 +0200
Message-ID: <200804041059.10276.oliver@neukum.org>
References: <200804032242.36493.oliver@neukum.org> <Pine.LNX.4.44L0.0804031740100.5410-100000@iolanthe.rowland.org> <e79639220804031506p656e866ardaf5bbefa218b69a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59400 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYDDJD4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 05:03:56 -0400
In-Reply-To: <e79639220804031506p656e866ardaf5bbefa218b69a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schweizer <genstef@gentoo.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Freitag, 4. April 2008 00:06:48 schrieb Stefan Schweizer:
> Hi,
> 
> the problem was that I did not identify the correct /sys entry. Anyways with
> 
> for i in $(find /sys -name persist); do echo 1 > '$i'; done
> 
> it works perfectly :-)
> 
> Thank you very much! Finally working touchpad after resume :-)

Good. Did you test the first patch or the second? Can you test whether
the device autosuspends with the combined patch I sent you?

	Regards
		Oliver
