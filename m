From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/4 v3] Input: wacom - add SW_TOUCH to include/uapi/linux/input.h
Date: Fri, 15 Nov 2013 15:33:30 -0600
Message-ID: <CAGzDe_ZsthR-QVHmut9eZue5ybOCKLRqh8-0V0y=rCRR=_pgeQ@mail.gmail.com>
References: <1384545602-15549-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55033 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3KOVdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 16:33:31 -0500
Received: by mail-wg0-f41.google.com with SMTP id n12so2551155wgh.2
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 13:33:30 -0800 (PST)
In-Reply-To: <1384545602-15549-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pingc@wacom.com>

On Fri, Nov 15, 2013 at 2:00 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> New Intuos series models added a hardware switch to turn touch
> data on/off. To report the state of the switch, SW_TOUCH
> is added in include/uapi/linux/input.h.
>

Any status on your patch to add SW_TOUCH event?  Maybe you should
resend since its been a while and this patch depends on it.

Chris
