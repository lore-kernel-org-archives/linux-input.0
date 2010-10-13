From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module parameter
Date: Wed, 13 Oct 2010 19:15:15 +0100
Message-ID: <AANLkTikMU71nE4NCYtoP7WXwjrfD6hiBY6XuBMKCu-Yx@mail.gmail.com>
References: <20101002204235.052959D401B@zog.reactivated.net>
	<20101004174533.GC8321@core.coreip.homeip.net>
	<AANLkTinHiCWBb+wZT9niBfGWd3Q-X448CdtMC8yD0NtF@mail.gmail.com>
	<201010051023.34120.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51767 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0JMSPS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 14:15:18 -0400
Received: by iwn9 with SMTP id 9so91763iwn.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 11:15:18 -0700 (PDT)
In-Reply-To: <201010051023.34120.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Hi Dmitry,

On 5 October 2010 18:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> You just need to make sure that X actually uses Synaptics (xf86-input-
> synaptics) with your device, emitting BTN_TOOL_FINGER should help a lot.

Thanks a lot for your help- this got me on track.

Have you had a chance to look at the revised version of the patch?
Input: hgpk - support GlideSensor and PenTablet modes
https://patchwork.kernel.org/patch/236081/

Thanks,
Daniel
