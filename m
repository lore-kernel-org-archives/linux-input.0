From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Mon, 21 May 2012 00:23:11 -0500
Message-ID: <20120521051825.GB3840@burratino>
References: <4FB939B5.4000309@gmx.com>
 <20120520192052.GA3959@burratino>
 <4FB951A0.6020102@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45252 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2EUFXT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 01:23:19 -0400
Received: by yenm10 with SMTP id m10so4003137yen.19
        for <linux-input@vger.kernel.org>; Sun, 20 May 2012 22:23:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB951A0.6020102@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicola Alessi <nialessi@gmx.com>
Cc: linux-input@vger.kernel.org, jj_ding@emc.com.tw

Nicola Alessi wrote:

> [    6.734445] psmouse serio4: elantech: unexpected magic knock result 0x3c, 0x03, 0x3c.
>
> I hope this can help.

Yes, thanks much.

One more question: how do you know this touchpad is an Elantech pad?
E.g., is there another OS with a driver that detects it as Elantech?

Based on [1] it seems the Amilo Pi 2515 ships with a variety of
different touchpad models.

Jonathan

[1] https://bugzilla.kernel.org/show_bug.cgi?id=10942
