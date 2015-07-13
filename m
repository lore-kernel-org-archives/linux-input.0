From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Mon, 13 Jul 2015 15:28:25 -0700
Message-ID: <55A43B89.6050600@cumulusnetworks.com>
References: <1436504871-3676-1-git-send-email-ellen@cumulusnetworks.com> <alpine.LNX.2.00.1507131320060.7522@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1507131320060.7522-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Cc: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 7/13/2015 4:20 AM, Jiri Kosina wrote:
> On Thu, 9 Jul 2015, Ellen Wang wrote:
>
>> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
>> the data to be written is in "command" not "data->byte".
>
> This is missing Signoff.

Sorry.  I submitted v2.

> How serious is this bug in practice? Is this 4.2 material?

The driver segfaults without the fix, and this is a common operation. 
On the other hand, the cp2112 is an uncommon device.

(I would personally like all the cp2112 fixes to be in 4.1 eventually. 
They are all important functional improvements.)
