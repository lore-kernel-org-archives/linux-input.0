From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 11/40] Input: atmel_mxt_ts - Bootloader addresses for
 mXT1664/mXT1188S
Date: Fri, 22 Feb 2013 19:51:28 +0000
Message-ID: <5127CC40.6070507@itdev.co.uk>
References: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk> <1361555907-19840-12-git-send-email-nick.dyer@itdev.co.uk> <CANLzEkusmqAFSybWd+xbLYbUu+5rcih7AW024eCpZ7AFb-+UCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.133] ([89.21.227.133]:32241 "EHLO
	mail.kdh.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756892Ab3BVTva (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Feb 2013 14:51:30 -0500
In-Reply-To: <CANLzEkusmqAFSybWd+xbLYbUu+5rcih7AW024eCpZ7AFb-+UCw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Olof Johansson <olofj@chromium.org>, Yufeng Shen <miletus@chromium.org>

Benson Leung wrote:
> This is disappointing that Atmel decided to change the bootloader 
> address scheme for the 1664S family. Unfortunately, this ifdef won't 
> work for situations where there are more than one Atmel device of a 
> different kind on a system using this same driver.
> 
> For the Chromebook Pixel, we use the same atmel_mxt_ts driver for a 
> 1664S device and a 224SL.
> 
> The 1664S has the pair 0x26 and 0x4a, while the 224SL has 0x25 and
> 0x4b.

If I put a bootloader address override in the platform data will that meet
your requirements?
