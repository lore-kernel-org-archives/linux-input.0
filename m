From: Manoj <manoj.iyer@canonical.com>
Subject: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Tue, 05 Apr 2011 09:53:04 -0500
Message-ID: <4D9B2CD0.20404@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35192 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab1DEOzQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 10:55:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

The Lenovo X220 has a touch pad and a track point.  I would like to get 
some clues as to if there is any work around in the kernel for the issue 
I am seeing below:

Case 1: Touchpad and Trackpoint enabled in BIOS.
================================================
In this case the touchpad works correctly, but the trackpoint is not 
detected at all. Some times after random number of reboots, the 
trackpoint will start to respond approximately 15mts after X starts. But 
the mouse will be detected as PS2 Generic Mouse.

Case 2: Touchpad Disabled Trackpoint Enabled in BIOS
======================================================
In this case the trackpoint works as expected, and it is detected as 
TPPS/2 IBM TrackPoint.
[    9.675396] input: TPPS/2 IBM TrackPoint as 
/devices/platform/i8042/serio1/input/input9

I suspect this is a BIOS bug? Is it possible to work around this in the 
kernel?


-- 
Manoj Iyer
Ubuntu/Canonical
Hardware Enablement
