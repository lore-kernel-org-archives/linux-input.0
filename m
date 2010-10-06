From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 0/2] HID: hidraw, fix two NULL pointer dereferences
Date: Wed, 06 Oct 2010 12:09:07 +0200
Message-ID: <4CAC4AC3.60507@gmail.com>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>	<1286292017-6746-1-git-send-email-ospite@studenti.unina.it>	<4CAB94A0.8040402@gmail.com> <20101006120129.52da81d3.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101006120129.52da81d3.ospite@studenti.unina.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org, stable@kernel.org
List-Id: linux-input@vger.kernel.org

On 10/06/2010 12:01 PM, Antonio Ospite wrote:
> On Tue, 05 Oct 2010 23:12:00 +0200
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> On 10/05/2010 05:20 PM, Antonio Ospite wrote:
>>> here are some fixes to hidraw.
>>>
>>> Patches are against 2.6.36-rc6, but they should be ported to other
>>> maintained stable kernels as well.
>>>
>>> Antonio Ospite (2):
>>>   HID: hidraw, fix a NULL pointer dereference in hidraw_ioctl
>>>   HID: hidraw, fix a NULL pointer dereference in hidraw_write
>>
>> Hi, please fix also the window in hidraw_release.
>>
> 
> I am not sure I get what you mean, can you please add more details?

Sure. Look at the code:
if (!hidraw_table[minor])
        return -ENODEV;
...
dev = hidraw_table[minor];
if (!--dev->open) {
...

This is done without minors_lock, so you can easily have dev being NULL
even though the first if.

regards,
-- 
js
