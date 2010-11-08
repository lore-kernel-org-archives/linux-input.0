From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Mon, 8 Nov 2010 08:41:10 -0500
Message-ID: <AANLkTimPKkvdWWTPoWGCRmp-biwup1dEQpaKYEk8t9ED@mail.gmail.com>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
	<20101107060147.GC3823@core.coreip.homeip.net>
	<AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
	<4CD7F6A7.8040206@redhat.com>
	<AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36427 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab0KHNlk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 08:41:40 -0500
Received: by ewy7 with SMTP id 7so2751733ewy.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 05:41:39 -0800 (PST)
In-Reply-To: <AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

On Mon, Nov 8, 2010 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> To achieve plug and play at least one of four choices has to happen:

There is another option, the IR maps get integrated into user space
keyboard mapping package. This may be possible with the new
libxkbcommon package.

-- 
Jon Smirl
jonsmirl@gmail.com
