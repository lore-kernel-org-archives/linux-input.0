From: Dwayne Litzenberger <dlitz@patientway.com>
Subject: evdev interface question: ABS_X without ABS_Y?
Date: Wed, 26 Oct 2011 17:10:23 -0400
Message-ID: <8A5EDD26-9BFD-4DAE-9C88-8E8D0908CE8B@patientway.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45636 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab1JZVKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Oct 2011 17:10:24 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E7FD421134
	for <linux-input@vger.kernel.org>; Wed, 26 Oct 2011 17:10:23 -0400 (EDT)
Received: from [192.168.3.178] (static-209-87-231-210.storm.ca [209.87.231.210])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B33554086E4
	for <linux-input@vger.kernel.org>; Wed, 26 Oct 2011 17:10:23 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a quick question about the /dev/input/eventX interface with userspace.

Let's say I have a touchscreen, and I move my finger to (200,100).  I'll see something line this (simplified):

  EV_ABS ABS_X 200
  EV_ABS ABS_Y 100
  EV_SYN

Next, let's say I see something like this:

  EV_ABS ABS_Y 90
  EV_SYN

What is the meaning of that, from the perspective of userspace?  I see two possibilities.  Either:

1. It's a move to (200,90), or
2. It's a move to (0,90)

Which is the correct interpretation?  Is this documented anywhere?

Apparently, the usbhid driver is generating events that imply #1, but xserver-xorg-input-evdev interprets these according to #2.  I'm trying to figure out what needs to be patched.  :)

-- 
Dwayne Litzenberger
PatientWay | Access Management Platform
Toll Free: +1-888-786-8929 x29
Tel: +1-613-369-8325 x29
Web: http://www.patientway.com/
Email: dlitz@patientway.com

PatientWay is hiring! http://www.patientway.com/careers

