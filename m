From: Bastien Nocera <hadess@hadess.net>
Subject: Trying to remap a wrongly labelled key
Date: Thu, 22 Jan 2009 16:08:34 +0000
Message-ID: <1232640514.3330.665.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39319 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZAVQIv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2009 11:08:51 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0MG8olW022970
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2009 11:08:50 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0MG8pvo026769
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2009 11:08:51 -0500
Received: from [10.11.12.53] (vpn-12-53.rdu.redhat.com [10.11.12.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0MG8ohe002933
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2009 11:08:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heya,

This Dell keyboard has a "media" key, with a music note on it. The
problem is that it's KEY_CONFIG I get instead of KEY_MEDIA.

So I'm trying to fix the problem in user-space. This is one of the
snippets I've tried to use:

        int codes[2];
        codes[0] = 0x183;
        codes[1] = KEY_MEDIA;
        if (ioctl (fd, EVIOCSKEYCODE, codes) < 0)
                perror ("Set keycode failed");

I inserted that into evtest.

# ./evtest /dev/input/event6 
Input driver version is 1.0.0
Input device ID: bus 0x3 vendor 0x413c product 0x2010 version 0x110
Input device name: "Dell Dell USB Keyboard Hub"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
<snip>
    Event code 171 (Config)
<snip>
Set keycode failed: Invalid argument

So there's a key for which the scancode corresponds to KEY_CONFIG. It
should be 0x183 according to the HUT. but it doesn't want to work for
me...

I'm using 2.6.27.9

Cheers

