From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: 35022: hid-magicmouse broken
Date: Tue, 17 May 2011 15:14:27 -0400
Message-ID: <4DD2C913.4000403@canonical.com>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:33924 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397Ab1EQTOc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 15:14:32 -0400
In-Reply-To: <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On 05/17/2011 08:56 AM, Jiri Kosina wrote:
> On Tue, 17 May 2011, Chase Douglas wrote:
> 
>> Hi Jiri,
>>
>> I've received a few emails about the magicmouse driver being broken on
>> 2.6.39:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=35022
>>
>> It seems hid_output_raw_report() is returning a different (incorrect?)
>> value than in the past. Do you know what might be going on?
> 
> So we are getting EIO from the transport-level _raw callback.
> 
> Hmm, commit 0825411ade seems like a suspect here. Might be possible that 
> magicmouse doesn't send ACK back, right?
> 
> Could you please try reverting that commit and re-test?

Yes, reverting that commit makes it work.

I'm just speculating here, based on commit message names and what you've
said, that the magicmouse is not protocol compliant because it is not
sending an ACK back? What do you think we should do in the driver?
Should we ignore the return, or should we look specifically for EIO?
(neither sounds very good to me, so I'm hoping you have a better
solution :).

Thanks!

-- Chase
