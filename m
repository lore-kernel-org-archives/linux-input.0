From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/15] Input: xpad: move the input device creation to a
 new function
Date: Sat, 17 Oct 2015 09:49:33 -0700
Message-ID: <20151017164933.GD13470@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-8-git-send-email-rojtberg@gmail.com>
 <20151010180015.GI39573@dtor-ws>
 <561FFC47.3060802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33482 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbJQQth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 12:49:37 -0400
Received: by pabrc13 with SMTP id rc13so148887587pab.0
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2015 09:49:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561FFC47.3060802@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

Hi Pavel,

On Thu, Oct 15, 2015 at 09:19:35PM +0200, Pavel Rojtberg wrote:
> Hey Dimitry,
> 
> I have seen you have also applied
> "[PATCH 08/15] Input: xpad: query Wireless controller state at init".
> However this change is unfortunately incomplete without
> "[PATCH 09/15] Input: xpad: handle "present" and "gone" correctly".
> 
> As is both the presence as well as the LED packets are sent
> immediately at init
> which triggers the the "URB xxxx submitted while active" Warning and causes
> any initialization to fail.
> 
> Attached is a fixup against current input/ next of the chunk that is in
> [PATCH 09/15], but should have been in [PATCH 08/15].
> Sorry for the inconvenience.
> 
> do not call xpad_identify_controller at init: it conflicts with
> the already sent presence packet and will be called by
> xpad360w_process_packet as needed anyway.

I see. But I believe we should only do that for wireless controllers,
because we send the presence request only for XTYPE_XBOX360W and LEDs
are also present on non-wireless variant, right?

So I think we want:

	if (xpad->xtype == XTYPE_XBOX360) {
		/*
		 * Light up the segment corresponding to controller
		 * number on wired devices. On wireless we'll do that
		 * when they respond to "presence" packet.
		 */
		xpad_identify_controller(xpad);
	}

Thanks.

-- 
Dmitry
