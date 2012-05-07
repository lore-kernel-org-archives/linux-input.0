From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Add LED selector control for Wacom Intuos4
 WL
Date: Mon, 07 May 2012 14:18:36 +0100
Message-ID: <1336396716.7118.2.camel@pldmachine>
References: <1336395218-6865-1-git-send-email-przemo@firszt.eu>
	 <alpine.LNX.2.00.1205071508280.26736@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:57867 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753449Ab2EGNSk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 09:18:40 -0400
In-Reply-To: <alpine.LNX.2.00.1205071508280.26736@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: pinglinux@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

Dnia 2012-05-07, pon o godzinie 15:09 +0200, Jiri Kosina pisze:
> On Mon, 7 May 2012, Przemo Firszt wrote:
[..]
> Przemo,
> 
> is there a particular reason for not using LEDS_CLASS for this, please?
Hi Jiri,
No, I just used the same approach as wacom USB driver. I'll change that.
Thanks!
-- 
Przemo Firszt <przemo@firszt.eu>

