From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Half second spend in i8042 during suspend on TUXEDO BU1406
Date: Thu, 9 Feb 2017 10:17:56 +0100
Message-ID: <47598acc-5634-0426-43c9-7cb9bde13910@molgen.mpg.de>
References: <234cc57f-6922-d866-e457-66eb2cafb85d@molgen.mpg.de>
 <20170208235826.GA28058@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.molgen.mpg.de ([141.14.17.9]:57381 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751954AbdBIJSF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Feb 2017 04:18:05 -0500
In-Reply-To: <20170208235826.GA28058@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Dear Vojtech,


On 02/09/17 00:58, Vojtech Pavlik wrote:
> On Wed, Feb 08, 2017 at 02:12:44PM +0100, Paul Menzel wrote:
>
>> On the TUXEDO BU1406 [1] the Linux kernel (tested with 4.10-rc{6,7})
>> takes over a second to get into suspend [2]. For whatever reason
>> around 550 ms are spent in `i8042_set_mux_mode()` (cf. attached
>> /*
>>  * Internal loopback test - send three bytes, they should come back
>> from the
>>  * mouse interface, the last should be version.
>>  */
>>
>>         param = val = 0xf0;
>>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != val)
>>                 return -1;
>>         param = val = multiplex ? 0x56 : 0xf6;
>>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != val)
>>                 return -1;
>>         param = val = multiplex ? 0xa4 : 0xa5;
>>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == val)
>>                 return -1;
>> ```
>>
>> Is that a hardware limitation, or even an error as such long delays
>> are not allowed according to some standard?
>
> It looks like an EC firmware bug not handling the CMD_AUX_LOOP command
> correctly.
>
>> Is there anything, that can be done about this, to get into S3 state faster?
>
> Does it still happen if you specify i8042.nomux=1 on the kernel command
> line?

Starting Linux with that, the delay is gone.

Before:

 > i8042 @ i8042 {i8042} sync_device (Total Suspend: 546.038 ms Total 
Resume: 3.850 ms)

After:

 > i8042 @ i8042 {i8042} sync_device (Total Suspend: 0.973 ms Total 
Resume: 1.369 ms)

What downsides are there of using that `i8042.nomux=1`? Is any 
functionality lost?

> If that helps, it can be added to a blacklist based on DMI.

Sounds good.

```
$ journalctl -k | grep 'DMI:'
Feb 09 10:15:04 helmuth-N24-25BU kernel: DMI: Notebook 
       N24_25BU/N24_25BU, BIOS 5.12 10/11/2016
```


Kind regards,

Paul
