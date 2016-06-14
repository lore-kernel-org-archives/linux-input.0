From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH v3] hid-sony: Prevent crash when rumble effects are still
 loaded at USB disconnect
Date: Tue, 14 Jun 2016 20:31:20 +0200
Message-ID: <aca61eb3-b3bd-e132-7eeb-d1ab9bfbab3d@m-reimer.de>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
 <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
 <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
 <01146ebc-3710-e3cd-812a-ca4f0ef84372@m-reimer.de>
 <768f4bf0-4b8d-7036-7ddd-1dc9ff4a171b@m-reimer.de>
 <650C9404-0604-4783-B8AC-A7FEC9A73676@gmail.com>
 <29a17dba-d98d-65a1-5949-2b74e00ecdf5@m-reimer.de>
 <a5670e69-cd2b-36c1-a3b6-5a11afedc16d@m-reimer.de>
 <575C4C44.4070401@gmail.com> <575C6345.6040203@gmail.com>
 <22b65c72-671a-51fc-db87-bdf9a927cf7f@m-reimer.de>
 <20160612155643.d2218913a4f9ff42dec938e3@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:36107 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbcFNSbd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 14:31:33 -0400
In-Reply-To: <20160612155643.d2218913a4f9ff42dec938e3@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Cameron Gutman <aicommander@gmail.com>, linux-input <linux-input@vger.kernel.org>, jikos@kernel.org, dmitry.torokhov@gmail.com

On 06/12/2016 03:56 PM, Antonio Ospite wrote:
> On Sun, 12 Jun 2016 12:01:31 +0200
> Manuel Reimer <mail+linux-input@m-reimer.de> wrote:
>
>> On 06/11/2016 09:15 PM, Cameron Gutman wrote:
> [...]
>>> I want to be sure we're on the right track though. Can you please resolve the address in the RIP register to a
>>> line number in hid-sony.c?
>>
>> Can you point me to some instructions on how to do this? The only way to
>> debug things, I currently know, is the "good old print(f/k)" debugging...
>>
>
> The return addresses are in the trace from the Oops, you can resolve
> them with objdump, see:
> https://ao2.it/en/blog/2010/11/02/bug-hunting-linux-kernel-land-unpretentious-primer
>
> Ciao,
>    Antonio

Thank you for this link and sorry for the late response.

This is my latest crash (abbreviated):

[  183.865163] ml_ff_playback start. Effect: 1 Value: 1
[  184.897065] ml_ff_playback start. Effect: 0 Value: 0
[  184.900069] hid-sony: Sending to uninitialized device failed!
[  184.956432] ml_ff_playback start. Effect: 1 Value: 0
[  184.957933] hid-sony: Sending to uninitialized device failed!
[  185.023015] ml_ff_playback start. Effect: 2 Value: 0
[  185.026143] hid-sony: Sending to uninitialized device failed!
[  190.863508] ml_effect_timer start
[  190.866803] BUG: unable to handle kernel NULL pointer dereference at 
00000000000000d8
[  190.866803] IP: [<ffffffffa037f33d>] sony_play_effect+0x2d/0x90 
[hid_sony]

Also contains some of my printk messages, so we now can actually see why 
the last sending attempts are happening (attempt to stop the effects).

My sony_play_effect is at 0x310 and with 0x2d added we are at 0x33d.

In my case:
      339:	4c 8d 63 04          	lea    0x4(%rbx),%r12
sony_play_effect():
/home/manuel/kernel/4.5.4/src/b/drivers/hid/hid-sony.c:1978
      33d:	88 83 d8 00 00 00    	mov    %al,0xd8(%rbx)
/home/manuel/kernel/4.5.4/src/b/drivers/hid/hid-sony.c:1979
	sc->right = effect->u.rumble.weak_magnitude / 256;
      343:	0f b6 42 13          	movzbl 0x13(%rdx),%eax
sony_schedule_work():
/home/manuel/kernel/4.5.4/src/b/drivers/hid/hid-sony.c:1059


So if I interpret this right, then the source for the crash is the 
assignment of the weak magnitude value to sc->right? Maybe sc already 
freed/zeroed?

Manuel
