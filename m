From: Daniel Drake <dsd@laptop.org>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup control
Date: Thu, 28 Jul 2011 15:59:32 +0100
Message-ID: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
References: <20110728143121.E57469D401C@zog.reactivated.net>
	<Pine.LNX.4.44L0.1107281051220.1990-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55389 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1G1O7d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 10:59:33 -0400
Received: by fxh19 with SMTP id 19so1343781fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 07:59:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1107281051220.1990-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org

On 28 July 2011 15:53, Alan Stern <stern@rowland.harvard.edu> wrote:
> Shouldn't this also check device_may_wakeup(dev)? =A0The user might
> disable wakeup for the input device while leaving it enabled for the
> i8042 device.

As far as I'm aware, there aren't any instances where input devices
are marked as wakeup-capable. So, we're speaking theoretically.

But, what would this mean? On OLPC for example, we can only control
i8042 wakeups. This means we don't get to choose that we want keyboard
wakeups and not mouse. If you enable i8042 wakeups you get both, and
we can't change that, as the wakeup mechanism revolves around the
i8042 controller.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
