From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Thu, 11 Feb 2010 15:36:16 +0800
Message-ID: <f17812d71002102336k9654c4cwea9dcd9df9d9f357@mail.gmail.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
	<20100208180625.GB1469@ucw.cz> <f17812d71002081715w485b33bbx3f67afb86c6d8ee1@mail.gmail.com>
	<20100209090918.GA12642@core.coreip.homeip.net> <f17812d71002090423j4f02225av24e5af0227e0809d@mail.gmail.com>
	<f17812d71002090433g35504bccwa58460c395847f80@mail.gmail.com>
	<20100211070808.GE8252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:2434 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab0BKHgo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 02:36:44 -0500
Received: by qw-out-2122.google.com with SMTP id 9so198094qwb.37
        for <linux-input@vger.kernel.org>; Wed, 10 Feb 2010 23:36:36 -0800 (PST)
In-Reply-To: <20100211070808.GE8252@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

> Re-applied (with just removing 'default y' instead of replacing with
> 'default n' which is the same thing).
>

Ah, yes, that's much cleaner. Thanks Dmitry.
