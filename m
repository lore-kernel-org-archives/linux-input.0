From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Handling of non-positional data through evdev
Date: Tue, 15 Mar 2016 23:59:13 +0100
Message-ID: <1458082753.4785.27.camel@hadess.net>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49535 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcCOXA4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 19:00:56 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id E731547BA33
	for <linux-input@vger.kernel.org>; Tue, 15 Mar 2016 23:59:17 +0100 (CET)
In-Reply-To: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>, linux-input@vger.kernel.org

On Tue, 2016-03-15 at 12:26 -0700, Roderick Colenbrander wrote:
> Hi all,
> 
> I'm working on a device driver for an input device, which has both
> directional axes in addition to sensors (accelerometer and gyro). I'm
> trying to figure out how to map these axes properly, but I'm
> stumbling
> on some road blocks.

Depending on what your device is, you might be looking for the IIO sub-
system instead, which hosts most of the sensor-type drivers.

iio-sensor-proxy is one of the daemon that can consume data from it
(even if somewhat unelegantly these days).

Cheers
