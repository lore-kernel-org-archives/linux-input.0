From: Chris@vger.kernel.org, Hudson@vger.kernel.org
Subject: [PATCH]input: Add support for Kionix KXTJ9 accelerometer
Date: Fri, 13 May 2011 14:13:25 -0400
Message-ID: <1305310406-9870-1-git-send-email-chudson@kionix.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kionix.com ([66.152.113.154]:58303 "EHLO mail.kionix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab1EMSN2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2011 14:13:28 -0400
Received: from mail1.kionix.com (localhost [127.0.0.1])
	by mail.kionix.com (Spam Firewall) with ESMTP id ADED72625E0
	for <linux-input@vger.kernel.org>; Fri, 13 May 2011 14:13:26 -0400 (EDT)
Received: from mail1.kionix.com ([10.0.0.125]) by mail.kionix.com with ESMTP id 7MI8CYeXXmtdwBrT for <linux-input@vger.kernel.org>; Fri, 13 May 2011 14:13:26 -0400 (EDT)
In-Reply-To: <>
References: <>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds support for the Kionix KXTJ9 digital tri-axis accelerometer.  
The driver uses i2c for hardware communication, input for passing data to the 
application layer, and sysfs to handle system calls.  There were a few warnings 
when I ran checkpatch.pl, all concerning the use of kstrto* in preference to 
simple_strtoul but am concerned that this change may affect backwards 
compatibility.  Please let me know if I need to change anything in order to get 
this merged.
