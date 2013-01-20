From: simon@mungewell.org
Subject: Support for Steelseries SRW-S1 in progress
Date: Sat, 19 Jan 2013 19:27:09 -0500
Message-ID: <8ef34405feec3732c3de78686371356e.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:51255 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3ATBbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jan 2013 20:31:09 -0500
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1Twikf-0001zc-S9
	for linux-input@vger.kernel.org; Sat, 19 Jan 2013 19:27:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,
I've started working on a module for the SRW-S1 which requires a HID
descriptor patch to get it going (basis 'usage page simulator' -> 'usage
page desktop').

If you're interested see:
http://community.speed-dreams.org/viewtopic.php?f=3&t=210

One question I have is whether there's a way to control how Linux labels
the buttons. With my WIP driver jstest reports
--
# jstest /dev/input/js0
Driver version is 2.1.0.
Joystick (SteelSeries SRWheel) has 5 axes (X, Y, Z, Hat0X, Hat0Y)
and 17 buttons (BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect,
BtnStart, BtnMode, BtnThumbL, BtnThumbR, ?, ?, ?, ?, (null)).
--

The bit allocation vs. labeling on the device is as follows
--
d1 ff 00 00 00 0f 00 00 00 f0 ff ff ff ff ff ff
|| || || || || || || || ||  + Assist val (0-3)
|| || || || || || || || +| Assists  (0-b)
|| || || || || || || ||  + Steer Sens (0-b)
|| || || || || || || +| Gear Right (8)
|| || || || || || || +| Speed Limiter (4)
|| || || || || || || +| Launch Control (2)
|| || || || || || || +| HUD (1)
|| || || || || || ||  + Horn (8)
|| || || || || || ||  + Boost (4)
|| || || || || || ||  + Look Right (2)
|| || || || || || ||  + Camera (1)
|| || || || || || +| Gear Left (8)
|| || || || || || +| Request Pit (4)
|| || || || || || +| F.Brake Balance (2)
|| || || || || || +| R.Brake Balance (1)
|| || || || || ||  + Look Back (8)
|| || || || || ||  + Lights (4)
|| || || || || ||  + Look Left (2)
|| || || || || ||  + Back (1)
|| || || || || +| Select (8)
|| || || || ||  + DPad/Hat (F=Null,0-7)
|| || || +| ++ Break Axis (0-3ff)
|| || ++  + Accel Axis (0-3ff)
++ ++ Steer Axis (f8f8-0708)
--

Are such labels worthwhile, or even available? Or should I just ignore
this aspect of the driver?

Simon

