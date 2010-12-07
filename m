From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3] hid: egalax: Convert to MT slots
Date: Tue, 07 Dec 2010 21:06:30 +0100
Message-ID: <4CFE93C6.7020808@euromail.se>
References: <1291722851-22909-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1012071554050.14806@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:39417 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753200Ab0LGUHs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Dec 2010 15:07:48 -0500
In-Reply-To: <alpine.LNX.2.00.1012071554050.14806@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/07/2010 03:54 PM, Jiri Kosina wrote:

> On Tue, 7 Dec 2010, Henrik Rydberg wrote:
> 
>> The firmware in the joojoo reports touches sequentially, one per
>> report, which confuses the current driver. A further complication is
>> the absense of any indication of a touch frame. This patch converts
>> the driver to the MT slots protocol, and outputs one full touch frame
>> per report. This way, proper handling for both firmwares is ensured.
>>
>> Tested-by: Philipp Merkel <mail@philmerk.de>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Thanks,
> 


Much obliged. As agreed, will appear through Dmitry's tree.

Thanks,
Henrik

