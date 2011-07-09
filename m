From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 3/4] Fix hover in Android (Gingerbread)
Date: Fri, 8 Jul 2011 23:15:08 -0700
Message-ID: <CAMu+ixhnAXoSEvjt+aC=imnXx-b8uM8TYWWWoV2U99WMJJU-kQ@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com> <1310072700-2829-3-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab1GIGPu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 02:15:50 -0400
Received: by bwd5 with SMTP id 5so2193819bwd.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 23:15:48 -0700 (PDT)
In-Reply-To: <1310072700-2829-3-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>

On Thu, Jul 7, 2011 at 2:04 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> As of Gingerbread, Android does not pay attention to if the pen
> is in contact with the screen, or merely in proximity. Since the
> Xorg Wacom driver does not make use of MT pen events, we simply
> do not emit MT data while hovering.

I'd rather not change the behavior of the upstream driver because that
would break other things.  It would be better to just fix the Android
framework code for the device you are shipping.

What is it about Gingerbread that causes problems with hover?  Is it
the fact it isn't checking BTN_TOUCH or the fact that it doesn't care
when ABS_MT_PRESSURE == 0?  (Is BTN_TOUCH still relevant to the MT
protocol or only in single-touch?)

I have already added hover support to Android.  It will appear in an
upcoming release, along with support for the MT slots protocol "B".

Sending a non-zero ABS_MT_DISTANCE is also a good robust hint for
hover.  Zero pressure can be ambiguous sometimes.

Who did you talk to at Google about this?

Jeff.
