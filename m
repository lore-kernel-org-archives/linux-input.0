From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Introduce light-weight contact tracking
Date: Thu, 11 Nov 2010 11:53:02 +0100
Message-ID: <4CDBCB0E.2020005@euromail.se>
References: <1289161108-32309-1-git-send-email-rydberg@euromail.se> <4CD724BC.8020702@seas.upenn.edu> <4CD80FCB.20903@euromail.se> <4CD82B28.4060706@seas.upenn.edu> <4CD84A81.3000208@euromail.se> <4CDB7C05.1090306@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51677 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab0KKKxO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 05:53:14 -0500
In-Reply-To: <4CDB7C05.1090306@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chasedouglas@gmail.com>, Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On 11/11/2010 06:15 AM, Rafi Rubin wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
>> For every (number of used slots, number of current contacts) pair, two
>> consecutive arrays of values are generated. The first contains the matrix
>> indices corresponding to a certain mapping from contacts to slots. The second
>> contains the actual slot assignment.
>>
>> To find the optimal matching, one simply scans through the appropriate index
>> array, extracting the slot assignment corresponding to the minimum sum of matrix
>> elements. This process is combinatorial and in general scales much worse than
>> for instance the hungarian algorithm, but for small numbers, it can be
>> implemented with very good speed.
> 
> It occurs to me that it might be a good idea to restate our goals and assumptions.


The main goal of my patch is to device a simple, stable, parameter-free matching
function that can be used in interrupt context. If you have such a function,
about a hundred lines of code, completes in a couple of hundred cycles, tested
and benchmarked in the mtdev framework, and which can do six fingers, I would be
happy to use that instead. Otherwise, I suggest we focus on this patch.

> So that's why I selected the approach and data structures I used.  Now if you
> can tell me the studio 17 is going to be the only device that will ever run
> these routines that has more than 4 contacts and is not tracked, then sure,
> screw it.  I have no reason to believe that is a good assumption.


The N-trig device is the only device in the kernel that requires special ghost
filtering. All other devices send reliable data, and either have fewer contacts,
handle their own tracking, or send all data to userspace. Future devices will
most likely have tracking capabilities, and even if they do not, protocol A and
mtdev handles that case. Thus, the question is really whether a new device would
produce unreliable contact data. I find that unlikely.


> Even if we do want to limit the code to 4 contacts, we still need some motion
> estimation, particularly for the lower frame rate devices.


Second-order methods for a device that does not even produce zeroth-order
contact data? As far as I know, the first-order tracking in mtdev has not
disappointed anyone yet, so your statement seems to need elaboration.

Henrik
