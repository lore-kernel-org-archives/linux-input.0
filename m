From: simon@mungewell.org
Subject: Re: fftest: Upload effects[0]: Function not implemented
Date: Tue, 17 Jan 2012 17:28:16 -0500
Message-ID: <c0a085d97e81f211fc647da982c450ca.squirrel@mungewell.org>
References: <CAM1yFZ8A8oHhZ9m7=69mekAPZQhpaSvKk8bVqZiDTtCeYLAhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50590 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2AQW2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 17:28:18 -0500
In-Reply-To: <CAM1yFZ8A8oHhZ9m7=69mekAPZQhpaSvKk8bVqZiDTtCeYLAhGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org


> How to counter this? No, I am not running any game. I just wanted to
> apply these effects to my wheel.
> Please help.
>
> -Anisha

Hi Anisha,
Do you have the appropriate FF module built and loading in your kernel, it
was recently moved to be enabled with 'LOGIWHEELS_FF' and is supported by
the code in 'drivers/hid/hid-lg4ff.c'

Can you check '/var/log/syslog' to see what it reported when the wheel is
connected?

Simon

PS. I have this wheel at it would appear to work fine.

