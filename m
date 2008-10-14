From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Need for 'nomux' has been rising lately ...
Date: Tue, 14 Oct 2008 19:59:01 +0400
Message-ID: <48F4C1C5.9090006@suse.de>
References: <alpine.LNX.1.10.0810141652090.26779@jikos.suse.cz> <20081014111522.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:42961 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751572AbYJNP7E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:59:04 -0400
In-Reply-To: <20081014111522.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>

Dmitry Torokhov wrote:
> Hi Jiri,
> 
> On Tue, Oct 14, 2008 at 04:55:22PM +0200, Jiri Kosina wrote:
>> Hi Dmitry,
>>
>> lately, I have been seeing a couple of bug reports in which touchpad of 
>> certain notebooks misbehaved, and i8042.nomux solved the problem. Most 
>> recently, this happened on [1]. Do you have any idea what might be the 
>> cause of the need for nomux rising so much lately? Apparently, some older 
>> kernels behaved correctly even without this workaround, at least on Acer 
>> Aspire 5710, as referenced in the bugreport.
>>
> 
> I am always happy to blame ACPI code (especially EC) for bad
> iteraction with input devices ;), especially since there weren't any
> significant changes to i8042 in any recent kernels. Do you think the
> person reporting the failure on Acer could try bisecting it? Could
> ALexey Starikovskiy have any ideas whether there is bad EC iteractions
> stopping timely delivery of mouse interrupts?
> 
There was an issue with EC interrupt storm on several Acer notebooks lately,
hopefully solved (bug 11549).
Symptoms could be that keyboard/mouse are slow, missing keys, etc.
I suggest you should try the patch in 11549, or acpi-test tree, and see if your
problem goes away...

Regards,
Alex.
