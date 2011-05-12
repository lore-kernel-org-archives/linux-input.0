From: simon@mungewell.org
Subject: Re: [RFC PATCH] input: Add wiichuck driver
Date: Thu, 12 May 2011 02:24:59 -0400
Message-ID: <0bcda95e38da7ce6fd696075f6d61baf.squirrel@host171.canaca.com>
References: <20110512042218.12859.66600.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58527 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab1ELGZD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 02:25:03 -0400
In-Reply-To: <20110512042218.12859.66600.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

> This patch adds a driver for the Nintendo Nunchuck (wiimote accessory)
> attached to an i2c bus via something like a wiichuck adapter board
> from Sparkfun.
>

I have not tested your driver, will try to find some time next week.

There are also a handful of devices which can be connected as such:
http://www.wiibrew.org/wiki/Wiimote/Extension_Controllers

You might want to consider the possibility that the Nunchuck/Others are
connected via a MotionPlus, in which case the data is interleaved with
Gyro data.

Simon.

PS. If you're really cheap you can (ab)use the I2C DDC link of the VGA
port to connect devices.... it's what I do :-)


