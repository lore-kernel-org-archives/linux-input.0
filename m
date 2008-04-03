From: "Stefan Schweizer" <genstef@gentoo.org>
Subject: Re: suspend
Date: Fri, 4 Apr 2008 00:06:48 +0200
Message-ID: <e79639220804031506p656e866ardaf5bbefa218b69a@mail.gmail.com>
References: <200804032242.36493.oliver@neukum.org>
	 <Pine.LNX.4.44L0.0804031740100.5410-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:60460 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYDCWGs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 18:06:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1852773rvb.1
        for <linux-input@vger.kernel.org>; Thu, 03 Apr 2008 15:06:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.0804031740100.5410-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi,

the problem was that I did not identify the correct /sys entry. Anyways with

for i in $(find /sys -name persist); do echo 1 > '$i'; done

it works perfectly :-)

Thank you very much! Finally working touchpad after resume :-)

Best regards,
Stefan
