From: przemo@firszt.eu
Subject: Re: [PATCH] HID: wacom: Fix invalid power_supply_powers calls
Date: Mon, 6 Feb 2012 12:34:57 -0000
Message-ID: <d2139519eb66f9b7bfd8f56d3b4e2d96.squirrel@webmail.firszt.eu>
References: <1328481324-7241-1-git-send-email-przemo@firszt.eu>
    <alpine.LNX.2.00.1202061326150.24127@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:35440 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754440Ab2BFMfU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2012 07:35:20 -0500
In-Reply-To: <alpine.LNX.2.00.1202061326150.24127@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Przemo Firszt <przemo@firszt.eu>, chris@cnpbagwell.com, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>

> On Sun, 5 Feb 2012, Przemo Firszt wrote:
[..]
> Hmm, seems valid. How did you notice? Have you seen crashes because of
> wild pointers?

Hi Jiri,
Yes, the driver was unusable - 100% crashes during connection.

Chris came up with the solution, I did coding & testing.

The crash details are here:  http://pastebin.com/ZVNZWaPs

regards,
Przemo

