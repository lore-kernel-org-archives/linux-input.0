From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Documented input device properties.
Date: Tue, 10 Jan 2012 10:59:50 +0100
Message-ID: <4F0C0C16.20005@canonical.com>
References: <1326127454-11695-1-git-send-email-jussi.pakkanen@canonical.com> <20120109175551.GC15083@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49182 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952Ab2AJJ7w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 04:59:52 -0500
In-Reply-To: <20120109175551.GC15083@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On 01/09/2012 06:55 PM, Dmitry Torokhov wrote:
> Hi Jussi,
> 
> On Mon, Jan 09, 2012 at 06:44:14PM +0200, Jussi Pakkanen wrote:
>> ---
>>  Documentation/input/event-codes.txt |   27 +++++++++++++++++++++++++++
>>  1 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
>> index 23fcb05..7c515a5 100644
>> --- a/Documentation/input/event-codes.txt
>> +++ b/Documentation/input/event-codes.txt
>> @@ -220,6 +220,33 @@ EV_PWR:
>>  EV_PWR events are a special type of event used specifically for power
>>  mangement. Its usage is not well defined. To be addressed later.
>>  
>> +Device properties:
>> +=================
>> +
>> +INPUT_PROP_POINTER:
>> +------------------
>> +There is a one to one mapping between the device coordinates and
>> +screen coordinates.
> 
> This is not correct as touchpads fall firmly into INPUT_PROP_POINTER
> land and certainly do not have 1:1 relationship between on-screen and
> device coordinates.

Yeah, the definition of this should be inverted. (This is my mistake, as
I gave Jussi the wrong definition when he was writing this up.)

>> This property only has meaning for non-touch based
>> +input such as a pen or an eraser. A drawing tablet would have this property
>> +set.
> 
> Wacom Bamboo touch can be said is touch based but still is a pointer
> device. Basically pointer device is one that requires use of an
> on-screen pointer to reflect user's movement while with direct devices
> touching object itself serves as a pointer to the user.

This definition, while usually correct, is mixing properties and policy.
We had a discussion about this:

http://thread.gmane.org/gmane.linux.kernel.input/21565/focus=21658

The definitions in this patch try to reflect the outcome of that discussion.

-- Chase
