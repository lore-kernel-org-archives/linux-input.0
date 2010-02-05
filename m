From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Fri, 05 Feb 2010 02:27:39 -0500
Message-ID: <4B6BC86B.9090102@seas.upenn.edu>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu> <20100205055302.GA17121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:34127 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933606Ab0BEHdc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 02:33:32 -0500
In-Reply-To: <20100205055302.GA17121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com

Will do.

Dmitry Torokhov wrote:
> On Thu, Feb 04, 2010 at 10:52:43PM -0500, Rafi Rubin wrote:
>  +
>> +		if (matched < nd->contact_count) {
>> +			for (i = 0; i < nd->contact_count; i++) {
>> +				if (nd->contacts[i].logical_id < 0) {
>> +					for (j = 0; j < nd->prev_contact_count;
>> +					     j++) {
>> +						if (nd->
>> +						    prev_contacts[j].confidence
>> +						    &&
>> +						    (contact_map
>> +						     [nd->
>> +						      prev_contacts
>> +						      [j].logical_id] < 0)
>> +						    &&
>> +						    (abs
>> +						     (nd->contacts[i].x -
>> +						      nd->prev_contacts[j].x) <
>> +						     nd->max_width)
>> +						    &&
>> +						    (abs
>> +						     (nd->contacts[i].y -
>> +						      nd->prev_contacts[j].y) <
>> +						     nd->max_height)) {
>> +							nd->contacts
>> +							    [i].logical_id =
>> +							    nd->prev_contacts
>> +							    [j].logical_id;
>> +							contact_map
>> +							    [nd->prev_contacts
>> +							     [j].logical_id]
>> +							    = i;
>> +							matched++;
> 
> OK, this kind code just makes me want to poke my eyes with a fork... 5
> times...
> 
> Seriously, either factor it out into a nice function, or say "screw it"
> to the 80 columt limit, or maybe both. Anything but this.
> 
> Thanks.
> 
