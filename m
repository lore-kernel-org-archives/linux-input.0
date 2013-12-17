From: simon@mungewell.org
Subject: Re: [PATCH 0/4] Input: ABS2 and friends
Date: Tue, 17 Dec 2013 16:28:41 -0500
Message-ID: <190d226e64e177a3cb631b8fc6f4787c.squirrel@mungewell.org>
References: <1387295334-1744-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:42294 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab3LQV2n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 16:28:43 -0500
In-Reply-To: <1387295334-1744-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Antonio Ospite <ospite@studenti.unina.it>, linux-kernel@vger.kernel.org, input-tools@lists.freedesktop.org, David Herrmann <dh.herrmann@gmail.com>

> Hi
>
> This implements the recently discussed ABS2 API. It's working fine on my
> machine with libevdev. Comments welcome!

Just looking at the documentation file, I have a couple of suggestions.

1). Make a note on the direction of gravity wrt the example image. Ie what
which axis/value will be positive with the device laid flat/stationary on
a desk. Might just prevent some confusion later.

2). Calibration, Accels and Gyros are noisy in different ways. Gyros tend
to be wrong in the long term, giving some consistant bias which should be
calibrated out. Accels are noisy in the short term, but generally right
over a long period.

Am I correct that the event framework will provide time-stamping of data,
thus making computation of relative movements possible.

Simon


