From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] HID: support i2c write-read and large transfers in hid-cp2112
Date: Thu, 18 Jun 2015 16:36:37 +0800
Message-ID: <CAAj6DX34G84MUq5p6kjRo4+7gBqn3DWy5DFBbcnuYx4ckjAkuw@mail.gmail.com>
References: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
	<CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
	<55821717.2000609@cumulusnetworks.com>
	<CAAj6DX3aFvTdaE8GTh3YvFsnadbtszkyeArnFCuuhbtQnGu9kw@mail.gmail.com>
	<20150618082624.GB1519@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150618082624.GB1519@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 18, 2015 at 4:26 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> Mine is rev 1 !!!
>> Found also that in the datasheet chapter 12 reports the differences
>> between the two revisions.
>> In 12.1 it states that revision 1 does not implement repeated start. Perfect!
>> I will try to replace my device with a newer one.
>
> Can this be checked in the code?

You are right!
The code should check the revision and allow read-after-write for rev2
only. Or better, return error on rev1; we can expect any further
revision will implement it correctly.
Definitevy the revision can be retrieved by SW and used for the check.
Today rev# is already retrieved during probe() and printed. Should be
enough to keep it in a new field of the private date struct.

Thanks for the hint.
Antonio
