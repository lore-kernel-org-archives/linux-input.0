From: Alessio Sangalli <alesan@manoweb.com>
Subject: Notification when a new device is added or removed
Date: Fri, 27 Feb 2009 20:35:03 -0800
Message-ID: <49A8BEF7.9060602@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59597 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbZB1EfL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 23:35:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, what is the easiest way to get somewhat notified when a device is
added or removed from the system? I know /proc/bus/input/devices reports
the devices list, can I make use of that? I am in an embedded
environment where I prefer not having to bringup all the hotplug + udev
infrastructure.

bye
Alessio

