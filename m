From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 21:36:43 +0800
Message-ID: <CAAj6DX2_ZwFqpKD5JjbWuJw7SJv3G+DhpnD6tZAoDcF32GQ=0Q@mail.gmail.com>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
	<20150714114917.GG1517@katana>
	<alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1507141452140.7522-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Cc: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 14, 2015 at 8:54 PM, Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org> wrote:
> On Mon, 13 Jul 2015, Ellen Wang wrote:
>
>> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
>> the data to be written is in "command" not "data->byte".
>>
>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>> ---
>> Forgot signed-off-by tag last time, sorry.
>
> Applied to for-4.3/cp2112.
>
> On Tue, 14 Jul 2015, Wolfram Sang wrote:
>
>> Wow, that driver seems to be largely untested. Thanks for cleaning it
>> up! Sidenote: i2c drivers should really be in drivers/i2c ;)
>
> Well, it's sometimes a bit on the borderline where HID drivers should live
> (because they often, in addition to HID layer, make use of some other
> transport). If you want to move it under your wings, please send a patch
> that moves it and I'll Ack it.


This is a MFD; should be split in GPIO and I2C, then each part moved
in its respective tree.

Anyone already working in this direction?

Regards,
Antonio
