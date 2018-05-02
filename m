From: David Engraf <david.engraf@sysgo.com>
Subject: Re: [PATCH] Input: serio - add writing multiple bytes at once
Date: Wed, 2 May 2018 09:07:59 +0200
Message-ID: <c7ae7509-a29d-85e1-a8da-41e275e98779@sysgo.com>
References: <20180430090324.30845-1-david.engraf@sysgo.com>
 <20180430212007.GC54182@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430212007.GC54182@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 30.04.2018 at 23:20, Dmitry Torokhov wrote:
> Hi David,
> 
> On Mon, Apr 30, 2018 at 11:03:24AM +0200, David Engraf wrote:
>> The current version only supports forwarding a single byte to the tty
>> layer.
>>
>> This patch adds serio_write_length() to allow a serport driver writing
>> multiple bytes at once. The patch also includes a fallback to
>> serio_write_length() when a driver did not register a single byte function.
> 
> Without users I do not see point for this API.

Here is an incomplete list of drivers calling serio_write() in a loop:

- drivers/media/usb/rainshadow-cec/rainshadow-cec.c
- drivers/input/serio/serio_raw.c
- drivers/input/touchscreen/elo.c

I can simplify these drivers by using serio_write_length() if you want 
to have some users for the new API.

Best regards
- David
