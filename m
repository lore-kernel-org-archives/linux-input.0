From: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.26-rc3 - appletouch resume "incomplete data package"
Date: Mon, 26 May 2008 14:29:33 +0200
Message-ID: <200805261429.34566.oliver@neukum.org>
References: <b6c5339f0805251324k70a3a56ci9cab5274acc2d01d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:55595 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbYEZM3b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2008 08:29:31 -0400
In-Reply-To: <b6c5339f0805251324k70a3a56ci9cab5274acc2d01d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bob Copeland <me@bobcopeland.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Am Sonntag 25 Mai 2008 22:24:13 schrieb Bob Copeland:
> This appears to be a regression since 2.6.25.  After resuming, I get:
> 
>     appletouch: incomplete data package (first byte: 2, length: 4).
>     appletouch: incomplete data package (first byte: 2, length: 4).
>     appletouch: incomplete data package (first byte: 2, length: 4).
>     [...]
> 
> And the touchpad doesn't work.  This is on a first gen MacBook.  I
> didn't see any changes to the driver itself in that timeframe.
> Anyone have ideas, or should I try a bisect?
> 

Can you add a RESET_RESUME quirk for the device?

	Regards
		Oliver

