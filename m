From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe fail	before	retrying
Date: Mon, 19 Apr 2010 11:33:08 -0400
Message-ID: <4BCC77B4.5030703@canonical.com>
References: <4BC8EA42.6030507@canonical.com>	 <1271502098.4155.27.camel@lovely>  <4BC9D444.3090802@canonical.com> <1271523195.3676.5.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54110 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab0DSPdK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 11:33:10 -0400
In-Reply-To: <1271523195.3676.5.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input@vger.kernel.org, rubini@cvml.unipv.it

Retesting here and I've found that with i8042.reset=1,
i8042_controller_selftest is returning 0. The reason I'm
not seeing any messages is because there's nothing to
complain about at this level.

   202 pm-suspend(6228):  -> i8042_controller_selftest
         i8042_controller_selftest args []
         i8042_controller_selftest locals [param=0x0 i=?]
   206 pm-suspend(6228):   -> i8042_command
         i8042_command args [param=0xf3715e2f command=0x1aa]
         i8042_command locals [flags=? retval=?]
exit    798 pm-suspend(6228):   -> i8042_command
i8042_command args [return=0x0]
exit    800 pm-suspend(6228):  -> i8042_controller_selftest

You can see from the triage notes here:
https://bugzilla.kernel.org/show_bug.cgi?id=15780

That psmouse can't even identify the device.

        param[0] = 0xa5;
        if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
                return -1;

With regards to windows... What am supposed to be able to find out? 
Of course it works, but how am I supposed to crack open the driver
to find out what it's doing? Thanks.

Peter

On 04/17/2010 12:53 PM, Christoph Fritz wrote:
> Hi
> 
> Am Samstag, den 17.04.2010, 11:31 -0400 schrieb Peter M. Petrakis:
>> Hi,
>>
>> i8042.reset=1 was one the first things we tried and it didn't
>> improve the situation. Now looking at the code for
>> i8042_controller_reset, I don't recall seeing these printks
>> though I could double check.
> 
> And as far as I recall, you should see them.
> 
>>  Any other suggestions for
>> resets or instrumentation?
> 
> not really, maybe you can check what windows (without vendor drivers)
> does
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
