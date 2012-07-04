From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Input: MT - Include win8 support
Date: Tue, 03 Jul 2012 17:59:24 -0700
Message-ID: <4FF3956C.7020608@canonical.com>
References: <1340785690-13652-1-git-send-email-rydberg@euromail.se> <20120703175842.GA472@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54190 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab2GDA7a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jul 2012 20:59:30 -0400
In-Reply-To: <20120703175842.GA472@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, benjamin.tissoires@gmail.com, peter.hutterer@who-t.net, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/03/2012 10:58 AM, Henrik Rydberg wrote:
> On Wed, Jun 27, 2012 at 10:28:10AM +0200, Henrik Rydberg wrote:
>> The newly released HID protocol for win8 multitouch devices is capable
>> of transmitting more information about each touch. In particular, it
>> includes details useful for touch alignment. This patch completes the
>> MT protocol with the ABS_MT_TOOL_X/Y events, and documents how to map
>> win8 devices.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>> Hi all,
>>
>> Here is the patch following the RFC on win8 MT support. An ascii-art
>> version of the figure has been included, Peter's orientation text is
>> there, and the usage section has been extended with more semantics and
>> mappings. Hopefully the similarities and differences between the
>> models are clearer now. Also, the usage of azimuth has been left out,
>> awaiting an actual device using it.
>
> I would like to have a couple of ACK's on this patch, if
> possible. Please? :-)

I read it through and let it sit a bit to try to figure out if there 
were any issues I could see. I don't see any, so:

Acked-by: Chase Douglas <chase.douglas@canonical.com>
