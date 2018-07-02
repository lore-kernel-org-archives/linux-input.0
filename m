From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Mon, 2 Jul 2018 08:32:56 -0700
Message-ID: <57436c8d-c188-500d-5764-5df4208d53b0@infradead.org>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw> <20180622001632.GI79890@dtor-ws>
 <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws>
 <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
 <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com>
 <87sh5196pk.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh5196pk.fsf@purkki.adurom.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On 07/02/2018 05:12 AM, Kalle Valo wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
>> On July 1, 2018 5:00:03 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> The reason it got messed up is I switched to pulling patches from
>>>> patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so
>>> I
>>>> do not have to add them manually, but unfortunately it does not do
>>>> proper UTF-8:
>>>
>>> Ugh.
>>>
>>> I made an 'issue' of it for patchwork:
>>>
>>>  https://github.com/getpatchwork/patchwork/issues/194
>>>
>>> and hopefully that can be fixed. It's sad when we corrupt names like
>>> this.
>>
>> Might not even be an issue with recent patchwork, but unfortunately
>> the version that is running on kernel.org is ancient as far as I know.
> 
> FWIW I use patchwork.kernel.org and I don't have any issues with UTF-8
> characters in the From header. For example, here's one patch which I
> recently applied:
> 
> https://git.kernel.org/linus/88001968245c
> 
> But of course it depends on what tools you use (I have my own patchwork
> script which downloads and applies the patch) or what characters there
> were etc. 
> 
> Also I heard that we should get an upgrade to patchwork.kernel.org in
> the near future, which is great. The current version has some quirks
> which are quite annoying.
> 

I don't know if it's better or different, but there is also
https://lore.kernel.org/patchwork/


-- 
~Randy
