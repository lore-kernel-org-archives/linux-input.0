From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: fix byte order in SMBUS operations
Date: Mon, 13 Jul 2015 15:33:21 -0700
Message-ID: <55A43CB1.1040702@cumulusnetworks.com>
References: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com> <alpine.LNX.2.00.1507131322180.7522@pobox.suse.cz> <20150713144109.GA8115@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150713144109.GA8115@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Cc: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 7/13/2015 7:41 AM, Wolfram Sang wrote:
> On Mon, Jul 13, 2015 at 01:23:52PM +0200, Jiri Kosina wrote:
>> On Thu, 9 Jul 2015, Ellen Wang wrote:
>>
>>> Change all occurrences of be16 to le16 in cp2112_xfer(),
>>> because SMBUS words are little endian, not big endian.
>>>
>>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>>
>> Alright, this means that I2C_SMBUS_WORD_DATA and I2C_SMBUS_PROC_CALL have
>> been terminally broken since the very beginning and noone noticed.
>>
>> Does this mean that those commands are in practice mostly unused anyway?
>> This is important for 4.2 vs 4.3 consideration.
>
> PROC_CALL is really rare. WORD_DATA depends on the setup, it is used.

Yes.  WORD_DATA is common.  It's probably become less used since Antonio 
implemented i2c operations.

I think this really means that the device itself is rarely used.  On the 
other hand, for the people who unfortunately have it, these are 
important fixes.
