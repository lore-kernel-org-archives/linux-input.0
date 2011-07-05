From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 05/12] Input: synaptics - process button bits in AGM packets
Date: Tue, 05 Jul 2011 11:19:55 -0700
Message-ID: <4E1355CB.9070504@canonical.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org> <1309324042-22943-6-git-send-email-djkurtz@chromium.org> <20110704212404.GC23915@polaris.bitmath.org> <CAGS+omALkYhzS+rvWhsXCwuWMHWpJJJ7j9Z9cBQ1Gem5HnH_fg@mail.gmail.com> <20110705181843.GA29296@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:58889 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1GESUB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 14:20:01 -0400
In-Reply-To: <20110705181843.GA29296@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Daniel Kurtz <djkurtz@chromium.org>, dmitry.torokhov@gmail.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 07/05/2011 11:18 AM, Henrik Rydberg wrote:
>>> Any particular reason to move these and leave them unassigned for clickpads?
>>
>> Yes.  The current implementation incorrectly parses the x, y, z of AGM
>> packets and assigns junk values to the corresponding fields of the
>> temporary hw struct.  Luckily, this struct is then just discarded upon
>> return (synaptics_parse_hw_state returns 1 causing
>> synaptics_process_packet() to exit immediately).
>>
>> Instead, this patch parses the w value first to determine the packet
>> type, and then use this packet type information to parse the remaining
>> position and pressure fields correctly...
>>
>> Notice that the "else" clause is taken for SGM packets (w != 2), even
>> for clickpads.
> 
> Functionally, there is no difference between assigning new junk or
> reusing old junk, hence that part of the patch is not strictly needed.

True, it's not necessary, but I do like the new flow better. I was
reviewing the patch myself when I started wondering why we ever assigned
junk that was incorrect. I think this will help clean up the code and
make it more readable.

-- Chase
