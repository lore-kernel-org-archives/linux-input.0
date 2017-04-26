From: AZO <typesylph@gmail.com>
Subject: Re: [PATCH] drivers: input: joystick: Add PSX (Play Station 1/2) pad
 with SPI driver.
Date: Wed, 26 Apr 2017 20:46:13 +0900
Message-ID: <CAE35y5ttmgNPkr+z64w3Hb6yauPogPfw7x+b+AegwvZ4e3Mhug@mail.gmail.com>
References: <20170425144422.9179-1-typesylph@gmail.com> <20170426105224.3bfe4b9a2d9f07f58b22ac10@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170426105224.3bfe4b9a2d9f07f58b22ac10@ao2.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Mr.Ospite

Hi. Thanks to teaching me a lot.

I as much as possible comply rule for Linux developing.
I can't write my mind in English, as you said. (XD)
But, I'll continuously study more Linux and Git and English!
And I can write in C language to work some devices.

>> PSX pads can be connected directry SPI bus.
>                                   ^
>                            "directly"

I'm sorry to my cheap English...

>   git format-patch --subject-prefix='PATCH vX' ...

> Further annotations can also go after the '---' separator.

I wanted to tell a version and what is changes,
I looked for this writing.
I'll use this.

> For more details look at  Documentation/SubmittingPatches in the linux
> kernel tree.

I will read it carefully.

>   Input: psxpad-spi - Add PSX (Play Station 1/2) pad SPI driver

I'll fix next time.

>   ./scripts/checkpatch.pl --ignore LONG_LINE,LONG_LINE_COMMENT your.patch

I use that script with no option.
I'll use useful options too.

> reviewers can see what the changes between the current patch and
> the previous versions are.

> Also try to comment when you do not agree with the reviewer or cannot
> comply (for example about using an interrupt instead of polling).

I get diff usually, between original source and my changed it.
But developing on Git, I know not recommend this method,
developing must as time goes by.

I just worry to send my code rightly.

I thanks you and maintainer Mr.Torokhov, patiently reception.

Regard.

---
AZO<typesylph@gmail.com>


2017-04-26 17:52 GMT+09:00 Antonio Ospite <ao2@ao2.it>:
> On Tue, 25 Apr 2017 23:44:22 +0900
> AZO <typesylph@gmail.com> wrote:
>
>> PSX pads can be connected directry SPI bus.
>                                   ^
>                            "directly"
>
> and add "to the" before SPI.
>
>>
>> Signed-off-by: AZO <typesylph@gmail.com>
>> ---
>
> Hi,
>
> I haven't looked at the code but I have some general comments.
>
> When submitting another iteration of a patch it's common practice to
> mention the version in the Subject (e.g. [PATCH v3] ...), you can use:
>
>   git format-patch --subject-prefix='PATCH vX' ...
>
> It is also useful to provide a changelog of the versions, so that
> reviewers can see what the changes between the current patch and
> the previous versions are. This changelog goes after the '---'
> separator and before the diffstat, this way git will ignore it when the
> patch is applied, it's meant for the review process and it doesn't need
> to go in the commit message of the final version.
>
> Further annotations can also go after the '---' separator.
>
> For more details look at  Documentation/SubmittingPatches in the linux
> kernel tree.
>
> Also try to use a subject line consistent with the subsystem, by
> looking at the history of the files in the same directory.
>
> In this case it could be something like:
>
>   Input: psxpad-spi - Add PSX (Play Station 1/2) pad SPI driver
>
> Finally, script/checkpatch.pl suggests some minor issues, I tried with:
>
>   ./scripts/checkpatch.pl --ignore LONG_LINE,LONG_LINE_COMMENT your.patch
>
> You can ignore some of them, and motivate your decision in an
> annotation.
>
> Also try to comment when you do not agree with the reviewer or cannot
> comply (for example about using an interrupt instead of polling).
>
> It's fine if your English is not perfect yet, don't let that stop you :)
>
> Ciao ciao,
>    Antonio
>
> --
> Antonio Ospite
> https://ao2.it
> https://twitter.com/ao2it
>
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
