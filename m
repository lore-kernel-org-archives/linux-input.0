From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet
 data
Date: Wed, 6 Apr 2016 21:51:07 +0200
Message-ID: <570568AB.8010501@bitmath.org>
References: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
 <CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
 <56E17A73.8090901@bitmath.org>
 <CADYu30-b+5TFh2yy2SrGTJJ7FzvcezWut1XL3Ypno5R29hyYww@mail.gmail.com>
 <20160401215128.GA5216@dtor-ws>
 <CADYu309K20ki1oMMTGmGQ+CmftCELoSFZfv704YZ_hzmzQG1kQ@mail.gmail.com>
 <CADYu3083da+hW_uLg3WWqgotvOZD1f3V3TdabgX6gDTY93GB7w@mail.gmail.com>
 <20160406173848.GC38452@dtor-ws>
 <CADYu308OF98jdbsqpSVdQpTa0sEafuQmVuC=ttN3-1u59_QvmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:53620 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbcDFTux (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 15:50:53 -0400
In-Reply-To: <CADYu308OF98jdbsqpSVdQpTa0sEafuQmVuC=ttN3-1u59_QvmA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi Aniroop,

>> I am not sure what the urgency is. It is more of a theoretical problem
>> ans so far the proposed solutions were actually introducing more
>> problems than they were solving.
>>
>> I am sorry, bit this particular topic is not a priority for me.
>>
> 
> There is no hurry at all. :-) As you know request is made a long time ago,
> so I am only very curious to complete it.

This kind of patch is not liked by any maintainer, because it does not solve any
immediate problem, but instead may create one. If such a simple patch takes
three of four tries to look right, it only adds to the perception that the code
is best left alone.

I think the solution at this stage is to say no to this patch.

If there is ever a driver for which the input_estimate_events_per_packet()
function returns less than the actual maximum number of events per frame, this
issue can be revisited and resolved in a number of different ways.

Sorry, and thanks for your work.

Henrik

