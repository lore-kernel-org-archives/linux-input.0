From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Add logical min and max
Date: Mon, 02 Dec 2013 17:14:08 +0000
Message-ID: <b2e31404-966e-4f1a-a85b-a01fa63064b9@email.android.com>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5299CCAA.6090100@kernel.org> <alpine.LNX.2.00.1312021408290.24931@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52365 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3LBROS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 12:14:18 -0500
In-Reply-To: <alpine.LNX.2.00.1312021408290.24931@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org

Hi Jiri

I tend to push a testing branch to catch any build issues before pushing to the real togreg branch. Normally there are only a few hours on between but sometimes it is a few days as here.  I will move these to the fixes-togreg branch - hopefully this evening...

Jiri Kosina <jkosina@suse.cz> wrote:
>On Sat, 30 Nov 2013, Jonathan Cameron wrote:
>
>> On 11/27/13 22:19, Srinivas Pandruvada wrote:
>> > Exporting logical minimum and maximum of HID fields as part of the
>> > hid sensor attribute info. This can be used for range checking and
>> > to calculate enumeration base for NAry fields of HID sensor hub.
>> > 
>> > Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>
>> Hi,  I would have preffred this being done in two patches, the first
>> refactoring the function call and the second doing the min and max.
>> 
>> Anyhow, I'll take it anyway.
>> 
>> Applied to the togreg branch of iio.git.
>
>Where is that? I don't seem to see it in 
>
>	https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=togreg

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
