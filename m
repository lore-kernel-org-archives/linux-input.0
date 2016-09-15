From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: joydev - Recognize joysticks with Z axis as
 joysticks.
Date: Thu, 15 Sep 2016 15:35:48 -0700
Message-ID: <20160915223548.GA29897@dtor-ws>
References: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34327 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcIOWfw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 18:35:52 -0400
Received: by mail-pa0-f65.google.com with SMTP id vz6so2649201pab.1
        for <linux-input@vger.kernel.org>; Thu, 15 Sep 2016 15:35:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Ranki <ville.ranki@iki.fi>
Cc: linux-input@vger.kernel.org

On Thu, Aug 25, 2016 at 05:16:50PM +0300, Ville Ranki wrote:
> Current implementation of joydev's input_device_id
> table recognizes only devices with ABS_X, ABS_WHEEL
> or ABS_THROTTLE axes as joysticks.
> 
> There are joystick devices that do not have those axes,
> for example TRC Rudder device. The device in question
> has ABS_Z, ABS_RX and ABS_RY axes causing it not being
> detected as joystick.
> 
> This patch adds ABS_Z to the input_device_id list
> allowing devices with ABS_Z axis to be detected
> correctly.
> 
> Signed-off-by: Ville Ranki <ville.ranki@iki.fi>

Applied, thank you.

Although I wonder if we could not move joydev implementation to
userspace in the long run.

Thanks.

-- 
Dmitry
