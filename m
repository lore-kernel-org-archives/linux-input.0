From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] HID: usbkbd: return proper error code
Date: Thu, 01 Sep 2016 23:28:01 +0530
Message-ID: <57C86C29.1070807@gmail.com>
References: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com> <alpine.LNX.2.00.1609011320050.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1609011320050.22028@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 01 September 2016 04:51 PM, Jiri Kosina wrote:
> On Wed, 31 Aug 2016, Sudip Mukherjee wrote:
>
>> Use proper error code instead of using -1 on failure to allocate
>> memory. We may use the error code later in the caller.
>
> But we don't. usb_kbd_probe() returns -ENOMEM in case usb_kbd_alloc_mem()
> fails anyway, so I fail to see the point of the change really.
>

Well, yes, we don't as of now.
When I was reading the code for something related to my day job I was a 
bit confused with -1 instead of a proper error code. I am sure there 
will be many others like me.
Its fine if you think the change is not needed.

regards
sudip
