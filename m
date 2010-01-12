From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers
Date: Tue, 12 Jan 2010 00:30:32 -0800
Message-ID: <20100112083031.GA3252@core.coreip.homeip.net>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com>
 <20091221181959.GA6696@core.coreip.homeip.net>
 <BD79186B4FD85F4B8E60E381CAEE19090200F172@mi8nycmail19.Mi8.com>
 <BD79186B4FD85F4B8E60E381CAEE19090200F17C@mi8nycmail19.Mi8.com>
 <BD79186B4FD85F4B8E60E381CAEE190902089963@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57184 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0ALIaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 03:30:39 -0500
Received: by pzk1 with SMTP id 1so6012455pzk.33
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2010 00:30:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089963@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

Hi Hartley,

On Mon, Jan 11, 2010 at 03:48:48PM -0500, H Hartley Sweeten wrote:
> Ping... Any comments on this Dmitry?
> 

I will apply this patch to by 'next' branch for .34. Regarding the
other part with changes to interrupt handler - I think we should stick
with the existing code since I do not fund the new code much easier to
read.

Thanks.

-- 
Dmitry
