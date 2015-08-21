From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] Input: xpad - Fix double URB submission races
Date: Fri, 21 Aug 2015 09:50:58 -0700
Message-ID: <20150821165058.GG26302@localhost>
References: <1439252772-28482-1-git-send-email-labbott@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33657 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbHUQvB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 12:51:01 -0400
Content-Disposition: inline
In-Reply-To: <1439252772-28482-1-git-send-email-labbott@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@fedoraproject.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hi Laura,

On Mon, Aug 10, 2015 at 05:26:12PM -0700, Laura Abbott wrote:
> v2: Created a proper queue for events instead of just dropping them

How long does it take for the queue to exhaust your memory if you keep
bombarding the driver with requests?

I do not think you need a queue. I believe the nature of LEDs and rumble
force feedback effect is such that you can discard all requests but the
latest that arrived between the moment you submitted a request to the
device and the moment you are ready submit a new one.

Thanks.

-- 
Dmitry
