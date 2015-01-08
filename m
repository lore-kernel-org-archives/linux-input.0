From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: NULL pointer dereference in i2c-hid
Date: Thu, 8 Jan 2015 15:58:54 -0800
Message-ID: <54AF19BE.9010506@synaptics.com>
References: <31518562.V5Oyo0POsI@xps13> <2094646.ov2KaAkedO@xps13> <548B3E32.2050503@synaptics.com> <1877487.FqOELR9dBu@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1877487.FqOELR9dBu@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

On 12/24/2014 03:53 PM, Gabriele Mazzotta wrote:
[...snip...]
>>>> Also, if you can get the firmware id from your touchpad that would also
>>>> be useful.
>>>>
>>>> $ sudo ./rmihidtool -f /dev/hidraw0
>>> firmware id: 1522295
>> Thanks, I will see if I can get any additional information on this.
>>
>> Andrew
> Hi,
>
> I think I found the source of the problem.
>
> $ ./rmihidtool /dev/hidraw1 -r 0x50 1
> 0x01  #PalmDetect Interrupt Enable, right?
Yes, 0x50 does appear to be the address of the palm detect interrupt 
enable register.
> $ ./rmihidtool /dev/hidraw1 -w 0x50 0  #Disable PalmDetect Interrupt
>
> It makes more sense now that widths greater than 12 trigger the bug.
That is weird behavior and I haven't seen anything like that before. I 
will file a bug to see if firmware has any idea why this is happening.
>
> Gabriele
>
Andrew
