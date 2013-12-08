From: Zachary Lund <admin@computerquip.com>
Subject: Xpad Driver Replacement
Date: Sun, 08 Dec 2013 00:18:01 -0600
Message-ID: <52A40F19.3020109@computerquip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:41646 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759074Ab3LHGSL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Dec 2013 01:18:11 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so1720754yhn.4
        for <linux-input@vger.kernel.org>; Sat, 07 Dec 2013 22:18:10 -0800 (PST)
Received: from [10.8.0.10] (li40-72.members.linode.com. [72.14.178.72])
        by mx.google.com with ESMTPSA id c44sm7986252yho.20.2013.12.07.22.18.09
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 22:18:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I created a new driver to hopefully eventually replace xpad. The driver 
in its current form can be found on github. Things it provides is 
cleaner module unload/load, possibly cleaner/more efficient code, and 
better LED support. There are caveats that I'd like to iron out before I 
submit a patch though.

For one, I do not have the original Xbox controller. I've only tested 
the official Xbox 360 Wired and Wireless controllers. So support for 
that is unfortunately missing. I'm not sure how I feel about ripping it 
out of xpad. What am I supposed to do about devices that I don't own?

Secondly, the Xbox 360 controllers claim to be HID compliant... this is 
not an HID driver. That's because the report descriptor is missing and 
I, unfortunately, do not know what to do about that. Some drivers like 
XBCD and the driver found at tattiebogle.net both provide their own 
report descriptor and work from there. While I'd like to do the same 
eventually, it will take me longer than a week to do that as I'd have to 
educate myself on HID and figure out what to do about the missing 
descriptors.

Thirdly, I have had no other testers outside of myself. And the only 
products I've tested are the only items in the device_id list. So, if 
anyone can test, that would amazing. I've posted on several forums and 
IRC channels for help testing or new products with unfortunately zero 
results. Anyone who is able to test and just use it extensively, that 
would be much appreciated.

The code in its current form is found on github: 
https://github.com/computerquip/xpad360wr

Any advice or feedback would be much appreciated.
