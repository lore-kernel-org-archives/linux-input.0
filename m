From: Joshua Clayton <joshua.clayton@uniwest.com>
Subject: What is a good uart input driver module to start with?
Date: Thu, 02 Jul 2015 13:09:05 -0700
Message-ID: <2173074.iXvIKYmzqh@jclayton-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.61]:54775 "EHLO
	atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753357AbbGBUJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 16:09:10 -0400
Received: from atl4mhob01.myregisteredsite.com (atl4mhob01.myregisteredsite.com [209.17.115.39])
	by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id t62K9965031905
	for <linux-input@vger.kernel.org>; Thu, 2 Jul 2015 16:09:09 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.207])
	by atl4mhob01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id t62K97cJ029255
	for <linux-input@vger.kernel.org>; Thu, 2 Jul 2015 16:09:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>

Hello Linux input users,

I have an embedded system for which I would like to write an input driver.

The device is a CPLD connected to a uart on my system, with several buttons
that I would like to represent as keyboard keys, as well as two arrays of 
input pins that are treated as axes. 

We have a working user space driver, which uses but it suffers from very high 
latency when the system is under load.

I have read Documentation/input.txt and input-programming.txt.
I'm just trying not to reinvent the wheel when it comes to a serial device 
with a non-standard way of expressing keys.

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
(509) 544-0720
