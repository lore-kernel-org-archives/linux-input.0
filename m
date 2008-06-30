From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: push down scancode negative checking
Date: Mon, 30 Jun 2008 15:47:28 -0400
Message-ID: <20080630154701.ZZRA012@mailhub.coreip.homeip.net>
References: <1214854426-20442-1-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:46328 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764257AbYF3Trc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 15:47:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so30569yxm.1
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 12:47:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1214854426-20442-1-git-send-email-dwalker@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 12:33:46PM -0700, Daniel Walker wrote:
> The getkeycode/setkeycode calls should be able to accept "negative" values.
> 
> The HID layer has some scan codes of the form 0xffbc0000 for logitech
> devices, and they get ignored by these calls. I pushed the checking
> into the input_default_* functions since they do need non-negative
> values.
> 
> I also corrected a typo in the comment for input_set_keycode

Hmm, I wonder if we just need to type these as unsigned.

-- 
Dmitry
