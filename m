From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 0/6] Input: xpad: updates and refactoring
Date: Sun, 13 Sep 2015 14:04:14 +0200
Message-ID: <55F5663E.70403@gmail.com>
References: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33648 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbIMMER (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Sep 2015 08:04:17 -0400
Received: by wiclk2 with SMTP id lk2so109392407wic.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2015 05:04:16 -0700 (PDT)
In-Reply-To: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org

feel free to ask for details. If you have no objections, please merge.

Am 05.09.2015 um 22:58 schrieb Pavel Rojtberg:
> From: Pavel Rojtberg <rojtberg@gmail.com>
>
> This series contains several bug-fixes and updates for the xpad driver.
> They are loosely sorted in order of controversy.
>
> Patch 1 just adds a new device id for the Xbox One controller. The original
> patch was sent to me via github: https://github.com/paroj/xpad/pull/9
>
> Patches 2-4 are minor refactorings of the code that should make it
> more maintainable.
>
> Patch 5 makes the x360 wireless pads support the x360 wired button interface.
> See the commit message for details and a link to the preceding discussion.
>
> Patch 6 fixes issues of the x360 wireless pads after suspend/ resume.
>
> Erik Lundgren (1):
>    Input: xpad: add Covert Forces edition of the Xbox One controller
>
> Pavel Rojtberg (5):
>    Input: xpad: clarify LED enumeration
>    Input: xpad: remove needless bulk out URB used for LED setup
>    Input: xpad: factor out URB submission in xpad_play_effect
>    Input: xpad: x360w: report dpad as buttons and axes
>    Input: xpad: reset usb device on resume
>
>   drivers/input/joystick/xpad.c | 286 +++++++++++++++++++++++++++--------------------------------------
>   1 file changed, 119 insertions(+), 167 deletions(-)
>

