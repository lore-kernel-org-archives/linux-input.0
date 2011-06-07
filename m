From: simon@mungewell.org
Subject: Re: HID joystick - Axis 11 non operational.
Date: Tue, 7 Jun 2011 12:35:08 -0400
Message-ID: <457e6c50552d90d62fb265caa488add1.squirrel@host171.canaca.com>
References: <9c3f08ce41f278fc835bf09e489eef0f.squirrel@host171.canaca.com>
    <20110603161511.af4dd9e0.ospite@studenti.unina.it>
    <20110604224546.7ebb8939.ospite@studenti.unina.it>
    <20110607123931.2267a703.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:43800 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1FGQfK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2011 12:35:10 -0400
In-Reply-To: <20110607123931.2267a703.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org

I'll try to find some time to test this...

> when I get code == 0x30 (ABS_MT_TOUCH_MAJOR, I am still not sure
> where from), with the following hack I can make axis 11 work again but I
> have no idea if I am broking MultiTouch devices, anyone?
>

If the root of the problem is with the Sixaxis, can we not
re-allocate/re-map which HID events it produces so that the rest of the
system sees what it is expecting?

If this is likely to be a problem with other devices interfering with the
MultiTouch stuff then I guess we should fix it properly,
Simon.


