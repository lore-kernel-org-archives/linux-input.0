From: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Subject: Re: Issues detecting i8042 AUX port
Date: Thu, 29 Oct 2009 23:25:52 +1100
Message-ID: <4AE989D0.1070302@urbanec.net>
References: <4ACB533A.7080001@urbanec.net> <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pecan.exetel.com.au ([220.233.0.17]:50612 "EHLO
	smtp.po.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbZJ2MZw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2009 08:25:52 -0400
In-Reply-To: <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Jiri Kosina wrote:
> On Wed, 7 Oct 2009, Peter Urbanec wrote:
>> In a nutshell, I can run the same kernel on the same hardware and on
>> some boots the AUX port will not be detected and on other boots it will
>> come up fine.
> 
> Does booting with 'i8042.noloop' improve the situation?

Jirko,

Thanks for the suggestion. I have been testing the i8042.noloop 
workaround for a few weeks now. So far I have not not experienced any 
problems when booting with that option. I would say that the workaround 
can be declared as being effective.

I also applied Dmitry's patch to log the timeout condition when 
detecting the AUX port. Without the i8042.noloop option, the AUX port 
detection fails intermittently, but when it does, it causes an aux irq 
test timeout, which coincides with uhci_hcd USB hub initialisation. 
Perhaps the USB code somehow causes the loss of this interrupt.

Adding the DMI info for the machine to the i8042_dmi_noloop_table is 
perhaps not the most correct fix for the underlying problem, but it does 
get results.

Here is the relevant dmidecode data for the laptop:

Handle 0x0001, DMI type 1, 27 bytes
	Header and Data:
		01 1B 01 00 01 02 03 04 43 4E 46 37 33 38 35 30
		51 44 00 1B 24 AC 45 81 06 05 06
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		48 50 20 50 61 76 69 6C 69 6F 6E 20 64 76 39 35
		30 30 20 4E 6F 74 65 62 6F 6F 6B 20 50 43 20 20
		20 20 00
		"HP Pavilion dv9500 Notebook PC    "
		52 65 76 20 31 00
		"Rev 1"
		43 4E 46 37 33 38 35 30 51 44 00
		"CNF73850QD"
		47 53 37 34 38 55 41 23 41 42 41 20 00
		"GS748UA#ABA "
		31 30 33 43 5F 35 33 33 35 4B 56 00
		"103C_5335KV"

Best regards,

	Peter Urbanec
