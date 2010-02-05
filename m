From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Fri, 5 Feb 2010 17:04:28 +0100
Message-ID: <520f0cf11002050804r184dc59bha6ba8b78e7f75909@mail.gmail.com>
References: <201001302257.09354.arnd@arndb.de>
	 <520f0cf11002011518y22c2f097s87872e7b5b1690d7@mail.gmail.com>
	 <20100203050749.GA22110@core.coreip.homeip.net>
	 <201002040832.09805.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201002040832.09805.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 4, 2010 at 8:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 03 February 2010, Dmitry Torokhov wrote:
>> OK, so how about the patch below? If it is accepted I will just swit=
ch
>> to
>>
>> =A0 =A0 =A0 =A0 nonseekable_open(inode, file);
>> =A0 =A0 =A0 =A0 return 0;
>>
>> style. I gonna add Al and akpm to CC to see if the patch will stick.=
=2E.
>
> Sounds reasonable, if only to prevent this from becoming a FAQ.
>
>> VFS: clarify that nonseekable_open() will never fail
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> --

Acked-by: John Kacur <jkacur@redhat.com>
